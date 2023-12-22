class Toothbrush < ApplicationRecord
  belongs_to :user
  has_many :dental_items, dependent: :destroy

  validates :user_id, presence: true

  enum state: { not_started: 0, using: 1, end_used: 2, cleaning: 3, recycling: 4 }
  enum brush_material: { nylon_hair: 0, animal_hair: 1, electric: 2, other: 3}
  enum hardness: { normal: 0, soft: 1, hard: 2 }

  scope :end_toothbrushed, -> { using.where('end_use_at <= ?', Time.current) }
end
