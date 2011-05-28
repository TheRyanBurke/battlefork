class TeamsController < ApplicationController
  # GET /teams
  # GET /teams.xml
  def index
    @teams = Team.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @teams }
    end
  end

  # GET /teams/1
  # GET /teams/1.xml
  def show
    @team = Team.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @team }
    end
  end

  # GET /teams/new
  # GET /teams/new.xml
  def new
    @team = Team.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @team }
    end
  end

  # GET /teams/1/edit
  def edit
    @team = Team.find(params[:id])
  end
  
  # views/teams/opponents.html.erb
  def opponents
  	@team = Team.find(params[:team_id])
  	@opponents = @team.get_opponents
  end
  
  #make new match with the two team ids, which will create the match_participations
  def add_match
  	respond_to do |format|
  		format.html { redirect_to(:action => "create", :controller => "matches", :team1_id => params[:team1_id], :team2_id => params[:team2_id]) }
  	end
  end
  
  # POST
  # make a list of all users minus users already on the current team_id
  # views/teams/invite.html.erb
  def invite
  	@team = Team.find(params[:team_id])
  	@inviteable_users = @team.get_invitable_users  	
  end
  
  # POST
  # create new membership with selected user_id and the current team_id
  def add_member  	  	
  	respond_to do |format|
        format.html { redirect_to(:action=>"create", :controller=>"memberships", :user_id => params[:add_member_id], :team_id => params[:team_id]) }
    end  	
  end

  # POST /teams
  # POST /teams.xml
  def create
    @team = Team.new(params[:team])
    @team.captain_user_id = session[:user_id]

    respond_to do |format|
      if @team.save
        format.html { redirect_to(:action=>"create", :controller=>"memberships", :user_id => session[:user_id], :team_id => @team.id) }#, :notice => 'Team was successfully created.') }
        format.xml  { render :xml => @team, :status => :created, :location => @team }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @team.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /teams/1
  # PUT /teams/1.xml
  def update
    @team = Team.find(params[:id])

    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.html { redirect_to(@team, :notice => 'Team was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @team.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.xml
  def destroy
    @team = Team.find(params[:id])
    
    #need to delete all memberships first
    @team.memberships.each do |m|
    	m.destroy
    end
    
    @team.match_participations.each do |mp|
    	mp.destroy
    end
    
    @team.destroy

    respond_to do |format|
      format.html { redirect_to(user_path(session[:user_id]), :notice => "Team deleted") }
      format.xml  { head :ok }
    end
  end
end
