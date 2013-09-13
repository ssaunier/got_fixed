# GotFixed

This gem provides an engine to help communicate to your users when issues they
report get fixed, given that your issue tracker is private. It extend your
web application with a public dashboard of your issue tracker.

As of this first version, only Github private repositories are supported. All
issues with a specific tag (e.g. `public`) will be fetched and exposed in
the dashboard. Once the engine is set up, you'll get a new page:

    http://myawesomeapp.com/got_fixed


## Installation

Add this line to your application's `Gemfile`:

    gem 'got_fixed'

And then execute:

    $ bundle

## Usage

You need to mount the engine in your `config/routes.rb`:

    mount GotFixed::Engine => "/got_fixed"

`GotFixed` need the following configuration file, `config/got_fixed.yml`

    github:
      - auth_token: <%= ENV['GITHUB_PRIVATE_AUTH_TOKEN'] %>
        repo: secret_repo
        owner: ssaunier
        labels: public
      - auth_token: <%= ENV['GITHUB_PRIVATE_AUTH_TOKEN'] %>
        repo: other_secret_repo
        owner: ssaunier
        labels:public

TODO(ssaunier): explain the database installation + rake task
to init the DB.
