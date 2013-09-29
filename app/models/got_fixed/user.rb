# == Schema Information
#
# Table name: got_fixed_users
#
#  id         :integer          not null, primary key
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

module GotFixed
  class User < ActiveRecord::Base
    validates_presence_of :email
    validates_uniqueness_of :email
    validates_format_of :email, :with => /\A([-a-z0-9!\#$%&'*+\/=?^_`{|}~]+\.)*[-a-z0-9!\#$%&'*+\/=?^_`{|}~]+@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

    has_and_belongs_to_many :issues

    def send_notification(issue)
      # TODO(ssaunier): async send (SMTP is slow !!)
      mail = UserMailer.issue_got_fixed_email(self, issue)
      mail.deliver
    end
  end
end
