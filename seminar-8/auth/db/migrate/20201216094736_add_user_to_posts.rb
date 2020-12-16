class AddUserToPosts < ActiveRecord::Migration[6.0]
  def change
    add_reference :posts, :user, null: true, foreign_key: true
  end
end
