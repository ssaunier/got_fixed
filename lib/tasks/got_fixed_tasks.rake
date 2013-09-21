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
      repo.symbolize_keys!
      if repo[:webhook_secret].blank?
        puts "/!\\ Empty webhook_secret for repository #{repo[:owner]}/#{repo[:repo]}, skipping webhook creation"
        next
      end

      github = GotFixed::Adapters::Github.new(repo)
      github.create_hook :url => listener_url, :secret => repo[:webhook_secret]
      puts "Successfully created hook for #{repo[:owner]}/#{repo[:repo]}. " +
           "You can visualize it at https://github.com/#{repo[:owner]}/#{repo[:repo]}/settings/hooks"
    end
  end

end