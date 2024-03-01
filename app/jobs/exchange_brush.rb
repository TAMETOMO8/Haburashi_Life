class ExchangeBrushJob < ApplicationJob
  queue_as :default
  require 'line_message'

  def perform(*args); end
end
