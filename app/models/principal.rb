class Principal < ActiveRecord::Base
  has_one :user
  has_one :school

  accepts_nested_attributes_for :school
  accepts_nested_attributes_for :user

  validates :name, presence: true

end

