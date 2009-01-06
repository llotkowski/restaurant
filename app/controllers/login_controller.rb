class LoginController < ApplicationController
  protect_from_forgery :only => [:index]

  def signin
    if request.post?
      user = User.find(:first, :conditions=> ['login = ? AND password = ?', params[:login], params[:password]])
      if user.blank?
        redirect_to :controller => "login", :action => "index"
      else
        session[:user] = user.id
        if params[:layout].to_s == 'restaurants'
          flash[:notice] = 'Witamy w systemie.'
          redirect_to :action => 'book', :controller => 'restaurants', :id => params[:id]
        else
          flash[:notice] = 'Witamy w systemie.'
          redirect_to :action => 'main', :controller => 'welcome'
        end
      end
    end
  end

  def logout
    session[:user] = nil
    redirect_to :action => 'main', :controller => 'welcome'
  end

  def logout_restaurant
    session[:user] = nil
    redirect_to :action => 'home', :controller => 'restaurants', :id => params[:id]
  end

  def index
    if params[:layout].to_s == "restaurants"
      @restaurant = Restaurant.find(params[:id])
      # Pobierane ostatnie 7 dodanych posiłków i wybierane 3 losowe
      @hot_menu = Menu.find(:all, :conditions => ['restaurant_id = ?', @restaurant.id], :order => 'created_at desc', :limit => 7 )
      @hot_menu = @hot_menu.sort_by{rand}.first(3)
      render :layout => 'restaurants'
    end
  end

end
