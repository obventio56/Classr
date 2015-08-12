class User < ActiveRecord::Base
  attr_accessor :remember_token
  has_many :roles

  before_create :organize_roles
  before_save { self.email = email.downcase }


  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def organize_roles
    if self.roles.count == 0
      if WhiteListEntry.where(entry_type: 'email', entry: self.email).count != 0
        white_list_entries = WhiteListEntry.where(entry_type: 'email', entry: self.email)
        white_list_entries.each do |entry|
          self.roles.new(role_type: entry.for_role_type, school_id: entry.school_id, visibility: 'school')
        end
      elsif  WhiteListEntry.find_by(entry_type: 'domain', entry: self.email.downcase.split('@')[1]) != nil
        white_list_entry = WhiteListEntry.find_by(entry_type: 'domain', entry: self.email.downcase.split('@')[1])
        self.roles.new(role_type: white_list_entry.for_role_type, school_id: white_list_entry.school_id, visibility: 'school')
      end
    end
  end



end
