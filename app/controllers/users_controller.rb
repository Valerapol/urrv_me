class UsersController < ApplicationController
  
  def index
    if params[:set_locale]
      redirect_to users_url(locale: params[:set_locale])
    end
    @users = User.all.order(created_at: :desc)
  end
  
end