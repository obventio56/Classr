class WhiteListEntry < ActiveRecord::Base
  belongs_to :school
  belongs_to :creator_role, :class_name => 'Role', :foreign_key => 'creator_role_id'


  before_save :infer_entry_type_from_entry
  before_save {self.entry = self.entry.downcase}

  validates :entry, presence: true
  validates :entry_type, presence: true
  validates :school_id, presence: true

  validate :if_entry_is_domain_then_entry_is_unique

  def if_entry_is_domain_then_entry_is_unique
    if self.entry =~ /\A([a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\Z/i && WhiteListEntry.find_by_entry(self.entry) != nil
      errors.add(:entry, 'The domain is already in use')
    end
  end

  def infer_entry_type_from_entry
    if self.entry =~ /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
      self.entry_type = 'email'
    elsif self.entry =~ /\A([a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\Z/i
      self.entry_type = 'domain'
    end
  end

end
