class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_user_#{user_notified.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end

  def speak(data)
    message_params = data['message'].each_with_object({}) do |el, hash|
      hash[el.values.first] = el.values.last
    end
 
    Message.create(message_params)
  end
end