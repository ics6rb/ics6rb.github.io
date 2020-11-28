# frozen_string_literal: true

# Все, что нам нужно для работы со ссылками.
class LinkController < ApplicationController
  # Главная страница - просто отдает форму добавления ссылки.
  def index; end

  # Добавляет ссылку с базу.
  # Если запросить с методом get, редиректнет на /, это просто для улучшения UX.
  # Если запросить с методом post, постарается добавить ссылку в базу. Если получится, отрендерит страницу ссылки.
  # Не получится - отрендерит ошибку.
  # I18n.t :no_url_provided - это перевод. По умолчанию установлена русская локаль, все локали лежат в config/locales
  # Там ключу YAML-файла (например, no_url_provided) ставится в соответствие строка. Содержимое строки - перевод на язык.
  def add
    case request.method_symbol
    when :get
      redirect_to root_url
    else
      if params[:url]
        @link = Link.create_from_link(params[:url])
        @shorten_link = link_redirect_url slug: @link.slug
      else
        @error = I18n.t :no_url_provided
      end
    end
  end

  # В параметрах маршрута передается slug, ищется ссылка, увеличивается счетчик кликов, делается редирект.
  def redirect
    link = Link.find_and_increment_clicks params[:slug]
    not_found unless link
    redirect_to link.url
  end

  # Для сокращатора не нужен, но для 11 лабы - да.
  def all
    respond_to do |format|
      # Просто рендерит содержимое БД в виде XML.
      # Вообще говоря, НИКТО И НИКОГДА НЕ ОТДАЕТ ВСЮ БД, потому что там может ненормально огромное количество записей,
      # на считывание которого не хватит ни памяти, ни других ресурсов. Поэтому здесь это просто учебная задача.
      format.xml { render xml: Link.all.to_xml }
      # Обычно отдают по страницам.
      format.html { @links = Link.order(clicks: :desc).page params[:page] }
    end
  end
end
