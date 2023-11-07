class DentalItem < ApplicationRecord
  belongs_to :user
  belongs_to :toothbrush
end
