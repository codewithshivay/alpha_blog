class ArticlesController < ApplicationController
    before_action :set_articel, only: [:show, :edit, :update, :destroy]

    def show
        #@article = Article.find(params[:id])
    end

    def index
        @articles = Article.all
    end

    def new
        @article = Article.new
    end

    def edit
        #@article = Article.find(params[:id])
    end
    
    def create
        @article = Article.new(article_param)
        @article.user = User.first
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
        #@article = Article.find(params[:id])
        if @article.update(article_param)
            flash[:notice] = "Article was Updated successfully"
            redirect_to @article
        else
            render 'edit'
        end
    end

    def destroy
      #@article = Article.find(params[:id])
      @article.destroy
      redirect_to articles_path
    end

    private

    def set_articel
      @article = Article.find(params[:id])
    end

    def article_param
      params.require(:article).permit(:title, :discription, :bar_code)
    end

end