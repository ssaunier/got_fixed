module GotFixed
  module Receivers
    describe GithubWebhook do

      describe "#check_hub_signature!" do

        it "should not raise an error if signature is correct" do
          @github_webhook = GithubWebhook.new :secret => "secret"
          body = JSON.load(File.open "spec/factories/github/hook-issues-event.json").to_s
          lambda { @github_webhook.check_hub_signature! "sha1=44b42f6259f6c58afc28c4f616551ce2a09a159a", body }.should_not raise_error
        end
      end

    end
  end
end