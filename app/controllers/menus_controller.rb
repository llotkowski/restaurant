class MenusController < ApplicationController
  # GET /menus
  # GET /menus.xml
  def index
    @menus = Menu.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @menus }
    end
  end

  # GET /menus/1
  # GET /menus/1.xml
  def show
    @menu = Menu.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @menu }
    end
  end

  # GET /menus/new
  # GET /menus/new.xml
  def new
    @menu = Menu.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @menu }
    end
  end

  # GET /menus/1/edit
  def edit
    @menu = Menu.find(params[:id])
  end

  # POST /menus
  # POST /menus.xml
  def create

    @menu = Menu.new(params[:menu])

    if(params[:restaurant_id] != nil)
      @restaurant = Restaurant.find(params[:restaurant_id])
      @menu.restaurant_id = @restaurant.id
      puts "PARAMS ID = " + params[:restaurant_id].to_s
    end

    respond_to do |format|
      if @menu.save
        flash[:notice] = 'Menu zostaĹo utworzone pomyĹlnie.'
        if(params[:restaurant_id] == nil)
          format.html { redirect_to(@menu) }
          format.xml  { render :xml => @menu, :status => :created, :location => @menu }
        else
          format.html { redirect_to :controller => "restaurants", :action => "menu", :id => @restaurant.id}
          format.xml  { render :xml => @menu, :status => :created, :location => @menu }
        end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @menu.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /menus/1
  # PUT /menus/1.xml
  def update
    @menu = Menu.find(params[:id])

    respond_to do |format|
      if @menu.update_attributes(params[:menu])
        flash[:notice] = 'Menu zostaĹo zaaktualizowane pomyĹlnie.'
        format.html { redirect_to(@menu) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @menu.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.xml
  def destroy
    @menu = Menu.find(params[:id])
    @menu.destroy

    respond_to do |format|
      format.html { redirect_to(menus_url) }
      format.xml  { head :ok }
    end
  end
end
