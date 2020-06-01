class Game < ApplicationRecord
  belongs_to :user
  has_many :posts
  
  validates :name, presence: true, length: { maximum:30 }
  validates :play_people, presence: true, length: { maximum:10 }
  validates :play_time, presence: true, length: { maximum:10 }
  validates :content, presence: true, length: { maximum:1000 }
  
end
