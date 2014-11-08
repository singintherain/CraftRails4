class LiveAssetsController < ActionController::Base
  include ActionController::Live

  def hello
    while true
      response.stream.write "Hello World\n"
      sleep 1
    end

  rescue IOError
    response.stream.close
  end

  def sse
    response.headers['Cache-Control'] = 'no-cache'
    response.headers['Content-Type'] = 'text/event-stream'

    while true
      response.stream.write "event: reloadCSS\ndata: {}\n\n"
      sleep 1
    end

  rescue IOError
    response.stream.close
  end
end
