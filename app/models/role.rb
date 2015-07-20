class Role < ActiveRecord::Base
  belongs_to :school
  belongs_to :user
  has_one :administered_school, :class_name => 'School', :foreign_key => 'role_id'
  has_many :created_white_list_entries, :class_name => 'WhiteListEntry', :foreign_key => 'creator_role_id'
  has_many :tests

  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :administered_school


  before_create :set_default_visiblity
  after_create :assign_administered_school_to_school_if_principal

  validate :if_principal_has_school
  validate :role_type_is_white_listed
  validate :student_visibility_is_school

  def if_principal_has_school
    if self.role_type == 'principal' && self.administered_school == nil
      errors.add(:role_type, 'A principal must oversee a school.')
    end
  end

  def role_type_is_white_listed
    if self.role_type != 'principal' && self.role_type != 'teacher' && self.role_type != 'student' && self.role_type != 'counselor'
      errors.add(:role_type, self.role_type.to_s + ' is not an allowed account type.')
    end
  end

  def student_visibility_is_school
    if self.role_type == 'student' && self.visibility != 'school'
      errors.add(:visibility, 'Student account can not be made public')
    end
  end

  def assign_administered_school_to_school_if_principal
    if self.role_type == 'principal'
      self.school = self.administered_school
      #TO DO - Is this necessary? Will it severely slow things down?
      self.save
    end
  end

  def self.current_role?
    if self.id == current_role.id
      return true
    end
    return false
  end

  def set_default_visiblity
    case self.role_type
      when 'student' || 'counselor' || 'teacer'
        self.visibility = 'school'
      when 'principal'
        self.visibility = 'site wide'
    end
  end
end
