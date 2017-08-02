crumb :root do
  link "home", root_path
end

crumb :rubrics do
  link "rubrics", rubrics_path
end

crumb :rubric do |rubric|
  link rubric.title || %Q(new #{rubric.model_name.human}).capitalize, rubrics_path(rubric_id: rubric)
  if rubric.rubric
    parent :rubric, rubric.rubric
  else
    parent :rubrics
  end
end
