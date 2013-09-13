# desc "Explaining what the task does"
# task :got_fixed do
#   # Task goes here
# end

namespace :got_fixed do

  desc "Import github issues from repos found in config"
  task :import_github => :environment do
    GotFixed.config[:github].each do |repo|
      repo.symbolize_keys!
      github = GotFixed::Adaptors::Github.new repo[:auth_token]
      github.issues(repo).each do |issue|
        # TODO: Use a factory to store the issue in DB
      end
    end
  end

end