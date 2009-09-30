Feature: Manage people
  In order to [goal]
  [stakeholder]
  wants [behaviour]
  
  Scenario: Register new person
    Given I am on the new person page
    When I fill in "Firstname" with "firstname 1"
    And I fill in "Middlename" with "middlename 1"
    And I fill in "Lastname" with "lastname 1"
    And I fill in "Nickname" with "nickname 1"
    And I fill in "Birthday" with "birthday 1"
    And I fill in "Gender" with "gender 1"
    And I press "Create"
    Then I should see "firstname 1"
    And I should see "middlename 1"
    And I should see "lastname 1"
    And I should see "nickname 1"
    And I should see "birthday 1"
    And I should see "gender 1"

  Scenario: Delete person
    Given the following people:
      |firstname|middlename|lastname|nickname|birthday|gender|
      |firstname 1|middlename 1|lastname 1|nickname 1|birthday 1|gender 1|
      |firstname 2|middlename 2|lastname 2|nickname 2|birthday 2|gender 2|
      |firstname 3|middlename 3|lastname 3|nickname 3|birthday 3|gender 3|
      |firstname 4|middlename 4|lastname 4|nickname 4|birthday 4|gender 4|
    When I delete the 3rd person
    Then I should see the following people:
      |Firstname|Middlename|Lastname|Nickname|Birthday|Gender|
      |firstname 1|middlename 1|lastname 1|nickname 1|birthday 1|gender 1|
      |firstname 2|middlename 2|lastname 2|nickname 2|birthday 2|gender 2|
      |firstname 4|middlename 4|lastname 4|nickname 4|birthday 4|gender 4|
