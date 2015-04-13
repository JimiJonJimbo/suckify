class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def create
    @post = current_user.posts.build(post_params)

    redirect_to root_url
  end

  def index
  end

  def new
    @post = current_user.posts.build
  end

  private

  def post_params
  end
end
