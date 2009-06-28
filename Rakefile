require 'rake/clean'

DLEXT=Config::MAKEFILE_CONFIG['DLEXT']
CLEAN.include '**/*.o'
CLEAN.include "**/*.#{DLEXT}"
CLOBBER.include '**/*.log'
CLOBBER.include '**/Makefile'
TARGET="md5partial.#{DLEXT}"

task :default => :test

file 'ext/Makefile' => 'ext/extconf.rb' do
  Dir.chdir('ext') { ruby 'extconf.rb' }
end

file TARGET => (['ext/Makefile'] + Dir['ext/*.c'] + Dir['ext/*.h']) do
  Dir.chdir('ext') { system("make") }
end

task :compile => TARGET

task :test => :compile do
  Dir.chdir('test') { ruby 'test.rb' }
end
