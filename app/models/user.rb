class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  validates :line_user_id, presence: true, uniqueness: true
  validates :name, presence: true, length: { maximum: 30 }
  has_many :toothbrushes, dependent: :destroy
  has_many :dental_items, dependent: :destroy

  def registered?(item)
    if item.is_a?(Toothbrush)
      toothbrushes.exists?(item_code: item.item_code)
    else
      item.is_a?(DentalItem)
      dental_items.exists?(item_code: item.item_code)
    end
  end
end
