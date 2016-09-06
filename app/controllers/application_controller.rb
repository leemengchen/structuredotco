class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include CanCan::ControllerAdditions
  before_action :set_paper_trail_whodunnit


    rescue_from CanCan::AccessDenied do |exception|
      redirect_to main_app.root_path, :alert => exception.message
    end
  # private
  # def current_user
  #   @current_user ||= User.find(session[:user_id]) if session[:user_id]
  # end
  # helper_method :current_user

end
