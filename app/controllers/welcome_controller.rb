class WelcomeController < ApplicationController
  def index
    if current_user
      redirect_to current_user.root
    end
  end

  def about
  end
end
