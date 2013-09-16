require 'spec_helper'

module GotFixed
  module Adapters
    describe Github do
      describe "#new" do
        it "should allow to build an object without any parameters" do
          lambda { Github.new }.should_not raise_error ArgumentError
        end
      end

      describe "#issues" do
        it "should raise an argument error if :access_token is missing" do
          @github = Github.new
          lambda { @github.issues }.should raise_error ArgumentError
        end

        it "should not raise the argument error for :access_token if provided in #new" do
          @github = Github.new :access_token => "foo"
          lambda {
            ArgumentError.should_not_receive(:new).with("Missing mandatory :access_token option")
            ArgumentError.should_receive(:new).once.with("Missing mandatory :owner option")
            @github.issues
          }
        end

        it "should not raise the argument error for :access_token if provided as option" do
          @github = Github.new
          lambda {
            ArgumentError.should_not_receive(:new).with("Missing mandatory :access_token option")
            ArgumentError.should_receive(:new).once.with("Missing mandatory :owner option")
            @github.issues :access_token => "foo"
          }
        end

        it "should not raise the argument error for :owner if provided in #new" do
          @github = Github.new :access_token => "foo", :owner => "owner"
          lambda {
            ArgumentError.should_not_receive(:new).with("Missing mandatory :owner option")
            ArgumentError.should_receive(:new).once.with("Missing mandatory :repo option")
            @github.issues
          }
        end

        it "should not raise the argument error for :owner if provided as option" do
          @github = Github.new
          lambda {
            ArgumentError.should_not_receive(:new).with("Missing mandatory :owner option")
            ArgumentError.should_receive(:new).once.with("Missing mandatory :repo option")
            @github.issues :access_token => "foo", :owner => "owner"
          }
        end

        it "should not raise the argument error for :repo if provided in #new" do
          @github = Github.new :access_token => "foo", :owner => "owner", :repo => "repo"
          lambda { @github.issues }.should_not raise_error ArgumentError
        end

        it "should not raise the argument error for :repo if provided as option" do
          @github = Github.new
          lambda { @github.issues  :access_token => "foo", :owner => "owner", :repo => "repo" }.should_not raise_error ArgumentError
        end

      end
    end
  end
end
