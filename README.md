[![Build Status](https://travis-ci.org/ssaunier/got_fixed.png)](https://travis-ci.org/ssaunier/got_fixed)

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

    Awesome::Application.routes.draw do

      mount GotFixed::Engine => "/got_fixed"

    end

`GotFixed` need the following configuration file, `config/got_fixed.yml`

    github:
      - access_token: <%= ENV['GITHUB_PERSONAL_ACCESS_TOKEN'] %>
        repo: secret_repo
        owner: ssaunier
        labels: public
      - access_token: <%= ENV['GITHUB_PERSONAL_ACCESS_TOKEN'] %>
        repo: other_secret_repo
        owner: ssaunier
        labels:public

TODO(ssaunier): explain the database installation + rake task
to init the DB.

## Test in dummy app:

You can launch the dummy rails app with the following command:
```
(cd spec/dummy && bundle exec rails s)
```
And then point your browser to [localhost:3000](http://localhost:3000), you should be redirected
to the `/got_fixed` engine route.
