require 'open3'

Given(/^I create a project from template "(.*?)"$/) do |arg1|
  template_file = "#{File.expand_path("../../..", __FILE__)}/#{arg1}_template.rb"
  fail "No template file with name #{template_file}" unless File.exist? template_file
  $in, $out, $err, _ = Open3.popen3("rails new dummy --skip --skip-bundle --template #{template_file}", :chdir => $dir_path)
end

When(/^I'm asked "(.*?)"$/) do |arg1|
  log = $out.read.chomp
  p log
  expect(log).to match((/#{arg1}/m))
end

When(/^I answer "(.*?)"$/) do |arg1|
  $in.puts 'yes'
end
