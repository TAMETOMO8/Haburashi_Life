class ExchangeBlushJob < ApplicationJob
  queue_as :default

  def perform(toothbrush)
    # Do something later
    toothbrush.exchange_brush
  end
end
