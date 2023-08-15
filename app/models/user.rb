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

end
