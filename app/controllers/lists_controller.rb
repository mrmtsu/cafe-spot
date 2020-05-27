class ListsController < ApplicationController
  before_action :logged_in_user

  def index
    @lists = current_user.lists
    @log = Log.new
  end

  def create
    @post = Post.find(params[:post_id])
    @user = @post.user
    current_user.list(@post)
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  def destroy
    list = List.find(params[:list_id])
    @post = list.post
    list.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end
end
