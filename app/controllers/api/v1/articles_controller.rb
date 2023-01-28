class Api::V1::ArticlesController < ApplicationController
  def index
    articles = Article.all
    render json: articles, status: 200
  end

  def show
    article = Article.find_by(id: params[:id])
    if article
      render json: article, status: 200
    else
      render json: {
        error: "Article not found"
      }
    end
  end

  def create
    article = Article.new(
      title: article_params[:title],
      body: article_params[:body],
      author: article_params[:author]
    )

    if article.save
      render json: article, status: 200
    else
      render json: {
        error: "Error Creating..."
      }
    end
  end

  def update
    article = Article.find_by(id: params[:id])
    if article
      article.update(title: params[:title], body: params[:body], author: params[:author])
      render json: "Article record updated successfully"
    else
      render json: {
        error: "Article Not found"
      }
    end
  end

  def destroy
    article = Article.find_by(id: params[:id])
    if article
      article.destroy
      render json: "Article has been deleted"
    else
      render json: {
        error: "Article not found"
      }
    end
  end

  private

  def article_params
    params.require(:article).permit([:title, :body, :author])
  end

end
