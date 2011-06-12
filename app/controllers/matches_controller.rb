class MatchesController < ApplicationController
  # GET /matches
  # GET /matches.xml
  def index
    @matches = Match.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @matches }
    end
  end

  # GET /matches/1
  # GET /matches/1.xml
  def show
    @match = Match.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @match }
    end
  end

  # GET /matches/new
  # GET /matches/new.xml
  def new
    @match = Match.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @match }
    end
  end

  # GET /matches/1/edit
  def edit
    @match = Match.find(params[:id])
  end

  # POST /matches
  # POST /matches.xml
  def create
    @match = Match.new(params[:match])	

	#make two match_participations, one for each team paired with this match
    respond_to do |format|
      if @match.save
        format.html { 
        mp_for_team1 = MatchParticipation.new
        mp_for_team1.team_id = params[:team1_id]
        mp_for_team1.match_id = @match.id
        mp_for_team1.save
        
        mp_for_team2 = MatchParticipation.new
        mp_for_team2.team_id = params[:team2_id]
        mp_for_team2.match_id = @match.id
        mp_for_team2.save
        
        map = Map.new
		map.match_id = @match.id		
		map.save
        map.generate_locations
        
        @match.match_participations.each do |mp|
			mp.create_user_locations
			mp.set_players_to_starting_locations
        end       
        
        redirect_to(@match, :notice => 'Match was successfully created.') 
        }
        format.xml  { render :xml => @match, :status => :created, :location => @match }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @match.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /matches/1
  # PUT /matches/1.xml
  def update
    @match = Match.find(params[:id])

    respond_to do |format|
      if @match.update_attributes(params[:match])
        format.html { redirect_to(@match, :notice => 'Match was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @match.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /matches/1
  # DELETE /matches/1.xml
  def destroy
    @match = Match.find(params[:id])
               
    @match.destroy

    respond_to do |format|
      format.html { redirect_to(matches_url) }
      format.xml  { head :ok }
    end
  end
  
  def generate_orders
  	@match = Match.find(params[:id])
  	
  	if params[:user_order]
		params[:user_order].each do |u|
			user_id = u[0]
			location_id = u[1]
			puts "userid: " + user_id + " locid: " + location_id
			user_loc = @match.user_locations.where("user_id == ?", user_id).first
			user_loc.next_location = Location.find(location_id)
			user_loc.save
		end
  	#else
	#	@match.clear_all_next_locations
  	end
  	
  	if @match.all_orders_submit?
		@match.move_all_users_to_next_location
		@match.generate_battles
	end
  	
  	respond_to do |format|
  		format.html { redirect_to(@match) }
  		format.js
  	end
  	
  end
  
  
end
