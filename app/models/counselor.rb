class Counselor < ActiveRecord::Base
  has_one :user
  accepts_nested_attributes_for :user
  validates :name, presence: true
end
