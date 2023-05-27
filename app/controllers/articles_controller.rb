class ArticlesController < ApplicationController
    def show
        @article = Article.find(params[:id])
    end

    def index
        @articles = Article.all
    end

    def new
        @article = Article.new
    end

    def edit
        @article = Article.find(params[:id])
    end
    
    def create
        @article = Article.new(params.require(:article).permit(:title, :discription, :bar_code))
        if(@article.save)
            flash[:notice] = "Article was created successfully"
          #render plain: @article.inspect -> for showing the value
          #redirect_to article_path(@article) -> this will also work same
          #render plain: params[:article] --> this will show added new artilce in hash type
          redirect_to @article
        else
            render 'new'
        end
    end

    def update
        @article = Article.find(params[:id])
        if @article.update(params.require(:article).permit(:title, :discription, :bar_code))
            flash[:notice] = "Article was Updated successfully"
            redirect_to @article
        else
            render 'edit'
        end
    end

    def destroy
      @article = Article.find(params[:id])
      @article.destroy
      redirect_to articles_path
    end
end