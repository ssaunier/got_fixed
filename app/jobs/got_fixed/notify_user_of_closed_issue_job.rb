module GotFixed
  class NotifyUserOfClosedIssueJob
    @queue = GotFixed.config[:resque][:queue]

    def self.perform(user_id, issue_id)
      user = User.find(user_id)
      issue = Issue.find(issue_id)
      UserMailer.issue_got_fixed_email(user, issue).deliver
    end
  end
end