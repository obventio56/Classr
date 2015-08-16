class Group < ActiveRecord::Base
  belongs_to :course
  belongs_to :teacher, :class_name => 'Role', :foreign_key => 'teacher_id'

  has_many :group_roles
  has_many :students, :through => :group_roles, :source => :role

  validate :teacher_is_teacher_role

  def teacher_is_teacher_role
    unless self.teacher.role_type == 'teacher'
      errors.add(:teacher, 'Only teachers may teach classes.')
    end
  end

  # We might want to make sure only students can take classes but, I don't see a reason to explicitly enforce that now.
end
