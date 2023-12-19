class Impression < ApplicationRecord
  belongs_to :user
  belongs_to :toothbrush

  validates :body, presence: true, length: { maximum: 100 }
end
