module RolesHelper
  def role_destination_path(role)
    case role.role_type
      when 'principal'
        school_path(role.administered_school)
      else
        role_path(role)
    end
  end

  def current_role(choose_if_nil=false)
    if logged_in?
      if @current_role == nil
        if cookies[:current_role_id] == nil
         return pick_role(choose_if_nil)
        else
          current_role_id = cookies[:current_role_id].to_i
          current_role = Roles.find(current_role_id)
          if current_role.user_id == current_user.id
            @current_role = current_role
            return current_role
          else
            return pick_role(choose_if_nil)
          end
        end
      else
        @current_role
      end
    end
  end

  def pick_role(choose_if_nil=false)
    if current_user.roles.count == 1
      @current_role = current_user.roles[0]
      cookies[:current_role_id] = @current_role.id
      @current_role
    elsif choose_if_nil
      store_location
      redirect_to edit_user_path(choose_role: 'true')
    end
  end

end

