class Application
  def call(env)
    @request = Rack::Request.new(env)
    
    #TODO: separate logic between classes
    status, headers, body = if request_from_customer_endpoint?
      [
        200,
        {"Content-Type" => "text/html"},
        [File.read("./views/customer_templates/#{endpoint_data['template_name']}.html")]
      ]
    else
      result = "Controllers::#{endpoint_data['controller'].capitalize}".constantize.send(action)
      @data = result.response

      template = ERB.new(
        File.read("./views/customer_templates/#{endpoint_data['template_name']}.html")
      )
      [
        200,
        {"Content-Type" => "text/html"},
        [template.result]
      ]
    end
  end

  def request_from_customer_endpoint?
    endpoint_data['is_custom']
  end

  def endpoint_data
    @endpoint ||= routes[@request.path] || {}
  end

  def routes
    return @routes if @routes

    @routes = JSON.parse(
      File.read('./config/routes.json')
    )
  end
end