module Controllers
  class Pages < Base
    def index
      routes = JSON.parse(
        File.read('./config/routes.json')
      )

      custom_fields = routes.select { |route| route['is_custom'] }

      self.response = custom_fields
    end

    def new
      
    end

    def create
      
    end
  end
end