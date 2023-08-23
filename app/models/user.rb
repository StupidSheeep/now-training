class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 他のユーザーをフォローしている関係
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id"
  has_many :following, through: :active_relationships, source: :followed

  # 自分をフォローしているユーザーの関係
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id"
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :bookmarks, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one_attached :profile_image

  def active_for_authentication?
    super && !is_deleted?
  end

  def inactive_message
    is_deleted? ? :deleted : super
  end


  # ユーザーをフォローしているかどうかを判定するメソッド
  def following?(other_user)
    following.include?(other_user)
  end

  # ユーザーをフォローするメソッド
  def follow(other_user)
    following << other_user
  end

  # ユーザーのフォローを解除するメソッド
  def unfollow(other_user)
    following.delete(other_user)
  end

  def followers_count
    followers.count
  end

  def following_count
    following.count
  end


  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'no-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

end
