class SendNotificationService
	attr_accessor :current_user, :inverse_friends

	def initialize(current_user, inverse_friends)
		@current_user = current_user
		@inverse_friends = inverse_friends
		send_notifications
	end

	def send_notifications
		@inverse_friends.each do |friend|
			ActionCable.server.broadcast "room_channel_user_#{friend.id}",
        message: "#{@current_user.username} Created a new Post"
      head :ok
    end
	end

end