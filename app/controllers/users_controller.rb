class UsersController < ApplicationController

  def new
    if current_user == nil
      @user = User.new
    else
      redirect_to functionality_path(current_user)
    end
  end

  def create
    # Don't let signed in users make new accounts
    if current_user == nil

      functionality_type = false
      whiteListModel = false

      if WhitelistedEmail.find_by_email(user_params[:email]) != nil

        whiteListModel = WhitelistedEmail.find_by_email(user_params[:email])
        functionality_type = WhitelistedEmail.find_by_email(user_params[:email]).account_type
      elsif WhitelistedDomainForStudent.find_by_domain(user_params[:email].split('@').pop()) != nil

        whiteListModel = WhitelistedDomainForStudent.find_by_domain(user_params[:email].split('@').pop())
        functionality_type = 'student'
      end

      # User is whitelisted
      if functionality_type

        @user = User.new(user_params)
        @user.functionality_type = functionality_type
        if @user.save

          if whiteListModel.class.name == 'WhitelistedEmail'

            whiteListModel.user_created = true
            whiteListModel.save(:validate => false)
            log_in @user
            logger.info 'got to redirect'
            redirect_to new_functionality_path(@user)
          end
          ##else something. This will crash if for some reason the whitelisted email doesn't update
        else

          render 'new'
        end
      end
    else

      redirect_to functionality_path(current_user)
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.update_attributes(user_params)
  end

  private

  def user_params
    params.require(:user).permit(:email, :password,
                                 :password_confirmation)
  end
end
