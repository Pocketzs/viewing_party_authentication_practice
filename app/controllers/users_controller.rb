class UsersController <ApplicationController 
    def new 
        @user = User.new()
    end 

    def show 
        @user = User.find(params[:id])
    end 

    def create 
      # require 'pry'; binding.pry
        user = User.create(user_params)
        if user.save
            redirect_to user_path(user)
        else  
            flash[:error] = user.errors.full_messages.to_sentence
            redirect_to register_path
        end 
    end 

    def login_form
      @user = User.new
    end

    def login_user
      user = User.find_by_email(params[:user][:email])
      if user.nil?
        flash[:error] = "You have entered an invalid username or password"
        @user = User.new(user_params)
        render :login_form
      elsif user.authenticate(params[:user][:password])
        redirect_to user_path(user)
      else
        flash[:error] = "You have entered an invalid username or password"
        @user = User.new(user_params)
        render :login_form
      end
    end

    private 

    def user_params 
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end 
end 