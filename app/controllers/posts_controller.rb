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
  end

  def new
    @post = Post.new
    @parent_id = params[:parent_id]
    logger.debug "@parent_id: #{@parent_id}"

  end

  def create
    my_params = params.require(:post).permit(:parent_id, :title, :body, :ptype)
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

end
