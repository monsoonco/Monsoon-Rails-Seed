begin require 'rspec/expectations'; rescue LoadError; require 'spec/expectations'; end

$dir_path = nil
$in, $out, $err = []

Before do |scenario|
  $dir_path = "#{File.expand_path("../../", __FILE__)}/dummy"
  FileUtils.rm_rf $dir_path
  Dir.mkdir $dir_path
end

at_exit do
  $in.close
  $out.close
  $err.close
  FileUtils.rm_rf $dir_path
end
