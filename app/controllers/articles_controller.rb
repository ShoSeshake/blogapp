class ArticlesController < ApplicationController

  before_action :move_to_index, except: [:index, :show]
  before_action :set_recent_articles, only: [:edit, :new]

  def index
    @recent_articles = Article.includes(:user).order('created_at DESC').limit(5)
    @articles = Article.order("created_at DESC").page(params[:page]).per(1)
    @searched_articles = Article.where('title LIKE(?)', "%#{params[:keyword]}%").limit(20)
    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @article = Article.find(params[:id])
    @recent_articles = @article.user.articles.includes(:user).order('created_at DESC').limit(5)
    @comment = Comment.new
    @comments = @article.comments.includes(:user)
  end

  def new
    @new_article = Article.new
    @user = current_user
  end

  def create
    @new_article = Article.new(article_params)
    @new_article.save
    redirect_to "/articles/#{@new_article.id}"
  end
  
  def edit
    @article = Article.find(params[:id])
  end

  def update
    article = Article.find(params[:id])
    if article.user_id == current_user.id
      article.update(article_params)
      redirect_to article_path(article)
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.user_id == current_user.id
      @article.destroy
      redirect_to user_path(current_user)
    else 
      render :edit
    end
  end

  private
  def article_params
    params.require(:article).permit(:title, :content).merge(user_id: current_user.id)
  end

  def move_to_index 
    redirect_to action: :index unless user_signed_in?
  end

  def set_recent_articles
    @recent_articles = current_user.articles.includes(:user).order('created_at DESC').limit(5)
  end

end
