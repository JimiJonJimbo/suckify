class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new]

  def create
    @post = current_user.posts.build(post_params)

    @post.get_thumbnail

    if @post.save
      redirect_to @post, notice: "Your post has been created."
    else
      render 'new'
    end
  end

  def index
    @posts = Post.order(score: :desc).paginate(page: params[:page], per_page: 12)
  end

  def new
    @post = current_user.posts.build
  end

  def show
    @post = Post.find(params[:id])
  end

  def vote
    @post = Post.find(params[:id])
    @post.save if @post.upvote_by current_user # to update score

    if current_user
      respond_to do |format|
        format.html { redirect_to @post }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to new_user_session_path, notice: t('devise.failure.unauthenticated'), status: 303 }
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
