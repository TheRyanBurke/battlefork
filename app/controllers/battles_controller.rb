class BattlesController < ApplicationController
  # GET /battles
  # GET /battles.xml
  def index
    @battles = Battle.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @battles }
    end
  end

  # GET /battles/1
  # GET /battles/1.xml
  def show
    @battle = Battle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @battle }
    end
  end

  # GET /battles/new
  # GET /battles/new.xml
  def new
    @battle = Battle.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @battle }
    end
  end

  # GET /battles/1/edit
  def edit
    @battle = Battle.find(params[:id])
    
    if  @battle.team_winner_id
		redirect_to(@battle.match, :notice => 'That battle is already complete.')
	end
    
	if !@battle.is_user_allowed_to_report_winner(session[:user_id])
		redirect_to(User.find(session[:user_id]), :notice => 'You do not have permission to report the winner of that battle.')
	end
    
  end

  # POST /battles
  # POST /battles.xml
  def create
    @battle = Battle.new(params[:battle])

    respond_to do |format|
      if @battle.save
        format.html { redirect_to(@battle, :notice => 'Battle was successfully created.') }
        format.xml  { render :xml => @battle, :status => :created, :location => @battle }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @battle.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /battles/1
  # PUT /battles/1.xml
  def update
    @battle = Battle.find(params[:id])

    respond_to do |format|
      if @battle.update_attributes(params[:battle])

		@battle.signal_match_of_battle_completion
		
        format.html { redirect_to(@battle.match, :notice => 'Battle was successfully reported.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @battle.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /battles/1
  # DELETE /battles/1.xml
  def destroy
    @battle = Battle.find(params[:id])
    
    @battle.destroy

    respond_to do |format|
      format.html { redirect_to(battles_url) }
      format.xml  { head :ok }
    end
  end
end
