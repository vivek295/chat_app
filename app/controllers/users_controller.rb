require 'irb'
class UsersController < ApplicationController
	before_action :authenticate_user!
	def index
		@users = User.where.not(id: current_user.friends.pluck(:id)<< current_user.id).paginate(page: params[:page], per_page: 20)
	end

	def show
		@user = User.includes(:friends,:inverse_friends,:subscriptions).find(params[:id])
	end

	def profile
		@user = User.find(params[:id])
		@posts = current_user.posts.order(created_at: :desc).paginate(page: params[:page], per_page: 6)
	end
end