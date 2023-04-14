# frozen_string_literal: true

module Fountain
  module Papi
    module Applicant
      class Status < Dry::Struct
        transform_keys(&:to_sym)

        Statuses = Types::String.enum("incomplete", "in_progress", "pending_action", "completed", "error")

        attribute :status, Statuses
        attribute :applicant_id, Types::UUID

        # optional request attributes:
        attribute? :account_option, Types::Coercible::String.optional
        attribute? :link_title, Types::Strict::String.optional
        attribute? :title, Types::Strict::String
        attribute? :url, Types::Strict::String.optional

        # response attributes:
        attribute? :category, Types::Strict::String.optional
        attribute? :color, Types::Strict::String
        attribute? :display_status, Types::Strict::String
        attribute? :display_title, Types::Strict::String
        attribute? :external_id, Types::UUID.optional
        attribute? :show_redo, Types::Params::Bool.optional
        attribute? :status_type, Types::Strict::String.optional

        # config override attributes:
        attribute? :partner_id, Types::UUID.optional
      end
    end
  end
end
