class NotificationsController < ApplicationController
	before_action :authenticate_user!
	def index
		@notifications = current_user.notifications.paginate(page: params[:page], per_page: 5).order(created_at: :desc)
		Notification.where(seen: false).update_all(seen: true)
	end
end