# frozen_string_literal: true

module Facter
  module Resolvers
    class Lpar < BaseResolver
      @semaphore = Mutex.new
      @fact_list ||= {}

      class << self
        private

        def post_resolve(fact_name)
          @fact_list.fetch(fact_name) { read_lpar(fact_name) }
        end

        def read_lpar(fact_name)
          lpar_cmd = '/usr/bin/lparstat -i'
          output, _status = Open3.capture2(lpar_cmd)
          output.each_line do |line|
            populate_lpar_data(line.split(':').map(&:strip))
          end
          @fact_list[fact_name]
        end

        def populate_lpar_data(key_value)
          @fact_list[:lpar_partition_name]   = key_value[1]      if key_value[0] == 'Partition Name'
          @fact_list[:lpar_partition_number] = key_value[1].to_i if key_value[0] == 'Partition Number'
        end
      end
    end
  end
end