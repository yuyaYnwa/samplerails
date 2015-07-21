class TopController < ApplicationController
  def index
    @articles = Article.open.order(release_at: :desc).limit(5)
  end

  def about

  end

end
