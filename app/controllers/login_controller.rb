class LoginController < ApplicationController
  protect_from_forgery :only => [:index]

  def signin
    if request.post?
      user = User.find(:first, :conditions=> ['login = ? AND password = ?', params[:login], params[:password]])
      if user.blank?
        redirect_to :controller => "login", :action => "index"
      else
        session[:user] = user.id
        redirect_to :action => 'main', :controller => 'welcome'
      end
    end
  end

  def logout
    session[:user] = nil
    redirect_to :action => 'main', :controller => 'welcome'
  end

end
