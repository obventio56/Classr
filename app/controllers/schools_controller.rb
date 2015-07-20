class SchoolsController < ApplicationController

  before_action :role_clearance_for_edit_based_on_visiblity, only: [:show, :update]

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

  def role_clearance_for_edit_based_on_visiblity
    @school = School.find(params[:id])
    if current_role.role_type == 'counselor' || current_role.role_type == 'principal' && current_role.school_id == @school.id
      redirect_to role_destination_path(current_role)
    end
  end

end
