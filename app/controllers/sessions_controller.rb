class SessionsController < ApplicationController
  def new
  end

  def create
	if user = User.authenticate(params[:username], params[:password])
		session[:user_id] = user.id
		redirect_to user_path(user), :notice => "Successfully logged in!"
	else
		redirect_to login_url, :alert => "Invalid user/pass"
	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to login_url, :alert => "Logged out"  
  end

end
