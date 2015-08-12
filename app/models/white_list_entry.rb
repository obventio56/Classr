class WhiteListEntry < ActiveRecord::Base
  belongs_to :school

  before_save {self.entry = self.entry.downcase}
  before_validation :infer_entry_type_from_entry

  validates :entry, presence: true
  validates :entry_type, presence: true
  validates :for_role_type, presence: true
  validates :school_id, presence: true

  validate :if_entry_is_domain_then_entry_is_unique

  def if_entry_is_domain_then_entry_is_unique
    if self.entry =~ /\A([a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\Z/i && WhiteListEntry.find_by_entry(self.entry) != nil
      errors.add(:entry, 'The domain ' + self.entry + ' is already in use')
    end
  end

  def infer_entry_type_from_entry
    logger.info self.entry
    if self.entry =~ /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
      self.entry_type = 'email'
    elsif self.entry =~ /\A([a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\Z/i
      self.entry_type = 'domain'
    end
  end

end
