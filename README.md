# Clickhouse rails

[![Build Status](https://travis-ci.com/vsevolod/clickhouse-rails.svg?branch=master)](https://travis-ci.com/vsevolod/clickhouse-rails)
[![codecov](https://codecov.io/gh/vsevolod/clickhouse-rails/branch/master/graph/badge.svg)](https://codecov.io/gh/vsevolod/clickhouse-rails)

## Install

1. Add to Gemfile
```ruby
gem 'clickhouse-rails'
```

2. Run bundle
```bash
$ bundle install
```

3. Init config files and folders
```bash
$ rails g clickhouse:install
```

4. Change clickhouse.yml at `config/clickhouse.yml` path

5. Create migrations
```bash
$ rails g clickhouse:migration add_tmp_table
      create  db/clickhouse/migrate/002_add_tmp_table.rb
```

6. Edit file like this:
```ruby
# db/clickhouse/migrate/002_add_tmp_table.rb
class AddTmpTable < Clickhouse::Rails::Migrations::Base
  def self.up
    create_table :tmp do |t|
      t.date   :date
      t.uint16 :id

      t.engine "MergeTree(date, (date), 8192)"
    end
  end
end
```

## TODO:

1. Rollback migrations
2. Alter table

## Additional clickhouse links

- [Base gem](https://github.com/archan937/clickhouse)
- [List of data types](https://clickhouse.yandex/docs/en/data_types/)
- [Table engines](https://clickhouse.yandex/docs/en/operations/table_engines/)
