class UsersController < ApplicationController

  before_action :correct_user?,   only: [:edit, :update]

  def show

  end

  def new

  end

  def create

  end

  def edit
    @user = User.find(params[:id])
    if cookies[:choose_role] == 'true'
      render 'choose_role'
    end
  end

  def update
    @user = User.find(params[:id])
    if user_params[:role_id] != nil
      role_id = user_params[:role_id].to_i
      if Role.find(role_id).user_id == @user.id
        cookies[:current_role_id] = role_id.to_s
        redirect_to redirect_back_or(role_destination_path(current_role))
      else
        redirect_to edit_user_path(choose_role: 'true')
      end
    end
  end


  private

  def user_params
    params.require(:user).permit(:role_id, :email, :password,
                                 :password_confirmation)
  end

  def correct_user?
    @user = User.find(params[:id])
    redirect_to role_destination_path(current_role) unless @user.current_user?
  end
end
