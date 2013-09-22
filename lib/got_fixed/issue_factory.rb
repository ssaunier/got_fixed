module GotFixed
  class IssueFactory
    def from_github(github_issue)
      issue = Issue.find_or_initialize_by :vendor_id => github_issue["id"], :vendor => "github"
      issue.title = github_issue["title"]
      issue.closed = github_issue["state"] == "closed"
      issue.number = github_issue["number"]
      issue
    end
  end
end