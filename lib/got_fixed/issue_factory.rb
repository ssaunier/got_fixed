module GotFixed
  class IssueFactory
    def from_github(github_issue)
      Issue.new \
        :title => github_issue["title"],
        :closed => github_issue["state"] == "closed"
    end
  end
end