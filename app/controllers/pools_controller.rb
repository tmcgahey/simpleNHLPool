class PoolsController < ApplicationController
  before_action :set_pool, only: [:show, :edit, :update, :destroy]

  # GET /pools
  # GET /pools.json
  def index
    @pools = Pool.all
  end

  # GET /pools/1
  # GET /pools/1.json
  def show
  end

  # GET /pools/new
  def new
    @pool = Pool.new
  end

  # GET /pools/1/edit
  def edit
  end

  # POST /pools
  # POST /pools.json
  def create
    @pool = Pool.new(pool_params)

    respond_to do |format|
      if @pool.save
        format.html { redirect_to @pool, notice: 'Pool was successfully created.' }
        format.json { render :show, status: :created, location: @pool }
      else
        format.html { render :new }
        format.json { render json: @pool.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pools/1
  # PATCH/PUT /pools/1.json
  def update
    respond_to do |format|
      if @pool.update(pool_params)
        format.html { redirect_to @pool, notice: 'Pool was successfully updated.' }
        format.json { render :show, status: :ok, location: @pool }
      else
        format.html { render :edit }
        format.json { render json: @pool.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pools/1
  # DELETE /pools/1.json
  def destroy
    @pool.destroy
    respond_to do |format|
      format.html { redirect_to pools_url }
      format.json { head :no_content }
    end
  end

  def updateSkaters

    @pool = Pool.find(session[:pool_id])

    @skater_response = RestClient.get 'http://www2.tsn.ca/datafiles/JSON/NHL/NHL_STATS_SKATERS.js?c=1'
    @skaterData = @skater_response.split('?')[1].gsub!('[]','{"skater"').gsub!(';','}').gsub!("'",'"')

    @json_skater = ActiveSupport::JSON.decode(@skaterData)

    @json_skater["skater"].each do |skater|
      if skater[22] == 3
        @nhlteamid = NhlTeam.find_by(name: skater[2],pool_id: @pool.id).id

        @upsertSkater = Skater.find_or_create_by(name: skater[1],team: skater[2]) do |s|
          s.name = skater[1]
          s.pos = skater[0]
          s.goals = skater[5]
          s.assists = skater[6]
          s.team = skater[2]
          s.nhl_team_id = @nhlteamid
        end

        @upsertSkater.update(name: skater[1],pos: skater[0],goals: skater[5],assists: skater[6],team: skater[2],nhl_team_id: @nhlteamid)
      end
    end

    @goalie_response = RestClient.get 'http://www2.tsn.ca/datafiles/JSON/NHL/NHL_STATS_GOALIES.js?c=1'
    @goalieData = @goalie_response.split('?')[1].gsub!('[]','{"goalie"').gsub!(';','}').gsub!("'",'"')

    @json_goalie = ActiveSupport::JSON.decode(@goalieData)

    @json_goalie["goalie"].each do |goalie|
      if goalie[24] == 3
        @nhlteamid = NhlTeam.find_by(name: goalie[1],pool_id: @pool.id).id

        @upsertGoalie = Goalie.find_or_create_by(name: goalie[0],team: goalie[1]) do |g|
          g.name = goalie[0]
          g.team = goalie[1]
          g.wins = goalie[10]
          g.so = goalie[8]
          g.goals = goalie[16]
          g.assists = goalie[17]
          g.nhl_team_id = @nhlteamid
        end

        @upsertGoalie.update(name: goalie[0], team: goalie[1], wins: goalie[10],so: goalie[8],goals: goalie[16],assists: goalie[17],nhl_team_id: @nhlteamid)
      end
    end

    @pool_members = Pool.find(session[:pool_id]).pool_members

    @pool_members.each do |member|
      if member.goalie1.present?
        Goalie.where(team: member.goalie1).each do |goalie|
          goalie.update(pool_member_id: member.id)
        end
      end

      if member.goalie2.present?
        Goalie.where(team: member.goalie2).each do |goalie|
          goalie.update(pool_member_id: member.id)
        end

      end
    end

    @pool.update(last_update: Time.now)

    respond_to do |format|
      format.html { redirect_to pools_path, :flash => {:success => "Skater data has been updated" }}
      format.json { head :no_content }
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pool
      @pool = Pool.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pool_params
      params.require(:pool).permit(:name)
    end
end
