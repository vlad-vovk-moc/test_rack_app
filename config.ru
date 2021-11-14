require_relative 'config/boot'

class Application
  attr_accessor :status, :headers, :body

  def call(env)
    case env['REQUEST_PATH']
    when /button/
      @body = 'Haha, you pressed it'
    else
      @body = File.read('body.html')
    end

    response
  end

  def response
    [status, headers, [body]]
  end

  def status
    200  
  end

  def headers
    {"Content-Type" => "text/html; charset=utf-8"}
  end

  def body
    @body ||= 'Default body'
  end
end

run Application.new