module Fountain
  module Papi
    class Client
      include HTTParty

      format :json

      base_uri Fountain::Papi.config.base_uri
      headers Fountain::Papi.config.headers
    end
  end
end
