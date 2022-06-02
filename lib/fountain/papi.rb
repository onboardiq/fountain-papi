# frozen_string_literal: true

require "dry-struct"
require "httparty"

require_relative "papi/config"
require_relative "papi/types"
require_relative "papi/version"
require_relative "papi/client"
require_relative "papi/applicant/create_status"
require_relative "papi/applicant/status"

module Fountain
  module Papi
    class Error < StandardError; end
  end
end
