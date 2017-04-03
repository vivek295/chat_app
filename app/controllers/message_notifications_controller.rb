class MessageNotificationsController < ApplicationController
	before_action :authenticate_user!

	def index
		@message_notifications = current_user.message_notifications.paginate(page: params[:page], per_page: 5).order(created_at: :desc)
	end

end