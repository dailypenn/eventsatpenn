# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron
#
# Learn more: http://github.com/javan/whenever

set :output, 'log/cron.log'

every 30.minutes do
  command '. /etc/default/unicorn' # get env variables
  runner 'ScrapeEventsForAllOrgsJob.perform_now'
end
