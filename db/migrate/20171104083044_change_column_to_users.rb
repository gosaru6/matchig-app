class ChangeColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :judgment, :boolean
    add_column :users, :sort, :integer
  end
end
