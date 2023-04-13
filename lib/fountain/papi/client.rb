# frozen_string_literal: true

module Fountain
  module Papi
    class Client
      include HTTParty

      format :json
    end
  end
end
