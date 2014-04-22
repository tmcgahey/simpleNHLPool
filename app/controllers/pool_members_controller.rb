class PoolMembersController < ApplicationController
  before_action :set_pool
  before_action :set_pool_member, only: [:show, :edit, :update, :destroy]

  # GET /pool_members
  # GET /pool_members.json
  def index
    @pool_members = @pool.pool_members
  end

  # GET /pool_members/1
  # GET /pool_members/1.json
  def show
    @skaterNames = Skater.all.map{|x| {label: x.name, value: x.nhl_id, team: x.team}}
  end

  # GET /pool_members/new
  def new
    @pool_member = @pool.pool_members.new
  end

  # GET /pool_members/1/edit
  def edit
    @playoff_teams = playoff_teams.map{ |team| [team, team] }
  end

  # POST /pool_members
  # POST /pool_members.json
  def create
    @pool = Pool.find(params[:pool_id])
    @pool_member = @pool.pool_members.new(pool_member_params)

    respond_to do |format|
      if @pool_member.save
        format.html { redirect_to pool_pool_members_path, notice: 'Pool member was successfully created.' }
        format.json { render :show, status: :created, location: @pool_member }
      else
        format.html { render :new }
        format.json { render json: @pool_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pool_members/1
  # PATCH/PUT /pool_members/1.json
  def update
    respond_to do |format|
      if @pool_member.update(pool_member_params)
        if @pool_member.goalie1.present?
          Goalie.where(team: @pool_member.goalie1).each do |goalie|
            goalie.update(pool_member_id: params[:id])
          end
        end

        if @pool_member.goalie2.present?
          Goalie.where(team: @pool_member.goalie2).each do |goalie|
            goalie.update(pool_member_id: params[:id])
          end
        end

        format.html { redirect_to pool_pool_members_path, notice: 'Pool member was successfully updated.' }
        format.json { render :show, status: :ok, location: @pool_member }
      else
        format.html { render :edit }
        format.json { render json: @pool_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pool_members/1
  # DELETE /pool_members/1.json
  def destroy
    @pool_member.destroy
    respond_to do |format|
      format.html { redirect_to pool_pool_members_url }
      format.json { head :no_content }
    end
  end

  def addSkater
    @pool_member = PoolMember.find(params[:id])
    @skater = Skater.find_by(nhl_id: params[:nhlId])

    respond_to do |format|
      if @skater.update(pool_member_id: params[:id])
        format.html { redirect_to pool_pool_member_path(params[:pool_id],params[:id]), notice: 'Pool member was successfully updated.' }
        format.js {}
        format.json { render :show, status: :ok, location: @pool_member }
      end
    end
  end

  def removeSkater
    @pool_member = PoolMember.find(params[:id])
    @skater = Skater.find(params[:skaterId])

    respond_to do |format|
      if @skater.update(pool_member_id: nil)
        format.js {}
      end
    end
  end

  private
    def set_pool
      @pool = Pool.find(params[:pool_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_pool_member
      @pool_member = PoolMember.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pool_member_params
      params.require(:pool_member).permit(:name,:goalie1,:goalie2)
    end

    def playoff_teams
      @playoff_teams = ["NONE","DAL","ANA","MTL","TBL","DET","BOS","PHI","NYR","CHI","STL","MIN","COL","LAK","SJS","PIT","CBJ"]
    end
end
