# frozen_string_literal: true

module Facts
  module Solaris
    module Memory
      module Swap
        class TotalBytes
          FACT_NAME = 'memory.swap.total_bytes'
          ALIASES = 'swapsize_mb'

          def call_the_resolver
            fact_value = Facter::Resolvers::Solaris::Memory.resolve(:swap)
            fact_value = fact_value[:total_bytes] if fact_value

            [Facter::ResolvedFact.new(FACT_NAME, fact_value),
             Facter::ResolvedFact.new(ALIASES, Facter::FactsUtils::UnitConverter.bytes_to_mb(fact_value), :legacy)]
          end
        end
      end
    end
  end
end
