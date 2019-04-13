# -*- encoding: utf-8 -*-
require File.expand_path("../lib/clickhouse/rails/version", __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Vsevolod Avramov"]
  gem.email         = ["gsevka@gmail.com"]
  gem.summary       = %q{A Rails database driver for ClickHouse}
  gem.description   = %q{A Rails database driver for ClickHouse}
  gem.homepage      = "https://github.com/vsevolod/clickhouse-rails"

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "clickhouse-rails"
  gem.require_paths = ["lib"]
  gem.version       = Clickhouse::Rails::VERSION
  gem.licenses      = ["MIT"]

  gem.add_dependency "clickhouse"
  gem.add_dependency "railties"

  gem.add_development_dependency "pry"
  gem.add_development_dependency "rspec"
end
