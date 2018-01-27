class User < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :posts, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :active_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :passive_relationships, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  validates :name, presence: true, length: { maximum:30 }
  validates :email, uniqueness: true, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :gender, presence: true
  validates :age, presence: true, numericality: { only_integer: true, greater_than: 1 }
  validates :sort, presence: true
  validates :experience, length: { maximum: 150 }

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

  # 指定のユーザーをフォローする
  def follow!(other_user)
    active_relationships.create!(followed_id: other_user.id)
  end

  # フォローしているかどうかを確認する。
  def following?(other_user)
    active_relationships.find_by(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

end
