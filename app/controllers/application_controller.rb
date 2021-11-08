class ApplicationController < ActionController::Base
  protect_from_forgery
  around_action :switch_locale
  before_action :authenticate_user!
  private
  
  def default_url_options
    {locale: I18n.locale}
  end

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
  def after_sign_in_path_for(resource)
    edit_user_registration_path
  end
  
  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end
  
  #def set_locale
  #  I18n.locale = extract_locale || I18n.default_locale
  #end
  #
  #def extract_locale
  #  parsed_locale = params[:locale]
  #  I18n.available_locales.map(&:to_s).include?(parsed_locale) ?
  #    parsed_locale.to_sym :
  #    nil
  #end
  
end
