class TestsController < ApplicationController

  def show
    @test = Test.find(params[:id])
  end

  def new
    @test = Test.new
  end

  def create
    @test = Test.new(test_params)
    if @test.save
      redirect_to test_path(@test)
    end
  end

  def edit
    @test = Test.find(params[:id])
  end

  def update
    @test = Test.find(params[:id])
    if @test.update_attributes(test_params)
      redirect_to test_path(@test)
    end
  end

  private

  def test_params
    params.require(:test).permit(:html, :questions_and_answers)
  end
end
