# frozen_string_literal: true

require 'rails_helper'

# Это можно считать тестами контроллеров.
# Проверяет, что по заявленным ручкам с заявленными HTTP-методами будут корректные результаты.
RSpec.describe 'Links', type: :request do
  describe 'GET /' do
    it 'returns http success' do
      get root_url
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /link/add' do
    it 'redirects to root' do
      expect(get(link_add_url)).to redirect_to(root_url)
    end

    it 'returns http success' do
      post link_add_url
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /r/:slug' do
    # let - инициализация контекства перед каждым ТЕСТОМ (перед каждым it).

    let(:slug) { Faker::Lorem.word }

    let(:link) { Link.create url: Faker::Internet.url, slug: slug }

    it 'returns http redirect' do
      # Следующая строчка - это мок. Метод find_and_increment_clicks мы проверяем в модели, а тут он нас
      # не интересует. Единственное, что важно - это чтобы он вызвался с нужным значением. Мы его оборачиваем
      # в специальный дублер, который умеет понимать, что его вызвали и с какими аргументами это произошло.
      # Дублеры в разных языках/библиотеках разные, но конкретно в RSpec это работыет на один вызов.
      expect(Link).to receive(:find_and_increment_clicks).with(slug).and_return(link)
      expect(get(link_redirect_url(slug: slug))).to redirect_to(link.url)
    end
  end
end
