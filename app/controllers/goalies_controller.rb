class GoaliesController < ApplicationController
  before_action :set_goaly, only: [:show, :edit, :update, :destroy]

  # GET /goalies
  # GET /goalies.json
  def index
    @goalies = Goalie.joins(:nhl_team).where('nhl_teams.pool_id' => session[:pool_id])
  end

  # GET /goalies/1
  # GET /goalies/1.json
  def show
  end

  # GET /goalies/new
  def new
    @goalie = Goalie.new
  end

  # GET /goalies/1/edit
  def edit
  end

  # POST /goalies
  # POST /goalies.json
  def create
    @goalie = Goalie.new(goaly_params)

    respond_to do |format|
      if @goalie.save
        format.html { redirect_to @goalie, notice: 'Goalie was successfully created.' }
        format.json { render :show, status: :created, location: @goalie }
      else
        format.html { render :new }
        format.json { render json: @goalie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /goalies/1
  # PATCH/PUT /goalies/1.json
  def update
    respond_to do |format|
      if @goalie.update(goaly_params)
        format.html { redirect_to @goalie, notice: 'Goalie was successfully updated.' }
        format.json { render :show, status: :ok, location: @goalie }
      else
        format.html { render :edit }
        format.json { render json: @goalie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /goalies/1
  # DELETE /goalies/1.json
  def destroy
    @goalie.destroy
    respond_to do |format|
      format.html { redirect_to goalies_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_goaly
      @goalie = Goalie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def goaly_params
      params.require(:goalie).permit(:name, :team, :wins, :so, :pool_member_id, :nhl_id)
    end
end
