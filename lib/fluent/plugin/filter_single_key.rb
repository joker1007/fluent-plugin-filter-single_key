require "fluent/plugin/filter"

module Fluent
  module Plugin
    class SingleValueFilter < Fluent::Plugin::Filter
      Fluent::Plugin.register_filter("single_key", self)

      desc "regexp pattern for target key"
      config_param :key_pattern, :string

      desc "If this param is set, replace this value as new key"
      config_param :new_key, :string, default: nil

      def configure(conf)
        super

        @key_pattern = Regexp.new(@key_pattern)
      end

      def filter_stream(tag, es)
        new_es = MultiEventStream.new
        es.each do |time, record|
          begin
            record.each do |k, v|
              if k =~ @key_pattern
                new_record =
                  if @new_key
                    {k.gsub(@key_pattern, @new_key) => v}
                  else
                    {k => v}
                  end
                new_es.add(time, new_record)
              end
            end
          rescue => e
            router.emit_error_event(tag, time, record, e)
          end
        end
        new_es
      end
    end
  end
end
