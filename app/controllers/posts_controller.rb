class PostsController < ApplicationController
  # layout 'home', only: :index

  before_action :authenticate_user!, only: [:create, :new]

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, notice: "Post successfully created."
    else
      render 'new'
    end
  end

  def index
    @posts = Post.all
  end

  def new
    @post = current_user.posts.build
  end

  def show
    @post = Post.friendly.find(params[:id])
  end

  def suck
    @post = Post.friendly.find(params[:id])
    @post.upvote_by current_user

    if current_user
      respond_to do |format|
        format.html { redirect_to @post }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to new_user_session_path, notice: "You must log in to suck it.", status: 303 }
        format.js do
          flash[:notice] = "You must log in to suck it."
          flash.keep(:notice)
          render js: "window.location.pathname = #{new_user_session_path.to_json}"
        end
      end
    end
  end

  private

    def post_params
      params.require(:post).permit(
        :link,
        :title,
        :description)
    end
end
