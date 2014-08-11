class LoginController < ApplicationController

	layout "global"
	before_action :confirm_logged_in, :except => [:login, :do_login, :logout, :newregistration]

	def login
	end

	def newregistration
		@user = User.new
	end

	def do_login

		if params[:username].present? && params[:password].present?
	      found_user = User.where(:username => params[:username]).first
	      puts "#{found_user.inspect}"
	      if found_user
	        authorized_user = found_user.authenticate(params[:password])
	      end
	    end

	    if authorized_user
	      # mark user as logged in
	      session[:user_id] = authorized_user.id
	      session[:username] = authorized_user.username
	      flash[:notice] = "You are now logged in."
	      redirect_to(:controller=> 'oauth', :action => 'linkedin')
	    else
	    	puts "invalid"
	      flash[:notice] = "Invalid username/password combination."
	      redirect_to(:action => 'login')
	    end

	end

	def logout
		# mark user as logged out
		session[:user_id] = nil
		session[:username] = nil
		session[:linkedin_token] = nil
		flash[:notice] = "Logged out"
		redirect_to(:action => "login")
	end

	def forgotpassword
	end
end
