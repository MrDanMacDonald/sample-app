class StaticPagesController < ApplicationController

  def home
    @micropost = current_user.microposts.build if signed_in?
    unless !current_user
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end
  
end
