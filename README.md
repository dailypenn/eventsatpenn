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

Clone the repo into whichever folder you keep your DP work in. Make sure to use SSH.
```shell
git clone git@github.com:dailypenn/eventsatpenn.git
```

Move to the `eventsatpenn` root folder and run `bundle install` to install all of the gem dependencies for this project. This may take a minute.

Run `rake db:drop`, `rake db:create`, and `rake db:migrate` to clear and set up the database tables. Run `rails s`, and go to `localhost:3000` in your browser of choice to see the app!

Credits
-------

Built by the web development team at [The Daily Pennsylvanian](https://thedp.com).

License
-------
