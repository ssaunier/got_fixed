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
gem "got_fixed"
```

And then execute:

    $ bundle install

Install GotFixed into your application with the following.

    $ bundle exec rails g got_fixed:install

It will add a route to `config/routes.rb` mounting the `got_fixed` engine, and create
the following files:

```
.
|-- app
|   `-- views
|       |-- got_fixed
|           |-- issues
|           |   |-- index.html.erb
|           |   `-- subscribe.js.erb
|           `-- user_mailer
|               `-- issue_got_fixed_email.text.erb
`-- config
    `-- got_fixed.yml
```

GotFixed uses ActiveRecord to store issues and subscribers. Install migrations with
the following:

    $ bundle exec rake got_fixed:install:migrations
    $ bundle exec rake db:migrate

Now let's perform some manual steps to configure GotFixed:

1. Open `config/routes.rb` and check that the mounting point suits your need. By default it's `/got_fixed`.
2. Open `config/got_fixed.yml` and configure which GitHub repositories you want to expose in the dashboard.
   For each repo, you can set up a list of tags to whitelist which issue you want to disclose in the dashboard.
   If this list is empty, GotFixed will expost all issues.
3. Open the three `views` created to customize the dashboard, and the email your users will receive.

To help with this view editing, we'll need some issues. You can import GitHub issues
from repos you configured in `config/got_fixed.yml` with the following command:

    $ bundle exec rake got_fixed:import_github

You should now be able to run your application and view some issues at
[`localhost:3000/got_fixed`](http://localhost:3000/got_fixed).

    $ bundle exec rails s

## Deployment

If you followed carefully all the steps described in the [Install](#install) section,
you should have a great dashboard branded to your product. It's time to push it to production.
Let's assume you host your app on Heroku. If you don't, please extrapolate, you should get
the main idea.

    $ git push heroku master
    $ heroku run bundle exec rake db:migrate

You can seed the dashboard issue database with the following rake command you already
ran in development:

    $ heroku run bundle exec rake got_fixed:import_github

You may ask, should I run this every time I want to update the dashboard? Should I setup
a cron job? No! There is a better solution, using
[Github post-receive-hooks](https://help.github.com/articles/post-receive-hooks). GotFixed
comes with a simple rake task you can run to setup this webhook.

    $ heroku run bundle exec rake got_fixed:register_github_webhook

You're ready! Now every time an issue with relevant labels is created, it will appear on the
dashboard a few seconds later. You can then email your user with a link to the dashboard and
tell them they can register their email address to be notified once this issue is closed.

Be careful, the email will be sent as soon as the issue is *closed*, so this whole notification
thing only makes sense if you practise continous deployment.


## Test in dummy app:

You can launch the dummy rails app with the following command:
```
(cd spec/dummy && bundle exec rails s)
```
And then point your browser to [localhost:3000](http://localhost:3000), you should be redirected
to the `/got_fixed` engine route.
