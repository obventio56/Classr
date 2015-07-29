class SchoolsController < ApplicationController

  def show
    @school = School.find_by(params[:id])
  end

  def update
    @school = School.find(params[:id])
  end

  private

  def school_params
    params.require(:school).permit(whitelisted_emails_attributes: [:entry, :for_account_type, :id, :_destroy])
  end

end
