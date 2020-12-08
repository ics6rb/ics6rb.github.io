class ApplicationController < ActionController::Base
  include SessionHelper

  before_action :require_login

  private

  def require_login
    unless signed_in?
      flash[:danger] = 'Требуется логин'
      redirect_to session_login_url
    end
  end
end
