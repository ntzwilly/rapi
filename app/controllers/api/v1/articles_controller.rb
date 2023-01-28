class Api::V1::ArticlesController < ApplicationController

  before_action :authorize

  before_action :set_article, only: [:show, :update, :destroy]

  def index
    articles = @user.articles.all
    render json: articles, status: 200
  end

  def show
    if @article
      render json: @article, status: 200
    else
      render json: {
        error: "Article not found"
      }
    end
  end

  def create
    @article = @user.articles.new(article_params.merge(user: @user))

    if @article.save
      render json: @article, status: 200
    else
      render json: {
        error: "Error Creating..."
      }
    end
  end

  def update
    if @article
      @article.update(article_params)
      render json: "Article record updated successfully"
    else
      render json: {
        error: "Article Not found"
      }
    end
  end

  def destroy
    if @article
      @article.destroy
      render json: "Article has been deleted"
    else
      render json: {
        error: "Article not found"
      }
    end
  end

  private

  def set_article
    @article = @user.articles.find(params[:id])
  end

  def article_params
    params.require(:article).permit([:title, :body])
  end

end
