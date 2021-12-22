module Controllers
  class Pages < Base
    def index
      routes = JSON.parse(
        File.read('./config/routes.json')
      )
      custom_fields = routes.select { |path, data| data['is_custom'] }

      self.response = custom_fields
    end

    def create
      File.open("./views/customer_templates/#{params['filename']}.html", 'w+') { |file| file.write(params['snippet']) }

      routes = JSON.parse(
        File.read('./config/routes.json')
      )

      routes[params['endpoint_path']] = {
        is_custom: true,
        template_name: params['filename']
      }

      File.write('./config/routes.json', routes.to_json)

      index
    end
  end
end
