class ArticlesController < ApplicationController
  #記事一覧
  def index
    @articles = Article.order(release_at: :desc)
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

end
