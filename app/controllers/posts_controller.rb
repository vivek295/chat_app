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
		@posts = Post.all
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

	private

		def post_params
			params.require(:post).permit(:id, :content)
		end

end