# desc "Explaining what the task does"
# task :got_fixed do
#   # Task goes here
# end

namespace :got_fixed do

  desc "Import github issues from repos found in config/got_fixed.yml"
  task :import_github => :environment do
    issue_factory = GotFixed::IssueFactory.new

    GotFixed.config[:github].each do |repo|
      repo.symbolize_keys!
      github = GotFixed::Adapters::Github.new
      github.issues(repo).each do |gh_issue|
        issue = issue_factory.from_github gh_issue
        if issue.save
          puts "Imported issue ##{gh_issue["number"]} from #{repo[:owner]}/#{repo[:repo]}: #{gh_issue["title"]}"
        else
          puts "/!\\ Could not import issue ##{gh_issue["number"]} from #{repo[:owner]}/#{repo[:repo]}: #{issue.errors.messages}"
        end
      end
    end
  end

end