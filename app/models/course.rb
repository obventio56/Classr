class Course < ActiveRecord::Base
  has_many :groups
  belongs_to :creator, :class_name => 'Role', :foreign_key => 'creator_id'

  validate :creator_is_teacher

  def creator_is_teacher
    # Should this be expanded to all faculty?
    unless self.creator.role_type == 'teacher'
      errors.add(:creator, 'Only teachers can create courses.')
    end
  end
end
