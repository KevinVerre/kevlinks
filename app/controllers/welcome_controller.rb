class WelcomeController < ApplicationController
  def index
    if current_user
      redirect_to current_user.root
    end
  end

  def about
    @example_user = User.find_by(email: ENV['EXAMPLE_USER_EMAIL'])
    @about_post = Post.find_by(user_id: @example_user.id, title: 'FolderNotes Information Center', private: false)

    if @about_post
      redirect_to @about_post
      return
    end
  end

  def example
    @example_user = User.find_by(email: ENV['EXAMPLE_USER_EMAIL'])

    if @example_user
      redirect_to @example_user
      return
    end
  end
end
