Dir['./controllers/*.rb'].each(&method(:require))

class Application
  def call(env)
    @request = Rack::Request.new(env)

    #TODO: separate logic between classes
    status, headers, body = if request_from_customer_endpoint?
      [
        200,
        {"Content-Type" => "text/html"},
        [
          File.read("./views/customer_templates/#{endpoint_data['template_name']}.html")
        ]
      ]
    else
      controller_instance = Object.const_get("Controllers::#{endpoint_data['controller'].capitalize}").new(@request.params || {})
      controller_instance.send(endpoint_data['action'])

      @data = controller_instance.response

      template = ERB.new(
        File.read("./views/#{endpoint_data['template_name']}.html.erb")
      )

      [
        200,
        {"Content-Type" => "text/html"},
        [
          template.result(binding)
        ]
      ]
    end
  end

  def request_from_customer_endpoint?
    endpoint_data['is_custom']
  end

  def endpoint_data
    @endpoint = routes[@request.path] || {}
  end

  def routes
    @routes = JSON.parse(
      File.read('./config/routes.json')
    )
  end
end
