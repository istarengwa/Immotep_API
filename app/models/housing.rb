class Housing < ApplicationRecord
  belongs_to :project
  has_one :user, through: :project

  validates :ad_price, presence: true, numericality: { only_integer: true }
  validates :localization, presence: true
  validates :property_category, presence: true
end
