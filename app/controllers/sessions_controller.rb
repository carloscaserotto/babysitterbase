class SessionsController < ApplicationController
    before_action :log_in_redirect, only: [:new, :create]

    def new
    end
    def create
        #byebug
        user = User.find_by(email: params[:session][:email])
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            flash[:success] = "Logged in successfully"
            redirect_to root_path
        else
            flash.now[:error] = "There was something wrong with your login details"
            render 'new'
        end

    end

    def destroy
        session[:user_id] = nil
        flash[:success] = "Logged out successfully"
        redirect_to login_path
    end

    private
    
    def log_in_redirect
        if logged_in?
            flash[:error] = "You are already logged in"
            redirect_to root_path
        end
    end

end
