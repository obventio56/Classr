module RolesHelper
  def current_role
    current_role_id = cookies[:current_role_id].to_i
    if current_role_id != 0 && Role.find_by_id(current_role_id).user == current_user
      Role.find_by_id(current_role_id)
    end
  end

  def is_current_role?
    !current_role.nil?
  end

  def current_role?(role)
    unless current_role == role
      return false
    end
    true
  end

  def faculty?(role)
    unless [:counselor, :teacher, :principal].include?(role.role_type)
      return false
    end
    true
  end

end

