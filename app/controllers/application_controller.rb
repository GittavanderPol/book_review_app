class ApplicationController < ActionController::Base
  private
  def render_not_found
    render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
  end
end
