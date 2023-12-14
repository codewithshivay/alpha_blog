class ApplicationController < ActionController::Base

    before_action :require_user
    helper_method :current_user, :Logged_in?

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def Logged_in?
        !!current_user
    end

    private

    def require_user
        if !Logged_in?
            flash[:alert] = "You must logged in to perform that action"
            redirect_to login_path
        end
    end

end
