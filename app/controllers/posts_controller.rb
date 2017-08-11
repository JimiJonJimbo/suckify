class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new]

  def create
    @post = current_user.posts.build(post_params)

    @post.thumbnail = LinkThumbnailer.generate(@post.link).images.first if @post.link.present?

    if @post.save
      redirect_to @post, notice: "Post successfully created."
    else
      render 'new'
    end
  end

  def index
    # @posts = Post.all.sort_by(&:score).reverse
    @posts = Post.all.sort_by { |post| [post.score, post.created_at] }.reverse
  end

  def new
    @post = current_user.posts.build
  end

  def show
    @post = Post.find(params[:id])
  end

  def vote
    @post = Post.find(params[:id])
    @post.upvote_by current_user

    if current_user
      respond_to do |format|
        format.html { redirect_to @post }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to new_user_session_path, notice: "You must log in to vote.", status: 303 }
        format.js do
          flash[:alert] = t('devise.failure.unauthenticated')
          flash.keep(:alert)
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
