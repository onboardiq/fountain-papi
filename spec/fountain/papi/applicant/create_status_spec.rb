require "spec_helper"

describe Fountain::Papi::Applicant::CreateStatus do
  describe "#call" do
    let(:params) do
      {
        applicant_id: "45243c79-981a-4b5c-9c24-117381aabc1b",
        status: "completed",
        title: "Our new title"
      }
    end

    subject(:result) { Fountain::Papi.create_status(**params) }

    before do
      stub_request(:post, /applicants\/#{params[:applicant_id]}\/status/).
        to_return(
          body: File.read("./spec/fixtures/partner_status.json"),
          status: 201
        )
    end

    it "makes a request" do
      subject

      expect(
        a_request(:post, "#{Fountain::Papi.config.base_uri}/applicants/45243c79-981a-4b5c-9c24-117381aabc1b/status")
      ).to have_been_made
    end

    it "returns the created applicant status" do
      expect(result).to be_instance_of(Fountain::Papi::Applicant::Status)

      expect(result.applicant_id).to eq(params[:applicant_id])
      expect(result.category).to eq(nil)
      expect(result.color).to eq("green")
      expect(result.display_status).to eq("[Partner Name] Completed")
      expect(result.display_title).to eq("[Partner Name] Our new title")
      expect(result.external_id).to eq("b87ab326-ee84-40aa-a28e-9d520cfeaca8")
      expect(result.link_title).to eq("Fountain.com")
      expect(result.show_redo).to eq(false)
      expect(result.status).to eq("completed")
      expect(result.status_type).to eq(nil)
      expect(result.title).to eq(params[:title])
      expect(result.url).to eq("https://www.fountain.com")
    end

    context "when missing applicant_id" do
      before { params.delete(:applicant_id) }

      it "raises an error" do
        expect { subject }.to raise_error(Dry::Struct::Error, /:applicant_id is missing/)
      end
    end

    context "when applicant_id is an invalid format" do
      before { params[:applicant_id] = "123-abc" }

      it "raises an error" do
        expect { subject }.to raise_error(Dry::Struct::Error, /has invalid type for/)
      end
    end

    context "when missing status" do
      before { params.delete(:status) }

      it "raises an error" do
        expect { subject }.to raise_error(Dry::Struct::Error, /:status is missing/)
      end
    end

    context "when an API error occurs" do
      before do
        stub_request(:post, /applicants\/#{params[:applicant_id]}\/status/).
          to_return(
            body: File.read("./spec/fixtures/error.json"),
            status: 400
          )
      end

      it "raises an error" do
        expect { subject }.to raise_error(Fountain::Papi::Error, /Bad Request/)
      end
    end
  end
end
