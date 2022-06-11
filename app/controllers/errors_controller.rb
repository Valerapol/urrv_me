class ErrorsController < ApplicationController
  skip_before_action :authenticate_user!
  def not_found
    render status: 404
    if params[:set_locale]
      redirect_to current_page(locale: params[:set_locale])
    end
  end

  def internal_server_error
    render status: 500
  end
end
