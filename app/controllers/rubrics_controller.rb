class RubricsController < ApplicationController
  def index
    @rubrics = Rubric.where(rubric_id: params[:rubric_id])
  end
end
