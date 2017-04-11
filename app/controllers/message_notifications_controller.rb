class MessageNotificationsController < ApplicationController
	before_action :authenticate_user!

	def index
		@message_notifications = current_user.message_notifications.paginate(page: params[:page], per_page: 5).order(updated_at: :desc)
		MessageNotification.where(seen: false).update_all(seen: true)
	end

end