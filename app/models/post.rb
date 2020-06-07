class Post < ApplicationRecord
  belongs_to :user
  
  mount_uploader :image1, ::ImageUploader
  mount_uploader :image2, ::ImageUploader
  
  
  has_many :favorites
  has_many :comments, dependent: :destroy
  has_many :liked, through: :favorites, source: :user
  
  validates :content, presence: true, length: { maximum:255 }
end
