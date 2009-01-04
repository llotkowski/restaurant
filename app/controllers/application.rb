# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  before_filter :give_me_my_link

  def give_me_my_link
    if session[:user]
      user = User.find(session[:user])
      if user.isadmin == "true"
        @user_link = "<a href=\"/admin\">Administracja</a>"
      else
        @user_link = "<a href=\"/my_books\">Moje rezerwacje</a>"
      end
    else
      @user_link = "<a href=\"/login\">Zaloguj się</a>"
    end
  end

  def check_authentication
    unless session[:user]
      session[:intended_action] = action_name
      session[:intended_controller] = controller_name
      redirect_to :controller => "login", :action => "index"
    end
  end

  def check_authentication_admin
    unless session[:user]
      session[:intended_action] = action_name
      session[:intended_controller] = controller_name
      redirect_to :controller => "login", :action => "index"
    else
      user = User.find(session[:user])
      unless user.isadmin == "true"
        redirect_to :controller => "login", :action => "index"
      end
    end
  end

#  def check_authentication_movies
#    if params[:view] == 'now'
#    elsif params[:view] == 'coming'
#    else
#      unless session[:user]
#        session[:intended_action] = action_name
#        session[:intended_controller] = controller_name
#        redirect_to :controller => "login", :action => "index", "view" => params[:view]
#      end
#    end
#  end

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'b534267e15d8289b3971a6722feb0cb6'

  # See ActionController::Base for details
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password").
  # filter_parameter_logging :password
end
