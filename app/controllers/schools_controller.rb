class SchoolsController < ApplicationController

  def show
    @school = School.find_by(params[:id])
  end

  def update
    @school = School.find(params[:id])
    if @school.update_attributes(school_params)
      redirect_to @school
    else
      #Uncessesarry duplication. May change if there is no more complication.
      redirect_to @school
    end
  end

  private

  def school_params
    params.require(:school).permit(white_list_entries_attributes: [:entry, :for_role_type, :id, :_destroy])
  end

end
