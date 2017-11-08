class ChangeDatatypeColumnsOfMessages < ActiveRecord::Migration[5.1]
  def change
    change_column :messages, :conversation_id, :integer
    change_column :messages, :user_id, :integer
  end
end
