class NhlPoolController < ApplicationController
  def index
    @hideAllStats = true
  end

  def search

    @pool = Pool.find_by(name: params[:pool])

    respond_to do |format|
      if @pool.present?
        session[:pool_id] = @pool.id
        format.html { redirect_to leaders_path}
        format.json { head :no_content }
      else
        format.html { redirect_to nhl_pool_index_path, notice: "Pool was not found" }
        format.json { head :no_content }
      end
    end

  end
end
