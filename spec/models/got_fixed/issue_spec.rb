require 'spec_helper'

module GotFixed
  describe Issue do
    before(:each) do
      @issue = FactoryGirl.create :got_fixed_issue
      ActionMailer::Base.deliveries = []  # Reset email queue
    end

    it "should not send any email on issue closing if no one is registered" do
      @issue.users.should be_blank
      @issue.closed = true
      @issue.save
      ActionMailer::Base.deliveries.last.should be_nil
    end

    it "should send an email on issue closing if one is registered" do
      user = FactoryGirl.create :got_fixed_user
      @issue.users << user
      @issue.save

      @issue.closed = true
      @issue.save
      ActionMailer::Base.deliveries.last.should_not be_nil
      ActionMailer::Base.deliveries.last.to.first.should eq user.email
    end

    it "should send 10 emails if 10 people are registered" do
      10.times { @issue.users << FactoryGirl.create(:got_fixed_user) }
      @issue.save

      @issue.closed = true
      @issue.save
      ActionMailer::Base.deliveries.size.should eq 10
    end

  end
end
