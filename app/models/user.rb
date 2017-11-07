class User < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :posts, dependent: :destroy
  has_many :messages, dependent: :destroy

  validates :name, presence: true, length: { maximum:30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :gender, presence: true
  validates :age, presence: true
  validates :sort, presence: true
  validates :experience, length: { maximum: 110 }

  before_save { email.downcase! }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
