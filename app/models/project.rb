class Project < ApplicationRecord
  belongs_to :user
  has_many :housings, -> { order(ad_price: :desc) }, dependent: :delete_all 
end
