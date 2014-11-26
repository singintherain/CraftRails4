class HomeController < ApplicationController
  def index
    render text: 'Hello', layout: true
  end
end
