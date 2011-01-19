$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')
require 'shoulda/version'

Gem::Specification.new do |s|
  s.name = %q{shoulda}
  s.version = Shoulda::VERSION

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tammer Saleh", "Joe Ferris", "Ryan McGeary", "Dan Croak",
    "Matt Jankowski"]
  s.date = Time.now.strftime("%Y-%m-%d")
  s.email = %q{support@thoughtbot.com}
  s.extra_rdoc_files = ["README.md", "CONTRIBUTION_GUIDELINES.rdoc"]
  s.files = Dir["[A-Z]*", "{bin,lib,rails,test}/**/*"]
  s.homepage = %q{http://thoughtbot.com/community/}
  s.rdoc_options = ["--line-numbers", "--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{shoulda}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Making tests easy on the fingers and eyes}
  s.description = %q{Making tests easy on the fingers and eyes}

  s.add_runtime_dependency(%q<shoulda-context>, "~> 1.0.0.beta1")
  s.add_runtime_dependency(%q<shoulda-matchers>, "~> 1.0.0.beta1")

  if s.respond_to? :specification_version then
    s.specification_version = 3
  else
  end
end
