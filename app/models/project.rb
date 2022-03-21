class Project < ApplicationRecord
  belongs_to :user
  has_many :housings, dependent: :delete_all
end
