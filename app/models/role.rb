class Role < ActiveRecord::Base

  belongs_to :school
  belongs_to :user
  has_one :administered_school, :class_name => 'School', :foreign_key => 'role_id'
  has_many :tests

  has_many :courses, :class_name => 'Course', :foreign_key => 'creator_id'
  has_many :taught_groups, :class_name => 'Group', :foreign_key => 'teacher_id'

  has_many :group_roles
  has_many :groups, :through => :group_roles

  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :administered_school

  before_validation :set_administered_school_principal
  before_create :set_default_visibility
  after_create :assign_administered_school_to_school_if_principal

  validate :if_principal_has_school
  validate :role_type_is_white_listed

  def if_principal_has_school
    if self.role_type == 'principal' && self.administered_school == nil
      errors.add(:role_type, 'Principals must oversee a school.')
    end
  end

  def role_type_is_white_listed
    if ['principal','teacher','student'].exclude?(self.role_type)
      errors.add(:role_type, self.role_type.to_s.capitalize + ' is not an allowed account type.')
    end
  end

  def assign_administered_school_to_school_if_principal
    if self.role_type == 'principal'
      self.school = self.administered_school
      #TO DO - Is this necessary? Will it severely slow things down?
      self.save
    end
  end

  def set_default_visibility
    case self.role_type
      when 'student' || 'counselor' || 'teacer'
        self.visibility = 'school'
      when 'principal'
        self.visibility = 'site'
    end
  end

  def set_administered_school_principal
    if self.role_type == 'principal'
      self.administered_school.principal = self
    end
  end

end
