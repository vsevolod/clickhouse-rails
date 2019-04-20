# Clickhouse rails

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

5. Create database
```bash
$ rake clickhouse:db:create
```

## Additional clickhouse links

[Base gem](https://github.com/archan937/clickhouse)
[List of data types](https://clickhouse.yandex/docs/en/data_types/)
