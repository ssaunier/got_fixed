module GotFixed
  class UserMailer < ActionMailer::Base
    default from: GotFixed.config[:user_mailer][:from]

    def issue_got_fixed_email(user, issue)
      mail(to: user.email, subject: "[Fixed] #{}")
    end
  end
end
