class ApplicationController < ActionController::Base
	include SessionsHelper
	include ApplicationHelper

  def logged_in_user?
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to new_session_path
    end
  end
end
