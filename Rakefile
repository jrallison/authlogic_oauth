ENV['RDOCOPT'] = "-S -f html -T hanna"

require "rubygems"
require "hoe"
require File.dirname(__FILE__) << "/lib/authlogic_oauth/version"

Hoe.new("AuthlogicOauth", AuthlogicOauth::Version::STRING) do |p|
  p.name = "authlogic_oauth"
  p.author = "John Allison"
  p.email  = 'jrallison@gmail.com'
  p.summary = "blah."
  p.description = "blah."
  p.url = "http://github.com/jrallison/authlogic_oauth"
  p.history_file = "CHANGELOG.rdoc"
  p.readme_file = "README.rdoc"
  p.extra_rdoc_files = ["CHANGELOG.rdoc", "README.rdoc"]
  p.remote_rdoc_dir = ''
  p.test_globs = ["test/*/test_*.rb", "test/*_test.rb", "test/*/*_test.rb"]
  p.extra_deps = %w(activesupport)
end