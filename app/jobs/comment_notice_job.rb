class CommentNoticeJob < ApplicationJob
  queue_as :default

  def perform(toothbrush)
    # Do something later
    toothbrush.comment_notice_and_update
  end
end
