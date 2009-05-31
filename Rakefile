ENV['RDOCOPT'] = "-S -f html -T hanna"

require "rubygems"
require "hoe"
require File.dirname(__FILE__) << "/lib/authlogic_oauth/version"

Hoe.new("authlogic-oauth", AuthlogicOauth::Version::STRING) do |p|
  p.name = "authlogic-oauth"
  p.author = "John Allison"
  p.email  = 'jrallison@gmail.com'
  p.summary = "An authlogic extension for authenticating via OAuth. (I.E. Twitter login)"
  p.description = "An authlogic extension for authenticating via OAuth.  This can be helpful for adding support for login/registration with Twitter credentials."
  p.url = "http://github.com/jrallison/authlogic_oauth"
  p.history_file = "CHANGELOG.rdoc"
  p.readme_file = "README.rdoc"
  p.extra_rdoc_files = ["CHANGELOG.rdoc", "README.rdoc"]
  p.remote_rdoc_dir = ''
  p.test_globs = ["test/*/test_*.rb", "test/*_test.rb", "test/*/*_test.rb"]
  p.extra_deps = %w(activesupport)
end