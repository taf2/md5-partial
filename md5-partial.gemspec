Gem::Specification.new do |s|
  s.name    = "md5-partial"
  s.authors = ["Todd A. Fisher"]
  s.version = '0.0.2'
  s.date    = '2009-06-28'
  s.description = %q{Calculate an MD5 digest in parts, saving and restoring the calculation}
  s.email   = 'todd.fisher@gmail.com'
  s.extra_rdoc_files = ['LICENSE', 'README']
  
  s.files = ["LICENSE", "README", "Rakefile", "ext/md5.h", "ext/md5.c", "ext/extconf.rb"]
  #### Load-time details
  s.require_paths = ['lib','ext']
#  s.rubyforge_project = 'md5-partial'
  s.summary = %q{Partial MD5 Digest with save/restore}
  s.test_files = ["test/test.rb"]
  s.extensions << 'ext/extconf.rb'

  s.has_rdoc = false
  s.homepage = 'http://github.com/taf2/md5-partial/tree/master'
  s.rdoc_options = ['--main', 'README']

  s.platform = Gem::Platform::RUBY

end
