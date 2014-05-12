class NhlTeamsController < ApplicationController
  skip_before_filter :require_pool
  before_action :set_pool
  before_action :set_nhl_team, only: [:show, :edit, :update, :destroy]

  # GET /nhl_teams
  # GET /nhl_teams.json
  def index
    @nhl_teams = @pool.nhl_teams
  end

  # GET /nhl_teams/1
  # GET /nhl_teams/1.json
  def show
  end

  # GET /nhl_teams/new
  def new
    @nhl_team = @pool.nhl_teams.new
  end

  # GET /nhl_teams/1/edit
  def edit
  end

  # POST /nhl_teams
  # POST /nhl_teams.json
  def create
    @nhl_team = @pool.nhl_teams.new(nhl_team_params)

    respond_to do |format|
      if @nhl_team.save
        format.html { redirect_to pool_nhl_teams_path, notice: 'Nhl team was successfully created.' }
        format.json { render :show, status: :created, location: @nhl_team }
      else
        format.html { render :new }
        format.json { render json: @nhl_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nhl_teams/1
  # PATCH/PUT /nhl_teams/1.json
  def update
    respond_to do |format|
      if @nhl_team.update(nhl_team_params)
        format.html { redirect_to pool_nhl_teams_path, notice: 'Nhl team was successfully updated.' }
        format.json { render :show, status: :ok, location: @nhl_team }
      else
        format.html { render :edit }
        format.json { render json: @nhl_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nhl_teams/1
  # DELETE /nhl_teams/1.json
  def destroy
    @nhl_team.destroy
    respond_to do |format|
      format.html { redirect_to pool_nhl_teams_url }
      format.json { head :no_content }
    end
  end

  private
    def set_pool
      @pool = Pool.find(params[:pool_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_nhl_team
      @nhl_team = NhlTeam.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def nhl_team_params
      params.require(:nhl_team).permit(:name, :references, :active)
    end
end
