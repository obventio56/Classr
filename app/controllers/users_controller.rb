class UsersController < ApplicationController


  before_action :logged_in_user, except: [:new, :create]
  before_action :correct_user, except: [:new, :create]

  def show

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      select_role(@user)
    else
      redirect_to new_user_path
    end
  end

  #Might want redirect_back functionality. Remember!

  def edit
    @user = User.find(params[:id])
    if params[:choose_role] == 'true'
      @partial = 'choose_role'
    end
  end

  def update
    @user = User.find(params[:id])
    if params[:role_id] != nil
      role_id = params[:role_id].to_i
      if Role.find(role_id).user_id == @user.id
        cookies[:current_role_id] = role_id
        redirect_back_or(role_path(role_id))
      else
        redirect_to edit_user_path(@user, choose_role: 'true')
      end
    else
      #Actually update user.
    end
  end


  private

  def user_params
    params.require(:user).permit(:email, :password,
                                 :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      redirect_to login_url
    end
  end

  def correct_user
    user = User.find(params[:id])
    redirect_to(root_url) unless user == current_user
  end

end
