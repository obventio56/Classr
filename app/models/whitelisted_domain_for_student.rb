class WhitelistedDomainForStudent < ActiveRecord::Base
  belongs_to :school

  before_save { self.domain = domain.downcase }
  VALID_DOMAIN_REGEX = /([a-z0-9]+)*\.[a-z]{1,6}/i
  validates :domain, presence: true, length: { maximum: 255 },
            format: { with: VALID_DOMAIN_REGEX }
  validate :unique_to_school

  def unique_to_school
    if WhitelistedDomainForStudent.where(school_id: self.school_id, domain: self.domain.downcase).length != 0
      errors.add(:domain, "Already Exists For School")
    end
  end

  end
