# Clickhouse migrations

Implement migrations to clickhouse database

## Install

1. Add to Gemfile
```ruby
gem 'clickhouse-migrations'
```

2. Run bundle
```bash
$ bundle install
```

3. Init config files and folders
```bash
$ rails g clickhouse:init
```

4. Change clickhouse.yml at `config/clickhouse.yml` path

5. Create database
```bash
$ rake clickhouse:db:create
```
