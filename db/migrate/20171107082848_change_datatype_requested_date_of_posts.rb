class ChangeDatatypeRequestedDateOfPosts < ActiveRecord::Migration[5.1]
  def change
    change_column :posts, :requested_date, :datetime
  end
end
