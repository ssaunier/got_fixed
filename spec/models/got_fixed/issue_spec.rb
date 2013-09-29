require 'spec_helper'

module GotFixed
  describe Issue do
    before(:each) do
      @issue = FactoryGirl.create :got_fixed_issue
    end

    it "should not send any email on issue closing if no one is registered" do
      @issue.users.should be_blank
      @issue.closed = true
      @issue.save
      ActionMailer::Base.deliveries.last.should be_nil
    end
  end
end
