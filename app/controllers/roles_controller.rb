class RolesController < ApplicationController

  before_action :is_current_role_or_role_is_public
  before_action :authenticate, except: [:new, :create, :edit, :update]
  before_action :authenticate_update, only: [:edit, :update]

  def show
    @role = Role.find(params[:id])
    @partial = @role.role_type
  end

  def new
    #keep this for now. If I don't use roles for other user creation, I need to remove the whole role_type thing and
    # default to principal.
    @role = Role.new
    if params[:role_type] == 'principal'
      @partial = 'new_principal'
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

  def edit

  end

  def update

  end

  private

  def role_params
    params.require(:role).permit(:role_type, user_attributes: [:name, :email, :password, :password_confirmation],
                                 administered_school_attributes: [:name])
  end

  #I'm making the distinction between roles and users, requiring there to be a current role, under the assumption
  #that all users have roles. I'm thinking on redirect to root, if there is a current user, they get redirected by the
  #selct role function

  def is_current_role_or_role_is_public
    role = Role.find(params[:id])
    if current_role.nil? && role.visibility != 'public'
      if !current_user.nil?
        store_location
        select_role(current_user)
      else
        redirect_to root_url
      end
    end
  end

  def authenticate
    role = Role.find(params[:id])
    case role.visibility
      when 'private'
        redirect_to root_path unless current_role?(role) || (current_role.school == role.school && faculty?(current_role))
      when 'school'
        redirect_to root_path unless current_role.school == role.school
      when 'site'
        redirect_to root_path unless is_current_role?
      #else
        #crash please :) At least I don't know what kind of error I want to throw
    end
  end

  def authenticate_update
    role = Role.find(params[:id])
    redirect_to root_path unless current_role?(role) || (current_role.school == role.school && faculty?(role))
  end



end
