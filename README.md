Events@Penn
================

[Events@Penn](https://eventsatpenn.com) is a events aggregation website built by the web team at [The Daily Pennsylvanian](https://thedp.com).

Ruby on Rails
-------------

This application requires:

- Ruby 2.4.0
- Rails 5.1.1

Getting Started
---------------

Make sure you have Ruby installed by running `ruby -v` on the command line. This project requires v2.4.0, so make sure you have at least that version. If the command returns `"ruby: command not found"`, run `brew install ruby` (see [here](https://github.com/dailypenn/onboarding) if you're using anything other than MacOS).

Clone the repo into whichever folder you keep your DP work in.
```shell
git clone git@github.com:dailypenn/eventsatpenn.git
```

Move to the `eventsatpenn` root folder and run `bundle install` to install all of the gem dependencies for this project. This may take a minute.

You'll have to specify that you're working in the development environment.
To do this, run the following command:
```shell
export RAILS_ENV="development"
```
This will specify to the database to use SQLite, which we use for development, rather than MySQL, which we use for production.

Run `rake db:drop`, `rake db:create`, and `rake db:migrate` to clear and set up the database tables. Run `rails s`, and go to `localhost:3000` in your browser of choice to see the app!

Deploying
---------

Events@Penn uses Capistrano to deploy to a server on Google Cloud. You can
[read more here](https://tosbourn.com/how-does-capistrano-work/) about how
Capistrano works, but at a high level, it uses SSH to deploy files to a remote
server and run commands as defined in the `Capfile` and `config/deploy` files.

1. Download the `dp_master_rsa` public and private keys. They can be found on
   Google Drive, or ask someone for them. Put them in your `~/.ssh` folder.
2. Edit (or create, if you don't currently have one), a `~/.ssh/config` file. Add
   the following line:
   ```
   Host eventsatpenn.com
     IdentityFile ~/.ssh/dp_master_rsa
    ```
3. Run `cap production deploy`. This will use the `production.rb` configuration
   file to deploy the app to our production server.

Capistrano deploys the app to a folder called `html` in the `rails` user's home
folder. This folder is symlinked to `/var/www/html`, which nginx serves. Capistrano
then restarts puma, the webserver, and nginx, the reverse proxy.


Credits
-------

Built by the web development team at [The Daily Pennsylvanian](https://thedp.com).
