class Post < ApplicationRecord

  belongs_to :user
  belongs_to :genre
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  has_one_attached :post_image

  validates :title, presence: true
  validates :target_time, presence: true
  validates :level, presence: true
  # validates :genre_id, presence: true(belongs to)
  validates :body, presence: true

  def get_post_image(width, height)
    unless item_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      item_image.attach(io: File.open(file_path), filename: 'no-image.jpg', content_type: 'image/jpeg')
    end
    item_image.variant(resize_to_limit: [width, height]).processed
  end

end
