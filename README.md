[![Build Status](https://travis-ci.org/ssaunier/got_fixed.png)](https://travis-ci.org/ssaunier/got_fixed)
[![Coverage Status](https://coveralls.io/repos/ssaunier/got_fixed/badge.png?branch=mail-upon-issue-closed)](https://coveralls.io/r/ssaunier/got_fixed?branch=mail-upon-issue-closed)
[![Gem Version](https://badge.fury.io/rb/got_fixed.png)](http://badge.fury.io/rb/got_fixed)

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

```ruby
    gem 'got_fixed'
```

And then execute:

    $ bundle install

Install the config and the engine route with:

    $ rails g got_fixed:install

You *can* customize the engine monting point in `config/routes.rb`. You **must** specify
which repositories you want to serve through the GotFixed dashboard in `config/got_fixed.yml`.


## Test in dummy app:

You can launch the dummy rails app with the following command:
```
(cd spec/dummy && bundle exec rails s)
```
And then point your browser to [localhost:3000](http://localhost:3000), you should be redirected
to the `/got_fixed` engine route.
