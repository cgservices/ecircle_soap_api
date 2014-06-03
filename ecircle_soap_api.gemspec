Gem::Specification.new do |gem|
  gem.authors       = ['Luis Doubrava']
  gem.email         = ['luis@cg.nl']
  gem.description   = 'Ruby library for e-Circle Api'
  gem.summary       = 'Ruby library for e-Circle Api'
  gem.homepage      = ''

  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'ecircle_soap_api'
  gem.require_paths = ['lib', 'config', 'db']
  gem.version       = "0.0.6"

  gem.add_dependency('json', ['>= 0'])
  gem.add_dependency('activesupport', ['>= 0'])
  gem.add_dependency('activerecord', ['>= 0'])
  gem.add_dependency('savon', ['>= 2.4.0'])
  gem.add_dependency('rails', ['>= 0'])

  gem.add_dependency('i18n', ['>= 0'])
  gem.add_development_dependency('rake', ['>= 0'])
  gem.add_development_dependency('rspec', ['>= 0'])
  gem.add_development_dependency('rspec-rails', ['>= 0'])
  gem.add_development_dependency('sqlite3', ['>= 0'])
  gem.add_development_dependency('pry', ['>= 0'])
end