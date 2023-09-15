# frozen_string_literal: true

describe HarvestNotifier::Slack do
  subject(:slack) { described_class.new(token) }

  let(:token) { "slack-token" }
  let(:headers) { { "Content-type" => "application/json", "Authorization" => "Bearer #{token}" } }

  describe "#post_message" do
    let(:message) { "Hello!" }

    before do
      stub_request(:post, "https://slack.com/api/chat.postMessage")
        .with(headers:, body: message)
        .to_return(status: 200)
    end

    it "success" do
      expect(slack.post_message(message)).to be_success
    end
  end

  describe "update_message" do
    let(:message) { "Hello!" }
    let(:update_url) { "https://hooks.slack.com/actions/T0251E50M" }
    let(:headers) { { "Content-type" => "application/json" } }

    before do
      stub_request(:post, update_url)
        .with(headers:, body: message)
        .to_return(status: 200)
    end

    it "success" do
      expect(slack.update_message(message, update_url)).to be_success
    end
  end

  describe "#users_list" do
    let(:slack_users_list) { fixture("slack_users_list") }

    before do
      stub_request(:get, "https://slack.com/api/users.list")
        .with(headers:)
        .to_return(body: slack_users_list.to_json)
    end

    it "success" do
      expect(slack.users_list).to be_success
    end

    it "returns user list" do
      expect(slack.users_list).to include("members")
    end
  end
end
