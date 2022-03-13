class Housing < ApplicationRecord
  belongs_to :project
  has_one :user, through: :project
end
