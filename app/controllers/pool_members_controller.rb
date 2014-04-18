class PoolMembersController < ApplicationController
  before_action :set_pool_member, only: [:show, :edit, :update, :destroy]

  # GET /pool_members
  # GET /pool_members.json
  def index
    @pool_members = PoolMember.all
  end

  # GET /pool_members/1
  # GET /pool_members/1.json
  def show
  end

  # GET /pool_members/new
  def new
    @pool_member = PoolMember.new
  end

  # GET /pool_members/1/edit
  def edit
  end

  # POST /pool_members
  # POST /pool_members.json
  def create
    @pool_member = PoolMember.new(pool_member_params)

    respond_to do |format|
      if @pool_member.save
        format.html { redirect_to @pool_member, notice: 'Pool member was successfully created.' }
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
        format.html { redirect_to @pool_member, notice: 'Pool member was successfully updated.' }
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
      format.html { redirect_to pool_members_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pool_member
      @pool_member = PoolMember.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pool_member_params
      params.require(:pool_member).permit(:name, :pool_id)
    end
end
