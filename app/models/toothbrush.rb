class Toothbrush < ApplicationRecord
  belongs_to :user
  has_many :dental_items, dependent: :destroy

  validates :user_id, presence: true
  validates :comment, length: { maximum: 100 }

  enum state: { not_started: 0, using: 1, end_used: 2, cleaning: 3, recycling: 4 }
  enum brush_material: { nylon_hair: 0, animal_hair: 1, electric: 2, other: 3 }
  enum hardness: { normal: 0, soft: 1, hard: 2 }

  def self.ransackable_attributes(_auth_object = nil)
    %w[item_name]
  end

  scope :end_toothbrushed, -> { using.where('end_use_at <= ?', Time.current).where.not(brush_material: :electric) }
  scope :using_electric, -> { using.electric.where('end_use_at <= ?', Time.current) }
  scope :used, -> { where.not(state: :not_started) }
  scope :using_threedays, -> { used.where('created_at <= ?', Time.current - 3.days) }
end
