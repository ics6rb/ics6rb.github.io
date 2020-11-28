# frozen_string_literal: true

# Это кастотмный валидатор, который с помощью встроенного класса URI проверяет валидность строки
# c URL, переданной пользователем.
# Выбран именно EachValidator, чтобы валидация применялась к кажому полю (в нашем случае url) каждой модели.
class CorrectUriValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, I18n.t('invalid_url') unless value.present? && uri_correct?(value)
  end

  private

  def uri_correct?(value)
    uri = URI.parse(value)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    false
  end
end
