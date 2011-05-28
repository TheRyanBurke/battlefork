class MembershipsController < ApplicationController
  def create
	@membership = Membership.new
	@membership.user_id = params[:user_id]
	@membership.team_id = params[:team_id]
	
	# if user_id is session user_id, this is team captain making new team
	if params[:user_id] == session[:user_id]
		notice_msg = "Team #{Team.find(params[:team_id]).teamname} created. You are now the team captain."
	# else its a captain adding a new member
	else
		notice_msg = "Added #{User.find(params[:user_id]).username} to the team!"
	end
		
	if @membership.save
		redirect_to(team_path(Team.find(params[:team_id])), :notice => notice_msg)
	else
		redirect_to(user_path(User.find(session[:user_id])), :notice => "Team could not be created. Errors: #{@membership.errors}")
  	end
  end
  
  def destroy
  	@membership = Membership.where("user_id == ? AND team_id == ?", params[:user_id], params[:team_id]).first
  	
  	if Team.find(@membership.team_id).has_matches_in_progress?
  		respond_to do |format|
  			format.html { redirect_to(team_path(params[:team_id]), :notice => "Cannot remove user from team when matches are in progress.") }
  		end
  		return
  	end
  	
  	
  	
  	respond_to do |format|
  		if @membership.destroy
  			format.html { redirect_to(user_path(session[:user_id]), :notice => "#{User.find(params[:user_id]).username} removed from team #{Team.find(params[:team_id]).teamname}.")}
  		else
  			format.html { redirect_to(user_path(session[:user_id]), :notice => "Could not destroy membership") }
  		end
  	end
  end

end
