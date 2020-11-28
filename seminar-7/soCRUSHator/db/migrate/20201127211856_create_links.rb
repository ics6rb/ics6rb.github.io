# frozen_string_literal: true

class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      # null и default мы добавили руками - null: false означает, что поле обязательно для заполнения с точки зрения БД,
      # default: 0 - значение поля по умолчанию - 0.
      t.string :url, null: false
      t.string :slug, null: false
      t.integer :clicks, default: 0

      t.timestamps
    end
  end
end
