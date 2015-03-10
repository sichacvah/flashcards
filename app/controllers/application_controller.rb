class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_login, except: [:not_authenticated]
  before_action :set_locale

  helper_method :current_deck

  def current_deck
    @current_deck ||= current_user.current_deck
  end

  protected

  def set_locale
    locale  = if current_user
                current_user.locale
              elsif params[:locale]
                session[:locale] = params[:locale]
              elsif session[:locale]
                session[:locale]
              else
                http_accept_language.compatible_language_from(I18n.available_locales)
              end
    if locale && I18n.available_locales.include?(locale.to_sym)
      session[:locale] = I18n.locale = locale.to_sym
    end
  end

  def not_authenticated
    redirect_to root_path, alert: "Нужно войти."
  end
end
