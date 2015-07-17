class SchoolsController < ApplicationController

  def show
    @school = School.find_by(params[:id])
    if current_user.functionality_type == 'principal'
      @whitelisted_domain_for_students = @school.whitelisted_domain_for_students
      @whitelisted_emails = @school.whitelisted_emails
    end
  end

  def update
    @school = School.find(params[:id])
      if current_user.functionality_type == 'principal'
        if params[:school] == nil
          redirect_to school_path(@school)
        else
            if @school.update_attributes(school_params)
              redirect_to school_path(@school)
            else
              redirect_to school_path(@school)
            end
        end
      end
  end

  private

  def school_params
    params.require(:school).permit(:name, :principal_id, whitelisted_domain_for_students_attributes: [:domain, :id, :_destroy], whitelisted_emails_attributes: [:email, :id, :account_type, :_destroy])
  end

end
