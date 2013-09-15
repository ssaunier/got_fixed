require "httparty"

module GotFixed
  module Adapters
    class Github
      include HTTParty
      base_uri "https://api.github.com"

      def initialize(access_token)
        @access_token = access_token
      end

      # Retrieve all issues of a given GitHub repository matching given labels
      # Labels must be comma separated, e.g. "public,foo,bar"
      #
      # Doc: http://developer.github.com/v3/issues/#list-issues-for-a-repository
      def issues(options)
        owner  = options[:owner]
        repo   = options[:repo]
        labels = options[:labels]

        opened = issues_with_state(owner, repo, labels, :open)
        closed = issues_with_state(owner, repo, labels, :closed)
        opened + closed
      end

      def hooks(owner, repo)
        self.class.get "/repos/#{owner}/#{repo}/hooks", :query => { :access_token => @access_token }
      end

      def create_hook(owner, repo)
        body = {
          :name => "web",
          :config => {
            :url => "http://requestb.in/1dhgpxf1",
            :content_type => "json",
            :secret => "secret"  # TODO(ssaunier): check X-Hub-Signature
          },
          :events => [ 'issues' ]
        }
        self.class.post "/repos/#{owner}/#{repo}/hooks", :body => body.to_json, :headers => headers
      end

      private

      def issues_with_state(owner, repo, labels, state)
        query = { :labels => labels, :access_token => @access_token }
        self.class.get "/repos/#{owner}/#{repo}/issues", :query => query.merge(:state => state)
      end

      def headers
        {
          "Authorization" => "token #{@access_token}"
        }
      end

    end
  end
end