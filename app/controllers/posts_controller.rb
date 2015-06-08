class PostsController < ApplicationController
	before_action :find_post, only: [:show, :edit, :update, :destroy]
	before_action :authorized?, except: :index
	
	def index
		#reverse order
		@post = Post.all.order("created_at DESC")
	end

	def show
		@img = EXIFR::JPEG.new(@post.image.path)
		#before_action find_post will help display
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		# flash message when successful 
		@post.user = current_user
		if @post.save
			redirect_to @post, notice: "Successfully created new post!"
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		#flash message when sucessful
		if @post.update(post_params)
			redirect_to @post, notice: "Successfully updated!"
		else 
			render 'edit'
		end
	end

	def destroy
		@post.destroy
		redirect_to root_path
	end
	private

	def post_params
		params.require(:post).permit(:title, :description, :image)
	end
	def find_post
		@post = Post.find(params[:id])
	end

end
