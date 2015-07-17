class WhitelistedEmail < ActiveRecord::Base
  belongs_to :school

  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX }
  validates :account_type, presence: true
  validate :unique_to_account_type_and_school
  validate :account_type_is_accepted

  def account_type_is_accepted
    if self.account_type != 'counselor' && self.account_type != 'teacher' && self.account_type != 'student'
      errors.add(:account_type, 'Unpermitted option')
    end
  end

  def unique_to_account_type_and_school
    if WhitelistedEmail.where(school_id: self.school_id, email: self.email.downcase, account_type: self.account_type).length != 0
      errors.add(:email, "Already Exists For School And Account Type")
    end
  end
  def user_has_not_been_created
    if self.user_created
      errors.add(:email, "User has been created")
    end
  end
end
