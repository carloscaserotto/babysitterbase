class EmployeesController < ApplicationController
    before_action :set_employee, only: [:show, :edit, :update, :destroy]
    before_action :require_user, only: [:edit, :update]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def show 
        #byebug
    end

    def index
        @employees = Employee.all
    end
    
    def new
        if !current_user
            flash[:alert] = "You need to be login"
            redirect_to root_path
        else
            @employee = Employee.new
        end
    end
    def create
        #byebug #- params[:user][:username]
        @user = current_user
        @employee = Employee.new(employee_params)
        if @employee.save
            #session[:user_id] = @user.id
            flash[:notice] = "Welcome #{@employee.username}, you have successfully sign up as a Babysitter"
            redirect_to employees_path
        else
            render 'new'
        end
            
    end

    def edit
    end

    def update
        if @employee.update(employee_params)
            flash[:notice] = "Your account information was successfully updated"
            redirect_to @employee
        else
            render 'edit'
        end

    end

    

    def destroy
        @employee.destroy
        session[:user_id] = nil if @user == current_user
        flash[:notice] = "Account successfully deleted"
        redirect_to root_path
    end

    private

    def employee_params
        params.require(:employee).permit(:username, :email, :description)
    end

    def set_employee
        @employee = Employee.find(params[:id])
    end

    def require_same_user
        @user = current_user
        if current_user != @user && !current_user.admin?
            flash[:alert] = "You can only edit or delete your own profile"
            redirect_to @user
        end
    end
end
