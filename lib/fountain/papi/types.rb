module Fountain
  module Papi
    module Types
      include Dry.Types()

      UUID = Strict::String.
        constrained(format: /^[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$/i)
    end
  end
end
