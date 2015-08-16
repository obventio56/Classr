class CoursesController < ApplicationController

  def show
    @course = Course.find(params[:id])
  end

  def new
    @course = Course.new
  end

  def create
    @course = current_role.courses.build(course_params)
    if @course.save
      redirect_to @course
    else
      redirect_to new_course_path
    end
  end

  private

  def course_params
    params.require(:course).permit(:title)
  end

end
