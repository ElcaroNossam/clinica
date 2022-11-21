class CreateCategoryUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :category_users do |t|
      t.integer :user_id
      t.integer :category_id
    end
  end
end
