require "spec_helper"

module GotFixed
  describe UserMailer do
    describe "#subject (private)" do
      it "should evaluate template with issue title" do
        @user_mailer = UserMailer.send :new
        issue = FactoryGirl.build :got_fixed_issue, :title => "Dummy issue"
        old_config = GotFixed.config
        GotFixed.config = {
          :user_mailer => {
            :subject_template => "[Fixed] %{title}"
          }
        }
        @user_mailer.send(:subject, issue).should eq "[Fixed] Dummy issue"
        GotFixed.config = old_config
      end
    end
  end
end
