class AddColumnToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :requested_date, :date
  end
end
