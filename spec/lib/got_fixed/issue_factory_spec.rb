require 'spec_helper'

module GotFixed
  describe IssueFactory do
    before(:each) do
      @issue_factory = IssueFactory.new
    end

    describe "#from_github" do

      it "should create an issue from an opened GitHub issue" do
        open_issues = JSON.load(File.open "spec/factories/github/open.json")
        issue = @issue_factory.from_github(open_issues.first)
        issue.should_not be_nil
        issue.closed.should be_false
        issue.title.should eq open_issues.first["title"]
      end

    end
  end
end
