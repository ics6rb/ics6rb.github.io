# frozen_string_literal: true

class AddIndexToLinks < ActiveRecord::Migration[6.0]
  def change
    # В этой миграции мы добавили уникальный индекс на slug,
    # таким образом мы можем гарантировать уникальность даже при конкурентном доступе.
    add_index :links, :slug, unique: true
  end
end
