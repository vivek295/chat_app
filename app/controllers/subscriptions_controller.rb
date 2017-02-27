class SubscriptionsController < ApplicationController
	before_action :authenticate_user!
	def create
		@subscription = current_user.subscriptions.build(:friend_id => params[:friend_id])
	  if @subscription.save
	    flash[:notice] = "Subscription Added."
	    text = "#{current_user.username} subscribed you"
	    Notification.create(user_id: @subscription.friend_id,notification_text: text)
	    count = User.find(@subscription.friend_id).notifications.where(seen: false).count
      ActionCable.server.broadcast "room_channel_user_#{@subscription.friend_id}",
        message: text, 
        count: count
      head :ok
	    # redirect_to users_path
	  else
	    flash[:error] = "Unable to add Subscription"
	    redirect_to users_path
	  end
	end

	def destroy
		@subscription = current_user.subscriptions.where("user_id= ? and friend_id= ?",params[:id],params[:friend_id]).first
	  @subscription.destroy
	  flash[:notice] = "Removed Subscription."
	  redirect_to users_path
	end

	def show

	end

end