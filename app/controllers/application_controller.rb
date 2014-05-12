class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :require_pool

private
  def require_pool
    unless current_pool
      redirect_to nhl_pool_index_path
    end
  end

  def current_pool
    if session[:pool_id]
      @current_pool = Pool.find(session[:pool_id])
    else
      nil
    end

  end

end
