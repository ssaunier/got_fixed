module GotFixed
  class UserMailer < ActionMailer::Base
    default from: GotFixed.config[:user_mailer][:from]

    def issue_got_fixed_email(user, issue)
      subject = GotFixed.config[:user_mailer][:subject_template] % issue.attributes.symbolize_keys
      mail(to: user.email, subject: subject)
    end
  end
end
