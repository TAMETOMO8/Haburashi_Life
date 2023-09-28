class Toothbrush < ApplicationRecord
  belongs_to :user

  validates :item_name, presence: true
  validates :item_url, presence: true
  validates :item_image_urls, presence: true
  validates :user_id, presence: true


  
end
