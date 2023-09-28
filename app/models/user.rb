class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  validates :line_user_id, presence: true, uniqueness: true
  has_many :toothbrushes, dependent: :destroy
end
