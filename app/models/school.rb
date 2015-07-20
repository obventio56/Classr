class School < ActiveRecord::Base
  belongs_to :principal, :class_name => 'Role', :foreign_key => 'role_id'
  has_many :roles, dependent: :destroy
  has_many :white_list_entries, dependent: :destroy

  accepts_nested_attributes_for :white_list_entries

  before_create :set_default_visiblity

  validates :name, presence: true,
           uniqueness: { case_sensitive: false }
  validates :role_id, presence: true
  validate :principal_is_of_role_type_principal

  def principal_is_of_role_type_principal
    if self.principal.role_type != 'principal'
      errors.add(:role_id, 'The principal of a school must be of principal role type.')
    end
  end

  def set_default_visiblity
    self.visibility = 'site wide'
  end
end
