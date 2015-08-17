class PostsController < ApplicationController
  # before_action :authenticate_user!

  def index
    @posts = Post.all # retrieve all the Post data, and store them in the variable @posts
  end

  def create
    @post = Post.new(post_params)

    @post.save
  end

  def update
    @post = Post.find_by_id(params[:id])

    if @post.nil?
      render json: {
        message: "Cannot find post"
      }, status: :not_found
    else
      @post.update(post_params)
    end
  end

  def show
    @post = Post.find_by_id(params[:id])
    
    if @post.nil?
      render json: {
        message: "Cannot find post"
      }, status: :not_found
    end
  end

  def destroy
    @post = Post.find_by_id(params[:id])

    if @post.nil?
      render json: {
        message: "Cannot find post"
      }, status: :not_found
    else
      if @post.destroy
        render json: {
          message: "Successfully deleted"
        }, status: :no_content
      else
        render json: {
          message: "Unsuccessfully deleted"
        }, status: :bad_request
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :category, :picture)
  end
end