class CmsController < ApplicationController
  prepend_view_path SqlTemplate::Resolver.instance

  def respond
    render template: params[:page]
  end
end
