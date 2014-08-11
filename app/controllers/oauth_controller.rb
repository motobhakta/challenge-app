class OauthController < ApplicationController

	STATE = SecureRandom.hex(15) # use it to stop potential CSRF attacks.

	def linkedin_callback
	 
	    code = params[:code]
	    state = params[:state]
	 
	    if !state.eql?(STATE)
	      # Reject the request as it may be a result of CSRF
	      redirect_to :controller=> 'login', :action=> :login
	    else
	      # Get token object, passing in the authorization code from the previous step
	      token = linkedin_client.auth_code.get_token(code, :redirect_uri => "http://localhost:3000/oauth/linkedin_callback")
	 	  session['linkedin_token'] = token.token

	      redirect_to :controller=> 'users', :action => :index

	    end
	end



	def linkedin
	  redirect_to linkedin_client.auth_code.authorize_url(:scope => 'r_fullprofile r_emailaddress r_network',
	    :state => STATE,
	    :redirect_uri => "http://localhost:3000/oauth/linkedin_callback")
	end

end