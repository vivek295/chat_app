class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_user_#{user_notified.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end