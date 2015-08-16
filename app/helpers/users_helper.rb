module UsersHelper
  def select_role(user, redirect_on_success=false)
    if user.roles.count == 1
      cookies[:current_role_id] = user.roles[0].id
      if !redirect_on_success
        redirect_back_or role_path(current_role)
      else
        redirect_back_or redirect_on_success
      end
    else
      redirect_to edit_user_path(user, choose_role: 'true')
    end
  end

  def current_user?(user)
    unless user == current_user
      return false
    end
    true
  end
end
