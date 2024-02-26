class NoticeNotStartedJob < ApplicationJob
  queue_as :default

  def perform(toothbrush)
    # Do something later
    toothbrush.notice_not_started
  end
end
