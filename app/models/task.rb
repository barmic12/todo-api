class Task < ApplicationRecord
  validates :name, presence: true
  validates :status, inclusion: { in: [ true, false ] }
end
