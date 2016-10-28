lib = "#{File.dirname(__FILE__)}/lib"
require "#{lib}/raws/config/version"

Gem::Specification.new do |s|
  s.name = %q{raws}
  s.homepage = %q{https://github.com/obyler/example_aws_ruby}
  s.version = Raws::VERSION
  s.summary = %q{This is an example project to demostrate proper structure for building a Ruby CLI tool.}
  s.description = %q{Example AWS Ruby CLI tool}
  s.authors = ['Oliver Byler']
  s.email = 'oliverxreeves@gmail.com'
  s.platform = Gem::Platform::RUBY
  s.require_paths = ['lib']

  s.bindir = 'bin'
  s.executables << 'raws'

  s.files = `git ls-files -z`.split("\x0")

  # dependencies
  s.add_dependency 'aws-sdk-v1'
  s.add_dependency 'logger'
  s.add_dependency 'thor', '~> 0.19'
  s.add_dependency 'json', '~> 1.4'
end
