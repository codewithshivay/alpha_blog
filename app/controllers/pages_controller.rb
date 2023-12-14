class PagesController < ApplicationController

    skip_before_action :require_user

    def home
        redirect_to articles_path if Logged_in?
    end

    def about

    end
end
