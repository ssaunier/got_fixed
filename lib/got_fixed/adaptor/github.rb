require "httparty"

module GotFixed
  module Adaptor
    class Github
      include HTTParty
      base_uri "https://api.github.com"

      def initialize(auth_token)
        @auth_token = auth_token
      end

      # Retrieve all issues of a given GitHub repository
      #
      # Relevant options for GotFixed:
      #   - state: open|closed (default: open)
      #   - labels: public,foo,bar
      #
      # More options listed here:
      #   http://developer.github.com/v3/issues/#list-issues-for-a-repository
      #
      def issues(owner, repo, options = {})
        options.merge! :auth_token => @auth_token
        self.class.get "/repos/#{owner}/#{repo}/issues", options
      end

    end
  end
end