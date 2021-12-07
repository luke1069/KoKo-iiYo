class Post < ApplicationRecord
  attachment :image

  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true
  # validates :image_id, presence: true

end
