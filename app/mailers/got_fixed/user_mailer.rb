module GotFixed
  class UserMailer < ActionMailer::Base
    default from: GotFixed.config[:user_mailer][:from]

    def issue_got_fixed_email(user, issue)
      @user = user
      @issue = issue
      mail(to: @user.email, subject: subject(issue))
    end

    def subject(issue)
      template = GotFixed.config[:user_mailer][:subject_template]
      template % issue.attributes.symbolize_keys
    end
  end
end
