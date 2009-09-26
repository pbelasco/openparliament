Given /^the following people:$/ do |people|
  Person.create!(people.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) person$/ do |pos|
  visit people_url
  within("table > tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following people:$/ do |expected_people_table|
  expected_people_table.diff!(table_at('table').to_a)
end
