Feature: Create Rails project from 'Rail API Ember' template
  In order to setup a new project
  I should be able to create one from template

Scenario: Create project
  Given I create a project from template "rails_api_ember"
  When I'm asked "Do you want to use \"Lightning Fast Deployments With Rails\""
  And I answer "yes"
  Then I should have new project
  # git
  And git repo should be initialized
  And git repo should have initial commit
  # Lightning Fast Deployments With Rails
  And I should have landing controller created
  And I should have redis initializer created
  # Gemfile
  And I should have correct Gemfile

Scenario: Create project without 'Fast deployment'
  Given I create a project from template "rails_api_ember"
  When I'm asked "Do you want to use \"Lightning Fast Deployments With Rails\""  
  And I answer "no"
  Then I should have new project  
  And I should not have landing controller created    
  And I should not have redis initializer created
