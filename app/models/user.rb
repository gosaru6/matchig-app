class User < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :posts, dependent: :destroy
  has_many :messages, dependent: :destroy

  validates :name, presence: true, length: { maximum:30 }
  validates :email, uniqueness: true, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :gender, presence: true
  validates :age, presence: true
  validates :sort, presence: true
  validates :experience, length: { maximum: 110 }

  before_save { email.downcase! }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  def self.search(search) #ここでのself.はUser.を意味する
    if search
      where(['name LIKE ?', "%#{search}%"]) #検索とnameの部分一致を表示。User.は省略
    else
      all #全て表示。User.は省略
    end
  end
end
