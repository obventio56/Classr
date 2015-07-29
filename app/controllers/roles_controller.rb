class RolesController < ApplicationController

  def new
    @role = Role.new
    if params[:role_type] == 'principal'
      @partial = 'new_principal'
    else
      #TO DO - Add new_role partial
      @partial = 'new_role'
    end
  end

  def create
    @role = Role.new(role_params)
    if @role.save
      log_in @role.user
      cookies[:current_role_id] = @role.id
      redirect_to role_path(@role)
    else
      redirect_to new_role_path(role_type: role_params[:role_type])
    end
  end

  private

  def role_params
    params.require(:role).permit(:role_type, user_attributes: [:name, :email, :password, :password_confirmation], administered_school_attributes: [:name])
  end

end
