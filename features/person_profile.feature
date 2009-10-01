Feature: Person profile
  In order to see more details on a given person
  As a LegislatorTracker
  I want to see a person's profile page

  Scenario: Go to profile page
    Given a person nicknamed John Wayne
    When I go to John Wayne's profile page
    Then I should see "John Wayne"