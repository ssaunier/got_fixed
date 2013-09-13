require 'spec_helper'

module GotFixed
  describe IssueFactory do
    before(:each) do
      @issue_factory = IssueFactory.new
    end

    describe "#from_github" do

      it "should create an issue from an opened Github issue" do
        open_issues = JSON.load(File.open "spec/factories/github/open.json")
        issue = @issue_factory.from_github(open_issues.first)
        issue.should_not be_nil
        issue.closed.should be_false
        issue.vendor_id.should eq 3910487
        issue.number.should eq 1
        issue.title.should eq open_issues.first["title"]
      end

      it "should create an issue from a closed Github issue" do
        open_issues = JSON.load(File.open "spec/factories/github/closed.json")
        issue = @issue_factory.from_github(open_issues.first)
        issue.should_not be_nil
        issue.closed.should be_true
        issue.vendor_id.should eq 9255225
        issue.number.should eq 6
        issue.title.should eq open_issues.first["title"]
      end

    end
  end
end
