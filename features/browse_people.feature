Feature: Browse people
  In order to find the people I'm interested in tracking
  As a LegislatorTracker
  I want to browse through people

  Scenario: Simple list of people
    Given the following people:
      |firstname|middlename|lastname|nickname|birthday|gender|
      |firstname 1|middlename 1|lastname 1|nickname 1|1962-03-21|gender 1|
      |firstname 2|middlename 2|lastname 2|nickname 2|1962-03-21|gender 2|
      |firstname 3|middlename 3|lastname 3|nickname 3|1962-03-21|gender 3|
      |firstname 4|middlename 4|lastname 4|nickname 4|1962-03-21|gender 4|
    When I go to the people page
    Then I should see the following people:
      |Firstname|Middlename|Lastname|Nickname|Birthday|Gender|
      |firstname 1|middlename 1|lastname 1|nickname 1|1962-03-21|gender 1|
      |firstname 2|middlename 2|lastname 2|nickname 2|1962-03-21|gender 2|
      |firstname 3|middlename 3|lastname 3|nickname 3|1962-03-21|gender 3|
      |firstname 4|middlename 4|lastname 4|nickname 4|1962-03-21|gender 4|

