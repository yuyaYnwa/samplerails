class ArticlesController < ApplicationController
  #記事一覧
  def index
    @articles = Article.order(release_at: :desc)
  end
end
