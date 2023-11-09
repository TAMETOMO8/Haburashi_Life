class DentalItem < ApplicationRecord
  belongs_to :user
  belongs_to :toothbrush

  validates :toothbrush_id, presence: true
  validates :user_id, presence: true

  validate :validate_dental_items_count, on: :create

  private

  def validate_dental_items_count
    if user&.dental_items&.where(toothbrush_id:)&.count.to_i >= 5
      errors.add(:base, '5つまでしか登録できません')
    end
  end
end
