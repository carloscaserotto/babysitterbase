class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :require_user, only: [:edit, :update]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    before_action :already_loggedin, only: [:create]
    
    def show 
        #byebug
    end

    def index
        @users = User.all
    end
    
    def new
        if current_user
            flash[:notice] = "Someone is already logged in"
            redirect_to root_path
        else           
            @user = User.new
        end
    end
    def create
        #byebug #- params[:user][:username]
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:notice] = "Welcome to the Babysitter webpage #{@user.username}, you have successfully sign up"
            redirect_to root_path
        else
            render 'new'
        end
    end

    def edit
    end

    def update
        if @user.update(user_params)
            flash[:notice] = "Your account information was successfully updated"
            redirect_to @user
        else
            render 'edit'
        end

    end

    

    def destroy
        @user.destroy
        session[:user_id] = nil if @user == current_user
        flash[:notice] = "Account successfully deleted"
        redirect_to root_path
    end

    private

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

    def set_user
        @user = User.find(params[:id])
    end

    def require_same_user
        if current_user != @user && !current_user.admin?
            flash[:alert] = "You can only edit or delete your own profile"
            redirect_to @user
        end
    end

    
   
end

