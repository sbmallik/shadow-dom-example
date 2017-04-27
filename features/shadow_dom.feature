@selenium @uw @shadow-dom
Feature: Shadow DOM 
  Test the ability to access the elements within shadow DOM

  Scenario: Access element within it
    Given That I am viewing the UW asset page
    Then I should see the asset headline
    And I should see the navigation bar with logo
    When I click on the navigation hub toggle button
    Then I should see the navigation hub elements
