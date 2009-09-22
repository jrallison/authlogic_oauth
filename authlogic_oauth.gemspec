# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{authlogic-oauth}
  s.version = "1.0.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["John Allison"]
  s.date = %q{2009-09-22}
  s.description = %q{An authlogic extension for authenticating via OAuth.  This can be helpful for adding support for login/registration with Twitter credentials.}
  s.email = %q{jrallison@gmail.com}
  s.extra_rdoc_files = ["Manifest.txt", "CHANGELOG.rdoc", "README.rdoc"]
  s.files = ["CHANGELOG.rdoc", "MIT-LICENSE", "Manifest.txt", "README.rdoc", "Rakefile", "init.rb", "lib/authlogic_oauth.rb", "lib/authlogic_oauth/acts_as_authentic.rb", "lib/authlogic_oauth/helper.rb", "lib/authlogic_oauth/oauth_process.rb", "lib/authlogic_oauth/session.rb", "lib/authlogic_oauth/version.rb", "lib/oauth_callback_filter.rb", "rails/init.rb", "test/acts_as_authentic_test.rb", "test/fixtures/users.yml", "test/lib/user.rb", "test/lib/user_session.rb", "test/session_test.rb", "test/test_helper.rb"]
  s.homepage = %q{http://github.com/jrallison/authlogic_oauth}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{authlogic-oauth}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{An authlogic extension for authenticating via OAuth. (I.E. Twitter login)}
  s.test_files = ["test/acts_as_authentic_test.rb", "test/session_test.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 0"])
      s.add_development_dependency(%q<hoe>, [">= 2.3.3"])
    else
      s.add_dependency(%q<activesupport>, [">= 0"])
      s.add_dependency(%q<hoe>, [">= 2.3.3"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 0"])
    s.add_dependency(%q<hoe>, [">= 2.3.3"])
  end
end
