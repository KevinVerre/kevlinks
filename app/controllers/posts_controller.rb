class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @children = @post.children
  end

  def new
  end

  def edit
  end
end
