class Post < ApplicationRecord

  belongs_to :user
  belongs_to :genre
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

end
