class Housing < ApplicationRecord
  belongs_to :project
  has_one :user, through: :project

  validates :ad_price, numericality: { only_integer: true }
end
