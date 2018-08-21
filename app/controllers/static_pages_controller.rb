class StaticPagesController < ApplicationController
  def home
    @micropost = current_user.microposts.build if sign_in?
  end

  def help
  end

  def about
  end

end
