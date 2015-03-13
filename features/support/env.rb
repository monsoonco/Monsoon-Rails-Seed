begin require 'rspec/expectations'; rescue LoadError; require 'spec/expectations'; end

$dir_path = nil
$r, $w = []

Before do |scenario|
  $dir_path = "#{File.expand_path("../../", __FILE__)}/dummy"
  FileUtils.rm_rf $dir_path
  Dir.mkdir $dir_path
end

After do |scenario|
  $r.close
  $w.close
  FileUtils.rm_rf $dir_path
end
