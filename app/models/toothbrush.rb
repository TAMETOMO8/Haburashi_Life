class Toothbrush < ApplicationRecord
  belongs_to :user

  validates :item_code, presence: true
  validates :item_name, presence: true
  validates :item_url, presence: true
  validates :item_image_urls, presence: true
  validates :user_id, presence: true

  enum state: { using: 0, end_used: 1, cleaning: 2, recycling: 3 }
  enum brush_material: { nylon_hair: 0, animal_hair: 1, electric: 2, other: 3}
  enum hardness: { normal: 0, soft: 1, hard: 2 }
end
