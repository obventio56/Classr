class SchoolsController < ApplicationController

  def show
    @school = School.find_by(params[:id])
  end

  def update
    @school = School.find(params[:id])
    logger.info 'called here'
    if @school.update_attributes(school_params)
      logger.info @school.errors.full_messages
      redirect_to @school
    else
      logger.info 'called'
      #Uncessesarry duplication. May change if there is no more complication.
      redirect_to @school
      logger.info @school.errors.full_messages

    end
  end

  private

  def school_params
    params.require(:school).permit(white_list_entries_attributes: [:entry, :for_account_type, :id, :_destroy])
  end

end
