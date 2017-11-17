class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user


  validates_presence_of :body, :conversation_id, :user_id
  def message_time
    created_at.strftime("%m/%d(#{%w(日 月 火 水 木 金 土)[Time.now.wday]}) %l:%M %p")
  end
end
