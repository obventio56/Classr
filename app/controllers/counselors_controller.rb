class CounselorsController < ApplicationController
  def new
    if params[:user_id] != nil && current_user != nil
      if current_user.id == params[:user_id].to_i && current_user.functionality_type == 'counselor' && current_user.functionality_id == User.new.functionality_id
        @counselor = Counselor.new
        @user = User.find(params[:user_id].to_i)
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end
  def create
    if params[:user_id] != nil && current_user != nil
      if current_user.id == params[:user_id].to_i && current_user.functionality_type == 'counselor' && current_user.functionality_id == User.new.functionality_id
        @counselor = Counselor.new(counselor_params)
        @user = User.find(params[:user_id].to_i)
        whitelistModel = false
        if WhitelistedDomainForStudent.find_by_domain(@user.email.split('@').pop()) != nil
          whitelistModel = WhitelistedDomainForStudent.find_by_domain(@user.email.split('@').pop())
        elsif WhitelistedEmail.find_by_email(@user.email) != nil
          whitelistModel = WhitelistedEmail.find_by_email(@user.email)
        end
        @counselor.school_id = whitelistModel.school_id
        if @counselor.save
          if @user.functionality_id = @counselor.id
          redirect_to counselor_path(@counselor)
          end
        end
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end
  private

  def counselor_params
    params.require(:counselor).permit(:name)
  end
end
