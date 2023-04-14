# frozen_string_literal: true

require "spec_helper"

describe Fountain::Papi::Config do
  let(:api_key) { SecureRandom.uuid }
  let(:partner_id) { SecureRandom.uuid }

  before(:each) do
    Fountain::Papi.remove_instance_variable(:@config) if Fountain::Papi.instance_variable_defined?(:@config)
  end

  it "includes the correct API key" do
    Fountain::Papi.configure { |c| c.api_key = api_key }

    expect(Fountain::Papi.config.api_key).to eq(api_key)
  end

  it "includes the correct Partner ID" do
    Fountain::Papi.configure { |c| c.partner_id = partner_id }

    expect(Fountain::Papi.config.partner_id).to eq(partner_id)
  end

  it "includes the correct version number" do
    Fountain::Papi.configure { |c| c.version = 99 }

    expect(Fountain::Papi.config.version).to eq(99)
  end

  it "includes the correct sandbox setting" do
    Fountain::Papi.configure { |c| c.sandbox = false }

    expect(Fountain::Papi.config.sandbox).to eq(false)
  end

  it "returns the proper API headers" do
    Fountain::Papi.configure { |c| c.api_key = api_key }

    expect(Fountain::Papi.config.headers).to include("Content-Type" => "application/json", "X-ACCESS-TOKEN" => api_key)
  end

  describe "#base_uri" do
    context "when no partner_id is specified" do
      it "returns the correct sandbox base_uri" do
        Fountain::Papi.configure do |c|
          c.partner_id = partner_id
        end

        expect(Fountain::Papi.config.base_uri).to eq("https://partners-sandbox.fountain.com/v1/partners/#{partner_id}")
      end
    end

    context "when a partner_id is specified" do
      let(:new_partner_id) { SecureRandom.uuid }

      it "returns the correct sandbox base_uri" do
        Fountain::Papi.configure do |c|
          c.partner_id = partner_id
        end

        expect(Fountain::Papi.config.base_uri(override_partner_id: new_partner_id)).to eq("https://partners-sandbox.fountain.com/v1/partners/#{new_partner_id}")
      end
    end
  end

  context "when no version specified" do
    it "defaults to version 1" do
      expect(described_class.new.version).to eq(1)
    end
  end

  context "when sandbox isn't specified" do
    it "defaults to sandbox mode" do
      expect(described_class.new.sandbox).to eq(true)
    end
  end
end
