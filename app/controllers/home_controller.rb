class HomeController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index, :privacy_policy]
  def index
    if params[:set_locale]
      redirect_to home_url(locale: params[:set_locale])
    end
  end
  def privacy_policy
    if params[:set_locale]
      redirect_to privacy_policy_url(locale: params[:set_locale])
    end
  end

end
