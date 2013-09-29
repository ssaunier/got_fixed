module GotFixed
  class User < ActiveRecord::Base
    has_and_belongs_to_many :issues

    def send_notification(issue)
      # TODO(ssaunier): async send (SMTP is slow !!)
      mail = UserMailer.issue_got_fixed_email(self, issue)
      mail.deliver
    end
  end
end
