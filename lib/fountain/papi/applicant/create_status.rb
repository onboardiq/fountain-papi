# frozen_string_literal: true

module Fountain
  module Papi
    def self.create_status(params)
      Applicant::CreateStatus.new(params).call
    end

    module Applicant
      class CreateStatus
        attr_reader :status

        def initialize(params)
          @status = Fountain::Papi::Applicant::Status.new(params)
        end

        def call
          response = Client.post(
            "#{Fountain::Papi.config.base_uri}/applicants/#{status.applicant_id}/status",
            body: { applicant: { partner_status: status } }.to_json,
            headers: Fountain::Papi.config.headers
          )

          raise Fountain::Papi::Error, response unless response.success?

          created_status(response)
        end

        def created_status(response)
          result_status = response["partner_status"]
                          .merge(applicant_id: status.applicant_id)

          Fountain::Papi::Applicant::Status.new(result_status)
        end
      end
    end
  end
end
