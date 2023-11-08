class DentalItem < ApplicationRecord
  belongs_to :user
  belongs_to :toothbrush

  validates :toothbrush_id, presence: true
  validates :user_id, presence: true
end
