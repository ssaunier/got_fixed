require_dependency "got_fixed/application_controller"

module GotFixed
  class IssuesController < ApplicationController

    def index
      @issues = Issue.all
      respond_with @issues
    end
  end
end
