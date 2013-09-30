require "got_fixed/engine"
require "got_fixed/issue_factory"
require "got_fixed/adapters/github"
require "got_fixed/receivers/github_webhook"

module GotFixed
  mattr_accessor :config
end

begin
  WebMock.disable! if require "webmock"
rescue LoadError
  # When gem is included in 3rd-party project, don't want to use webmock
end