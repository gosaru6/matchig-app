class Post < ApplicationRecord
  validates :content, presence: true
  validates :title, presence: true
  validates :requested_date, presence: true
  belongs_to :user
end
