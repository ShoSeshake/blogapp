class CommentsController < ApplicationController

  def create
     @comment = Comment.create(comment_params)
     respond_to do |format|
      format.html { redirect_to article_path(params[:article_id])  }
      format.json
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:comment).merge(user_id: current_user.id, article_id: params[:article_id])
  end
end
