class MembershipsController < ApplicationController
  def create
	@membership = Membership.new
	@membership.user_id = params[:user_id]
	@membership.team_id = params[:team_id]
		
	if @membership.save
		redirect_to(user_path(User.find(session[:user_id])), :notice => "Team #{Team.find(params[:team_id]).teamname} created. You are now the team captain.")
	else
		redirect_to(user_path(User.find(session[:user_id])), :notice => "Team could not be created. Errors: #{@membership.errors}")
  	end
  end

end
