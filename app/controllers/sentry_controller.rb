# require 'sentry-raven'
#
# class SentryController < ApplicationController
#   def exception
#     begin
#       1 / 0
#     rescue ZeroDivisionError => exception
#       Raven.capture_exception(exception)
#     end
#   end
# end
