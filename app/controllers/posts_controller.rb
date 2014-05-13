class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])

    if @post.ptype == LINK_TYPE || @post.ptype == TWEET_TYPE
      redirect_to @post.parent
    end

    @children = @post.children

    @new_post = Post.new
  end

  def new
    @post = Post.new
    @parent_id = params[:parent_id]
    @parent_title = Post.find(@parent_id).title
  end

  def create
    my_params = post_params
    @post = Post.new(my_params)
    @post.user = current_user

    logger.debug "DEBUG: my_params[:parent_id] #{my_params[:parent_id]}"

    if @post.save
      redirect_to @post
    else
      render :show
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    puts "Attempting to delete"
    if current_user == @post.user
      puts "User is logged in and is the owner"
      parent_post = @post.parent
      if parent_post
        if @post.destroy
          redirect_to parent_post
          return
        end
      end
    end

    render :show
  end

  def post_params
    params.require(:post).permit(:parent_id, :title, :body, :ptype, :private)
  end

end
