# desc "Explaining what the task does"
# task :got_fixed do
#   # Task goes here
# end

namespace :got_fixed do

  desc "Import github issues from repos found in config/got_fixed.yml"
  task :import_github => :environment do
    issue_factory = GotFixed::IssueFactory.new

    GotFixed.config[:github].each do |repo|
      github = GotFixed::Adapters::Github.new
      issues = github.issues(repo)
      puts "Found #{issues.size} issues for #{repo_name(repo)}, filtering on labels '#{repo[:labels]}'"

      issues.each do |gh_issue|
        issue = issue_factory.from_github gh_issue
        if issue.save
          puts "Issue ##{gh_issue["number"]} #{issue.persisted? ? "updat" : "import"}ed: #{gh_issue["title"]}"
        else
          puts "\e[32mCould not import issue ##{gh_issue["number"]} from #{repo_name(repo)}: #{issue.errors.messages}\e[0;0m"
        end
      end
    end
  end

  task :register_github_webhook => :environment do
    listener_url = nil
    while true
      puts "What is the base URI of your host app? (e.g. https://myapp.herokuapp.com)"
      host = STDIN.gets.strip

      listener_url = GotFixed::Engine.routes.url_helpers.github_webhook_issues_url :host => host
      puts "We'll tell Github to post issue changes to \e[32m#{listener_url}\e[0;0m. Looks good? (y/n)"
      break if STDIN.gets.strip == "y"
    end

    GotFixed.config[:github].each do |repo|
      if repo[:webhook_secret].blank?
        puts "/!\\ Empty webhook_secret for repository #{repo_name(repo)}, skipping webhook creation"
        next
      end

      github = GotFixed::Adapters::Github.new(repo)
      github.create_hook :url => listener_url, :secret => repo[:webhook_secret]
      puts "Successfully created hook for #{repo_name(repo)}. " +
           "You can visualize it at https://github.com/#{repo_name(repo)}/settings/hooks"
    end
  end

  def repo_name(repo)
    "#{repo[:owner]}/#{repo[:repo]}"
  end

end