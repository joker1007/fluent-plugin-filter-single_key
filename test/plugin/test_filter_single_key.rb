require "helper"
require "fluent/plugin/filter_single_key.rb"

class SingleValueFilterTest < Test::Unit::TestCase
  setup do
    Fluent::Test.setup
  end

  test "#configure" do
    d = create_driver

    assert { d.instance.key_pattern == /foo(\d)/ }
    assert { d.instance.new_key == 'bar\1' }
  end

  test "#filter_stream" do
    d = create_driver

    d.run do
      d.feed("tag", Time.now.to_i, {"foo1" => 1, "foo2" => 2, "no_match" => 99})
    end

    assert { d.filtered_records == [{"bar1" => 1}, {"bar2" => 2}] }
  end

  test "#filter_stream without new_key" do
    d = create_driver(%q{
      key_pattern foo(\d)
    })

    d.run do
      d.feed("tag", Time.now.to_i, {"foo1" => 1, "foo2" => 2, "no_match" => 99})
    end

    assert { d.filtered_records == [{"foo1" => 1}, {"foo2" => 2}] }
  end

  private

  DEFAULT_CONF = %q{
    key_pattern foo(\d)
    new_key bar\1
  }

  def create_driver(conf = DEFAULT_CONF)
    Fluent::Test::Driver::Filter.new(Fluent::Plugin::SingleValueFilter).configure(conf)
  end
end
