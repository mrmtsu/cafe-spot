class CommentsController < ApplicationController
  before_action :logged_in_user

  def create
    @post = Post.find(params[:post_id])
    @user = @post.user
    @comment = @post.comments.build(user_id: current_user.id, content: params[:comment][:content])
    if !@post.nil? && @comment.save
      flash[:success] = "コメントを追加しました！"
      if @user != current_user
        @user.notifications.create(post_id: @post.id, variety: 2,
                                   from_user_id: current_user.id,
                                   content: @comment.content)
        @user.update_attribute(:notification, true)
      end
    else
      flash[:danger] = "空のコメントは投稿できません。"
    end
    redirect_to request.referrer || root_url
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    if current_user.id == @comment.user_id
      @comment.destroy
      flash[:success] = "コメントを削除しました"
    end
    redirect_to post_url(@post)
  end
end
