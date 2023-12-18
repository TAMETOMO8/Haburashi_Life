class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :toothbrush

  validates :body, length: { maximum: 500 }
end
