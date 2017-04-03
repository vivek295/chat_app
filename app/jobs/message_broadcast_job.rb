class MessageBroadcastJob < ApplicationJob
  queue_as :urgent

  def perform(message)
    sender = message.user
    recipient = message.conversation.opposed_user(sender)
 
    broadcast_to_sender(sender, message)
    broadcast_to_recipient(recipient, message)
  end
 
  private
 
  def broadcast_to_sender(user, message)
    ActionCable.server.broadcast(
      "room_channel_user_#{user.id}",
      message: render_message(message, user),
      conversation_id: message.conversation_id,
      type: "Message"
    )
  end
 
  def broadcast_to_recipient(user, message)
    ActionCable.server.broadcast(
      "room_channel_user_#{user.id}",
      window: render_window(message.conversation, user),
      message: render_message(message, user),
      conversation_id: message.conversation_id,
      type: "Message"
    )
    send_notifications(user, message)
  end
 
  def render_message(message, user)
    ApplicationController.render(
      partial: 'messages/message',
      locals: { message: message, user: user }
    )
  end

  def render_window(conversation, user)
    ApplicationController.render(
      partial: 'conversations/conversation',
      locals: { conversation: conversation, user: user }
    )
  end

  def send_notifications(user, message)
    user = User.find(user.id)
    text= "#{user.username} sent a new message"
    MessageNotification.create(user_id: user.id, notification_text: text)
    notes = user.message_notifications.where(seen: false).count
    ActionCable.server.broadcast "room_channel_user_#{user.id}",
      message: text, count: notes, type: "MessageNotification"
  end

end
