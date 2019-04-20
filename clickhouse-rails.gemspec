require File.expand_path('lib/clickhouse/rails/version', __dir__)

Gem::Specification.new do |gem|
  gem.authors       = ['Vsevolod Avramov']
  gem.email         = ['gsevka@gmail.com']
  gem.summary       = 'A Rails database driver for ClickHouse'
  gem.description   = 'A Rails database driver for ClickHouse'
  gem.homepage      = 'https://github.com/vsevolod/clickhouse-rails'

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split('\n')
  gem.name          = 'clickhouse-rails'
  gem.require_paths = ['lib']
  gem.version       = Clickhouse::Rails::VERSION
  gem.licenses      = ['MIT']

  gem.add_dependency 'clickhouse'
  gem.add_dependency 'railties'

  gem.add_development_dependency 'ammeter', '~> 1.1.2'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'rspec-rails'
end
