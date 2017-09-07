class ScrapeEventsForAllOrgsJob < ApplicationJob
  queue_as :default

  def perform
    Org.all.each do |org|
      ScrapeNewEventsJob.perform_later(org) if org.fb?
    end
  end
end
