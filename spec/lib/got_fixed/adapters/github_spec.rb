require 'spec_helper'

module GotFixed
  module Adapters
    describe Github do
      describe "#new" do
        it "should allow to build an object without any parameters" do
          lambda { Github.new }.should_not raise_error ArgumentError
        end
      end
    end
  end
end
