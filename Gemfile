
# Gem Sources
source 'https://rubygems.org'

# Force HTTPS for Github Gems
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Ruby version
ruby '2.4.1'

# Gems
gem 'rails', '~> 5.1.1'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'activerecord-session_store'
gem 'fb_graph2'
gem 'simple_calendar', '~> 2.0'
gem 'inline_svg'
gem 'filterrific'
gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.17.47'
gem 'activeadmin', github: 'activeadmin'
gem 'active_bootstrap_skin'
gem 'meta-tags'
gem 'rack-cors',   require: 'rack/cors'
gem 'whenever',    require: false

group :production do
  gem 'sentry-raven'
  gem 'mysql2'
  gem 'unicorn'
end
group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'sqlite3'
end
group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'better_errors'
  gem 'rails_layout'
end
group :development do
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-rvm'
  gem 'capistrano3-puma', github: 'seuros/capistrano-puma'
  gem 'capistrano-bundler'
  gem 'capistrano-rails-console'
end
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'bootstrap-sass'
gem 'jquery-rails'
gem 'omniauth'
gem 'omniauth-facebook'
