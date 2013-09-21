module GotFixed
  module Receivers
    describe GithubWebhook do

      describe "#check_hub_signature!" do

        it "should not raise an error if signature is correct" do
          @github_webhook = GithubWebhook.new :secret => "secret"
          body = JSON.generate(JSON.load(File.open "spec/factories/github/hook-issues-event.json"))
          lambda { @github_webhook.check_hub_signature! "sha1=7e5f575e2e92360b4f13a2100d930e770f26fde3", body }.should_not raise_error
        end
      end

    end
  end
end