class UsersController < ApplicationController
	before_action :authenticate_user!
	def index
		@users = User.all
	end

	def show
		@user = User.includes(:friends,:inverse_friends,:subscriptions).find(params[:id])
	end

end