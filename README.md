# fluent-plugin-filter-single_key

[Fluentd](https://fluentd.org/) filter plugin that Explode record to single key record.

## Installation

### RubyGems

```
$ gem install fluent-plugin-filter-single_key
```

### Bundler

Add following line to your Gemfile:

```ruby
gem "fluent-plugin-filter-single_key"
```

And then execute:

```
$ bundle
```

## Configuration

### key_pattern (string) (required)

regexp pattern for target key

### keep_key_pattern (string) (optional)

regexp pattern for keep key

### new_key (string) (optional)

If this param is set, replace this value as new key

You can copy and paste generated documents here.

## Copyright

* Copyright(c) 2017- joker1007
* License
  * MIT
