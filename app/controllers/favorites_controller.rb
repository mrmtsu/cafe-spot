class FavoritesController < ApplicationController
  before_action :logged_in_user

  def index
    @favorites = current_user.favorites
  end

  def create
    @post = Post.find(params[:post_id])
    @user = @post.user
    current_user.favorite(@post)
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    current_user.favorites.find_by(post_id: @post.id).destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end
end
