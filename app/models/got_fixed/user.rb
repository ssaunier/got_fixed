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
      if Module.const_defined?(:Resque) && Resque.respond_to?(:enqueue)
        Resque.enqueue(NotifyUserOfClosedIssueJob, self.id, issue.id)
      else
        NotifyUserOfClosedIssueJob.perform(self.id, issue.id)
      end
    end
  end
end
