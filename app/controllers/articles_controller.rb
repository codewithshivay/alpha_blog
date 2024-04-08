class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    
    def show
        #@article = Article.find(params[:id])
    end

    def index
       if params[:search]
         @articles = Article.where("lower(title) like :query OR lower(bar_code) like :query OR lower(discription) like :query", query: "%#{params[:search].downcase}%").paginate(page: params[:page], per_page: 5)
       else
         @articles = Article.paginate(page: params[:page], per_page: 5)
       end
    end

    def new
        @article = Article.new
    end

    def edit
        #@article = Article.find(params[:id])
    end
    
    def create
        @article = Article.new(article_param)
        @article.user = current_user
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

    def set_article
      @article = Article.find(params[:id])
    end

    def article_param
      params.require(:article).permit(:title, :discription, :bar_code, category_ids: [])
    end

    def require_same_user
        if current_user != @article.user && !current_user.admin?
            flash[:alert] = "You can only edit or delete your own article"
            redirect_to @article
        end
    end

end