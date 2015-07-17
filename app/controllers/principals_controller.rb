class PrincipalsController < ApplicationController

  def show

  end

  def new
    @principal = Principal.new
  end

  def create

    @principal = Principal.new(principal_params)

    if @principal.save
      @principal.user.functionality_id = @principal.id
      @principal.user.functionality_type = 'principal'
      @principal.school.principal_id = @principal.id
      @principal.school_id = @principal.school.id
      if @principal.save
        log_in @principal.user
        redirect_to school_path(@principal.school_id)
      else
        @principal.destroy
        render 'new'
      end
    else
      render 'new'
    end

  end

  private

  def principal_params
    params.require(:principal).permit(:name, school_attributes: [:name], user_attributes: [:email, :password, :password_confirmation])
  end
end
