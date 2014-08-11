class UsersController < ApplicationController

  before_action :confirm_logged_in, :except => [:create]

  def index
      if session['linkedin_token']
        response = linkedin.get('https://api.linkedin.com/v1/people/~:(id,email-address,picture-url,first-name,last-name,headline,skills)?format=json')
        @user_details = JSON.parse(response.body)
      end
  end

  def show
  end

  def new
  end

  def create
  	@user = User.new(user_params)

  	if @user.save
  		flash[:notice] = "Accounts Created Successfully. Kindly LogIn"
  		redirect_to :controller => "login", :action => "login"
  	else
  		flash[:error] = "Oops error occoured!!!"
  		render "login/newregistration", :layout => 'global'
  	end
  end

  def edit
  end

  private
  def user_params
  	params.require(:user).permit(:username, :first_name, :last_name, :email, :password, :password_confirmation)
  end

end
