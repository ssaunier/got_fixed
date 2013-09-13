# desc "Explaining what the task does"
# task :got_fixed do
#   # Task goes here
# end

namespace :got_fixed do

  desc "Import github issues from repos found in config/got_fixed.yml"
  task :import_github => :environment do
    issue_factory = IssueFactory.new

    GotFixed.config[:github].each do |repo|
      repo.symbolize_keys!
      github = GotFixed::Adaptors::Github.new repo[:auth_token]
      github.issues(repo).each do |gh_issue|
        issue = issue_factory.from_github gh_issue
        if issue.save
          puts "Imported issue ##{gh_issue["number"]} from #{repo[:owner]}/#{repo[:name]}: #{gh_issue["title"]}"
        else
          puts "/!\\ Could not import issue ##{gh_issue["number"]} from #{repo[:owner]}/#{repo[:name]}: #{issue.errors.messages}"
        end
      end
    end
  end

end