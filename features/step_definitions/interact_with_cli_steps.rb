require 'pty'
require 'expect'

Given(/^I create a project from template "(.*?)"$/) do |arg1|
  template_file = "#{File.expand_path("../../..", __FILE__)}/#{arg1}_template.rb"
  "No template file with name #{template_file}" unless File.exist? template_file
  $r, $w, _ = PTY.spawn("rails new dummy --skip --skip-bundle --template #{template_file}", :chdir => $dir_path)
end

When(/^I'm asked "(.*?)"$/) do |arg1|
  res = $r.expect(/#{arg1}/, 5)
  fail "Can't find the output '#{arg1}'" unless res
end

When(/^I answer "(.*?)"$/) do |arg1|
  $w.puts arg1
end

Then(/^I should have new project$/) do
  res = $r.expect(/Project successfully scaffolded/, 5)
  fail 'Script failed to finish' unless res
end

Then(/^I should have landing controller created$/) do
  subpath = "app/controllers/landing_controller.rb"
  path = "#{File.expand_path("../../..", __FILE__)}/dummy/#{subpath}"
  expect(File.read("#{$dir_path}/dummy/#{subpath}")).to eq File.read(path)
end

Then(/^I should have correct Gemfile$/) do
  path = "#{File.expand_path("../../..", __FILE__)}/dummy/Gemfile"
  expect(File.read("#{$dir_path}/dummy/Gemfile")).to eq File.read(path)
end

Then(/^I should not have landing controller created$/) do
  subpath = "app/controllers/landing_controller.rb"
  fail 'LandingController exists!' if File.exist?("#{$dir_path}/dummy/#{subpath}")
end
