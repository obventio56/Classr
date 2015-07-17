class School < ActiveRecord::Base
  belongs_to :principal
  has_many :whitelisted_domain_for_students, dependent: :destroy
  has_many :whitelisted_emails, dependent: :destroy
  accepts_nested_attributes_for :whitelisted_emails, :allow_destroy => true
  accepts_nested_attributes_for :whitelisted_domain_for_students, :allow_destroy => true
end
