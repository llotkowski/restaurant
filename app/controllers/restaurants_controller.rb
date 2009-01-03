class RestaurantsController < ApplicationController
  # GET /restaurants
  # GET /restaurants.xml
  def index
    @restaurants = Restaurant.find(:all)

    respond_to do |format|
      format.html { render :layout => 'application' } # index.html.erb
      format.xml  { render :xml => @restaurants }
    end
  end

  # GET /restaurants/1
  # GET /restaurants/1.xml
  def show
    @restaurant = Restaurant.find(params[:id])

    @map = GMap.new("map_div")
    loc = GeoKit::Geocoders::GoogleGeocoder.geocode(@restaurant.address)

    @map.control_init(:large_map => true,:map_type => true)
    @map.center_zoom_init([loc.lat, loc.lng],16)
    @map.overlay_init(GMarker.new([loc.lat, loc.lng],:title => @restaurant.name, :info_window => @restaurant.popup_desc))

    respond_to do |format|
      format.html { render :layout => 'application' } # new.html.erb
      format.xml  { render :xml => @restaurant }
    end
  end

  # GET /restaurants/new
  # GET /restaurants/new.xml
  def new
    @restaurant = Restaurant.new

    respond_to do |format|
      format.html { render :layout => 'application' } # new.html.erb
      format.xml  { render :xml => @restaurant }
    end
  end

  # GET /restaurants/1/edit
  def edit
    @restaurant = Restaurant.find(params[:id])

    render :layout => 'application'
  end

  # POST /restaurants
  # POST /restaurants.xml
  def create
    @restaurant = Restaurant.new(params[:restaurant])

    respond_to do |format|
      if @restaurant.save
        flash[:notice] = 'Restaurant was successfully created.'
        format.html { redirect_to(@restaurant) }
        format.xml  { render :xml => @restaurant, :status => :created, :location => @restaurant }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @restaurant.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /restaurants/1
  # PUT /restaurants/1.xml
  def update
    @restaurant = Restaurant.find(params[:id])

    respond_to do |format|
      if @restaurant.update_attributes(params[:restaurant])
        flash[:notice] = 'Restaurant was successfully updated.'
        format.html { redirect_to(@restaurant) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @restaurant.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.xml
  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy

    respond_to do |format|
      format.html { redirect_to(restaurants_url) }
      format.xml  { head :ok }
    end
  end

  # Własne metody

  # GET /restaurants/home/1
  def home
    @restaurant = Restaurant.find(params[:id])
  end

  # GET /restaurants/menu/1
  def menu
    @restaurant = Restaurant.find(params[:id])
  end

  # GET /restaurants/contact/1
  def contact
    @restaurant = Restaurant.find(params[:id])
  end

end
