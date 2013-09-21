require "httparty"

module GotFixed
  module Adapters
    class Github
      include HTTParty
      base_uri "https://api.github.com"

      attr_accessor :access_token, :owner, :repo

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
        secret = options[:secret] || "secret"  # TODO(ssaunier): check X-Hub-Signature on receive

        body = {
          :name => "web",
          :config => {
            :url => url,
            :content_type => "json",
            :secret => secret
          },
          :events => [ 'issues' ]
        }
        self.class.post "/repos/#{@owner}/#{@repo}/hooks", :body => body.to_json, :headers => headers
      end

      private

      def ensure_mandatory_parameters(options, allow_empty = false)
        [:access_token, :owner, :repo].each do |option|
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