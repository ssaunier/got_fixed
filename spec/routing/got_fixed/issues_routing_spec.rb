require "spec_helper"

module GotFixed
  describe IssuesController do
    routes { GotFixed::Engine.routes }

    describe "routing" do

      it "routes to #index" do
        get("/issues").should route_to("got_fixed/issues#index")
      end

    end
  end
end
