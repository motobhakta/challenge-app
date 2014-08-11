class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  	ENV['LINKEDIN_API_KEY'] = "7555zxaiv4nfoe"
	ENV['LINKEDIN_SECRET_KEY'] = "2DRosHRAUyxRPCI4"

    private

	def confirm_logged_in
		unless session[:user_id]
			flash[:notice] = "Please log in."
			redirect_to(:controller => 'login', :action => 'login')
			return false # halts the before_action
		else
			return true
		end
	end

	def linkedin
		OAuth2::AccessToken.new(linkedin_client, session['linkedin_token'], {
	        :mode => :query,
	        :param_name => "oauth2_access_token",
	      })
	end

	def linkedin_client
	  OAuth2::Client.new(
	    ENV['LINKEDIN_API_KEY'],
	    ENV['LINKEDIN_SECRET_KEY'],
	    :authorize_url => "/uas/oauth2/authorization?response_type=code", #LinkedIn's authorization path
	    :token_url => "/uas/oauth2/accessToken", #LinkedIn's access token path
	    :site => "https://www.linkedin.com"
	  )
	end
end
