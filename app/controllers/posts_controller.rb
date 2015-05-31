class PostsController < ApplicationController
  # layout 'home', only: :index

  before_action :authenticate_user!, only: [:create, :new]

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, notice: "Post successfully created"
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

  private

    def post_params
      params.require(:post).permit(
        :link,
        :title,
        :description)
    end
end
