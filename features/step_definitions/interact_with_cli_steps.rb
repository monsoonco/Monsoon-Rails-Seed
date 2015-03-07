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
  res = $r.expect(/Success!/, 5)
  fail 'Script failed to finish' unless res
end

Then(/^I should not have new project$/) do
  res = $r.expect(/Success!/, 5)
  expect(res).to eq nil
end
