class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  validates :line_user_id, presence: true, uniqueness: true
  validates :name, presence: true, length: { maximum: 50 }
  has_many :toothbrushes, dependent: :destroy

  def registered?(toothbrush)
    toothbrushes.exists?(item_code: toothbrush.item_code)
  end
end
