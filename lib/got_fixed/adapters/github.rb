require "httparty"

module GotFixed
  module Adapters
    class Github
      include HTTParty
      base_uri "https://api.github.com"

      attr_accessor :access_token, :owner, :repo, :webhook_secret

      HMAC_DIGEST = OpenSSL::Digest::Digest.new('sha1')
      class GithubWebhookSignatureError < StandardError; end

      def initialize(options = {})
        ensure_mandatory_parameters options, true
      end

      # Retrieve all issues of a given GitHub repository matching given labels
      # Labels must be comma separated, e.g. "public,foo,bar"
      #
      # Doc: http://developer.github.com/v3/issues/#list-issues-for-a-repository
      def issues(options = {})
        ensure_mandatory_parameters options
        labels = options[:labels]

        opened = issues_with_state(labels, :open)
        closed = issues_with_state(labels, :closed)
        opened + closed
      end

      def hooks(options = {})
        ensure_mandatory_parameters options
        self.class.get "/repos/#{@owner}/#{@repo}/hooks", :headers => headers
      end

      def create_hook(options = {})
        ensure_mandatory_parameters options
        url = options[:url] || "http://requestb.in/1dhgpxf1"

        body = {
          :name => "web",
          :config => {
            :url => url,
            :content_type => "json",
            :secret => @webhook_secret
          },
          :events => [ 'issues' ]
        }
        self.class.post "/repos/#{@owner}/#{@repo}/hooks", :body => body.to_json, :headers => headers
      end

      def check_hub_signature!(header, body)
        expected_signature = "sha1=#{OpenSSL::HMAC.hexdigest(HMAC_DIGEST, @webhook_secret, body)}"
        if header != expected_signature
          raise GithubWebhookSignatureError.new "#{header} != #{expected_signature}"
        end
      end

      private

      def ensure_mandatory_parameters(options, allow_empty = false)
        [:access_token, :owner, :repo, :webhook_secret].each do |option|
          self.send :"#{option}=", options[option] unless blank?(options[option])
          if !allow_empty && blank?(self.send option)
            raise ArgumentError.new "Missing mandatory :#{option} option"
          end
        end
      end

      def issues_with_state(labels, state)
        query = { :labels => labels, :state => state }
        self.class.get "/repos/#{@owner}/#{@repo}/issues", :query => query, :headers => headers
      end

      def headers
        {
          "Authorization" => "token #{@access_token}"
        }
      end

      def blank?(str)
        str.nil? || str == ""
      end

    end
  end
end