module Controllers
  class Base
    attr_reader :params
    attr_accessor :response

    def initialize(params)
      @params = params
    end
  end
end
