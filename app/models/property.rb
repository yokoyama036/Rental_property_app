class Property < ApplicationRecord
  has_many :stations, dependent: :destroy
  validates :name, :rent, :adress, :age, presence: true
  accepts_nested_attributes_for :stations,allow_destroy: true, reject_if: :all_blank
end
