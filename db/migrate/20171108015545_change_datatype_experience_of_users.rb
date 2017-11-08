class ChangeDatatypeExperienceOfUsers < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :experience, :string
  end
end
