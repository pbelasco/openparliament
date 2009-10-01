Given /^the following people:$/ do |people|
  Person.create!(people.hashes)
end

Then /^I should see the following people:$/ do |expected_people_table|
  expected_people_table.diff!(table_at('table').to_a)
end

Given /^a person nicknamed (.*)$/ do |nickname|
  Person.create!(:nickname => nickname)
end
