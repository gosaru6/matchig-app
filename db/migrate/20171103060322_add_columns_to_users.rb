class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    add_column :users, :email, :string
    add_column :users, :password_digest, :string
    add_column :users, :image, :text
    add_column :users, :gender, :integer
    add_column :users, :age, :string
    add_column :users, :judgment, :boolean
  end
end
