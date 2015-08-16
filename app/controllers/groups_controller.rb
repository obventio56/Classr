class GroupsController < ApplicationController

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
    @course_id = params[:course_id]
  end

  def create
    @group = current_role.taught_groups.new(group_params)
    if @group.save
      redirect_to @group
    else
      redirect_to new_group_path
    end
  end

  private

  def group_params
    params.require(:group).permit(:course_id)
  end

end
