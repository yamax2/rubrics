def random_string(length = 8)
  rand(32**length).to_s(32)
end

20.times { Rubric.create(title: "#{random_string(8)}", content: "#{random_string(8)}") }

500.times do
  Rubric.create(title: "#{random_string(8)}", content: "#{random_string(8)}", rubric: Rubric.order('random()').first)
end
