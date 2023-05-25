class ArticlesController < ApplicationController
    def show
        @article = Article.find(params[:id])
    end

    def index
        @articles = Article.all
    end

    def new

    end

    def create
        @article = Article.new(params.require(:article).permit(:title, :discription, :bar_code))
        @article.save
        #render plain: @article.inspect -> for showing the value
        #redirect_to article_path(@article) -> this will also work same
        redirect_to @article
    end

end