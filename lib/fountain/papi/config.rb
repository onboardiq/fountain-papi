module Fountain
  module Papi
    class Config
      attr_accessor :api_key
      attr_accessor :partner_id
      attr_accessor :sandbox
      attr_accessor :version
      attr_accessor :base_domain

      def initialize
        @api_key = nil    # Partner API Key
        @partner_id = nil # Parter Identifier
        @sandbox = true   # Default to sandbox
        @version = 1      # API version
        @base_domain = "https://partners-sandbox.fountain.com" # Default to sandbox base domain
      end

      def base_uri
        "#{base_domain}/v#{version}/partners/#{partner_id}"
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
