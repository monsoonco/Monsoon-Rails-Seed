Feature: Create Rails project from 'Rail API Ember' template
  In order to setup a new project
  I should be able to create one from template

Scenario: Create project
  Given I create a project from template "rails_api_ember"
  When I'm asked "Do you really wanna install this yes/no?"
  And I answer "yes"
  Then I should have new project

Scenario: Fail to create new project
  Given I create a project from template "rails_api_ember"
  When I'm asked "Do you really wanna install this yes/no?"
  And I answer "no"
  Then I should not have new project
