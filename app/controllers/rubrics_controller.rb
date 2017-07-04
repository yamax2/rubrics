class RubricsController < ApplicationController

  def index
    @rubrics = Rubric.all
  end

  def show
    @rubrics = Rubric.all
  end

end
