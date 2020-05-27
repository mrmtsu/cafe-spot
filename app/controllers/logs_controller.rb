class LogsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: :create

  def create
    @post = Post.find(params[:post_id])
    @log = @post.logs.build(content: params[:log][:content])
    @log.save
    flash[:success] = "カフェログを追加しました！"
    List.find(params[:list_id]).destroy unless params[:list_id].nil?
    redirect_to post_path(@post)
  end

  def destroy
    @log = Log.find(params[:id])
    @post = @log.post
    if current_user == @post.user
      @log.destroy
      flash[:success] = "カフェログを削除しました"
    end
    redirect_to post_url(@post)
  end

  private

    def correct_user
      post = current_user.posts.find_by(id: params[:post_id])
      redirect_to root_url if post.nil?
    end
end
