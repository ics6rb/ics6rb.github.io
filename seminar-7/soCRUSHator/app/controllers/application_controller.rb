# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Чтобы локаль, если передана, бралась из параметров запроса.
  around_action :switch_locale

  # Чтобы легко и непринужденно кидать 404. То, что будет страница с ошибкой, норм,
  # потому что в продакшне эту ошибку "перехватит" nginx и отдаст нужную страницу.
  def not_found
    raise ActionController::RoutingError, 'Not Found'
  end

  private

  # Чтобы локаль, если передана, бралась из параметров запроса.
  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
end
