module Fountain
  module Papi
    class Config
      attr_accessor :api_key
      attr_accessor :partner_id
      attr_accessor :sandbox
      attr_accessor :version

      def initialize
        @api_key = nil    # Partner API Key
        @partner_id = nil # Parter Identifier
        @sandbox = true   # Default to sandbox
        @version = 1      # API version
      end

      def base_uri
        return "https://partners.fountain.com/v#{version}/partners/#{partner_id}" unless sandbox

        "https://partners-sandbox.fountain.com/v#{version}/partners/#{partner_id}"
      end

      def headers
        {
          "Content-Type" => "application/json",
          "X-ACCESS-TOKEN" => api_key
        }
      end
    end

    def self.config
      @config ||= Config.new
    end

    def self.config=(configuration)
      @config = configuration
    end

    def self.configure
      yield config
    end
  end
end
