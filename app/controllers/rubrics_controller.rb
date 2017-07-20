class RubricsController < ApplicationController
  before_action :find_rubric, only: %i(show edit update destroy)
  def index
    if params[:rubric_id]
      @rubric = Rubric.find(params[:rubric_id])
      @rubrics = @rubric.rubrics
    else
      @rubrics = Rubric.where(rubric_id: nil)
    end

  end

  def new
    @rubric = Rubric.new(rubric_id: params[:rubric_id])
  end

  def create
    @rubric = Rubric.new(rubric_params)
    if @rubric.save
      redirect_to @rubric, notice: 'Record was successfully created.'
    else
      render :new
    end
  end

  def update
    if @rubric.update(rubric_params)
      redirect_to @rubric, notice: 'Record was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @rubric.destroy
    redirect_to rubrics_path, notice: 'Record was successfully destroyed.'
  end

  private

  def find_rubric
    @rubric = Rubric.find(params[:id])
  end

  def rubric_params
    params.require(:rubric).permit(:name, :rubric_id)
  end











end
