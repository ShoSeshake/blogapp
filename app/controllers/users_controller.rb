class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @recent_articles = @user.articles.order('created_at DESC').limit(5)
    @articles = @user.articles.order("created_at DESC").page(params[:page]).per(5)
    @searched_articles = @user.articles.where('title LIKE(?)', "%#{params[:keyword]}%").limit(20)
    respond_to do |format|
      format.html
      format.json
    end
  end
end
