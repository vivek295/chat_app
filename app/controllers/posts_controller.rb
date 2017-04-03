require 'irb'
class PostsController < ApplicationController
	before_action :authenticate_user!
	def new
		@post = current_user.posts.build
	end

	def create
		@post = current_user.posts.build(post_params)
		if @post.save
			flash[:success] = "Post created Successfully"
			@post.send_notifications
			redirect_to posts_path
		else
			flash[:error] = "Error Occured"
			redirect_to posts_path
		end
	end

	def edit
		@post = current_user.posts.find(params[:id])
	end

	def update
		@post = current_user.posts.find(params[:id])
		if @post.update(post_params)
			flash[:success] = "Changes Saved Successfully"
			redirect_to posts_path
		else
			flash[:error] = "Error while updating"
			redirect_to posts_path
		end
	end

	def index
		@posts = current_user.posts.order(created_at: :desc).paginate(page: params[:page], per_page: 6)
	end

	def destroy
		@post = current_user.posts.find(params[:id])
		if @post.destroy
			flash[:success] = "Post Deleted Successfully"
			redirect_to posts_path
		else
			flash[:error] = "Error while Deleting"
			redirect_to posts_path
		end
	end

	def show
		@post = Post.find(params[:id])
	end

	def feed
		
		if !params[:page]
			user = current_user
			user.last_drawn_at = Time.now
			user.save
		end
		@posts = Post.where(user_id: current_user.friends.pluck(:id)<< current_user.id).order(created_at: :desc).paginate(page: params[:page], per_page: 6)
	end

	def recent_posts
		user = current_user
		user.last_drawn_at = Time.now
		user.save
		@posts = Post.where(user_id: current_user.friends.pluck(:id)<< current_user.id ).order(created_at: :desc).where("created_at > ?",current_user.last_drawn_at)
	end

	private

		def post_params
			params.require(:post).permit(:id, :content)
		end

end