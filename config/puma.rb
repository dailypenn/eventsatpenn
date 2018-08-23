#!/usr/bin/env puma
if ENV.fetch('RAILS_ENV') == 'production'

  directory '/home/rails/html/current'
  rackup "/home/rails/html/current/config.ru"
  environment 'production'

  tag ''

  pidfile "/home/rails/html/shared/tmp/pids/puma.pid"
  state_path "/home/rails/html/shared/tmp/pids/puma.state"
  stdout_redirect '/home/rails/html/shared/log/puma_access.log', '/home/rails/html/shared/log/puma_error.log', true

  threads 0,16

  bind 'unix:///home/rails/html/shared/tmp/sockets/puma.sock'

  workers 0

  prune_bundler

  on_restart do
    puts 'Refreshing Gemfile'
    ENV["BUNDLE_GEMFILE"] = "/home/rails/html/current/Gemfile"
  end
else
  threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
  threads threads_count, threads_count
  port        ENV.fetch("PORT") { 3000 }
  environment ENV.fetch("RAILS_ENV") { "development" }
  plugin :tmp_restart
end
