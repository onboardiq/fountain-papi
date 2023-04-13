# frozen_string_literal: true

module Fountain
  module Papi
    class Config
      attr_accessor :api_key, :partner_id, :sandbox, :version, :base_domain

      def initialize
        @api_key = nil    # Partner API Key
        @partner_id = nil # Parter Identifier
        @sandbox = true   # Default to sandbox
        @version = 1      # API version
        @base_domain = "https://partners-sandbox.fountain.com" # Default to sandbox base domain
      end

      def base_uri(override_partner_id: nil)
        "#{base_domain}/v#{version}/partners/#{override_partner_id || partner_id}"
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
