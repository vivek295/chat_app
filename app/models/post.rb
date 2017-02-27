class Post < ApplicationRecord
	belongs_to :user

	# after_create :create_notification

	def send_notifications
		user = User.find(self.user_id)
		text= "#{user.username} Created a new Post"
		user.inverse_friends.each do |friend|
			Notification.create(user_id: friend.id, notification_text: text)
			notes = friend.notifications.where(seen: false).count
			ActionCable.server.broadcast "room_channel_user_#{friend.id}",
        message: text, count: notes
    end
	end

	# def create_notification
	# 	user = User.find(self.user_id)
	# 	text = user.username + " Created a new Post"
	# 	Notification.create(user_id: self.user_id, notification_text: text)
	# end
	# handle_asynchronously :send_notifications
end