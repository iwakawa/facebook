class CommentsController < ApplicationController
  def create
    # topicをパラメータの値から探し出し,Topicに紐づくcommentsとしてbuildします。
    @comment = current_user.comments.build(comment_params)
    @topic = @comment.topic
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @comment.save
        format.html { redirect_to topic_path(@topic), notice: 'コメントを投稿しました。' }
        # JS形式でレスポンスを返します。
        format.js { render :index }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    respond_to do |format|
      format.html {redirect_to topics_path(@topic)}
        format.js { render :edit }
    end
  end

  def update
    respond_to do |format|
    @comment.update(commnets_params)
    format.js { render :index }
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
        format.html {redirect_to topics_path(@topic)}
        flash.now[:notice] = "コメントが削除されました!"
        format.js { render :index }
    end
  end

  private
    # ストロングパラメーター
    def comment_params
      params.require(:comment).permit(:topic_id, :content)
    end
end
