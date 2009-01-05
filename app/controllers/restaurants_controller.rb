class RestaurantsController < ApplicationController
  before_filter :get_meal_of_the_day

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
    @map.overlay_init(GMarker.new([loc.lat, loc.lng],:title => @restaurant.name, :info_window => @restaurant.popup_desc(@restaurant.photo.url(:thumb))))

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
        format.html { render :action => "new", :layout => 'application' }
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
        format.html { render :action => "edit", :layout => 'application' }
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

    # Pobranie specjalności zakładu (3 najdroższe dania w danej restauracji)
    @special_menu = Menu.find(:all, :conditions => ['restaurant_id = ?', @restaurant.id], :order => 'price desc', :limit => 3)
  end

  # GET /restaurants/menu/1
  def menu
    @restaurant = Restaurant.find(params[:id])

    # Pobranie listy kategori do wyświetlenia w Menu danej restauracji (tylko te kategorie w których są przypisane dania)
    @category_list = Menu.find(:all, :select => 'DISTINCT category_id', :conditions => ['restaurant_id = ?', @restaurant.id], :order => 'category_id asc')

    if(@category_list.size != 0)
      # Pobranie pierwszej kategorii z listy w celu wyświetlenia dań gdy nie wybrana jest jeszcze żadna kategoria
      @number = @category_list.first.category_id

      # Pobranie Menu według wybranej kategorii lub domyślnie według pierwszej z listy
      if (params[:category] != nil)
        @restaurant_menu = Menu.find(:all , :conditions => ['category_id = ? AND restaurant_id = ?' , params[:category], @restaurant.id], :order => "price asc")
      else
        @restaurant_menu = Menu.find(:all , :conditions => ['category_id = ? AND restaurant_id = ?' , @number, @restaurant.id], :order => "price asc")
      end
    end

  end

  # GET /restaurants/places/1
  def places
    @restaurant = Restaurant.find(params[:id])
    @places = Place.find(:all, :conditions => ['restaurant_id = ?', @restaurant.id])
    @place = Place.new
    render :layout => 'application'
  end

  def add_menu_to_restaurant
    @menu = Menu.new

    @restaurant = Restaurant.find(params[:id])

    # Pobranie listy kategori do wyświetlenia w Menu danej restauracji (tylko te kategorie w których są przypisane dania)
    @category_list = Menu.find(:all, :select => 'DISTINCT category_id', :conditions => ['restaurant_id = ?', @restaurant.id], :order => 'category_id asc')

  end

  # GET /restaurants/book/1
  def book
    if params[:date].to_s == ""
      date = Date.current.to_s
    else
      date = params[:date]
    end

    if params[:time].to_s == ""
      time = Time.now.hour.to_s
      if time.to_i < 11
        time = 11
      end
      if time.to_i > 21
        time = 21
      end
    else
      time = params[:time]
    end

    @restaurant = Restaurant.find(params[:id])
    @book = Book.new
    if session[:user]
      @book.user = User.find(session[:user])
    end
    @places = Place.find(:all, :conditions => ['restaurant_id = ?', @restaurant.id])

    choosenTime = DateTime.parse(date.to_s+" "+time.to_s)

    @places_choosen = Place.find(:all, :conditions => ['id in (select place_id from books where book_date = ? and place_id in (select id from places where restaurant_id = ?))', choosenTime, @restaurant.id])
  end

  # GET /restaurants/contact/1
  def contact
    @restaurant = Restaurant.find(params[:id])

    # Mapa do kontaktu
    @map = GMap.new("map_div")
    loc = GeoKit::Geocoders::GoogleGeocoder.geocode(@restaurant.address)

    @map.control_init(:small_map => true, :large_map => false, :map_type => false, :scale => false, :small_zoom => false, :overview_map => false, :local_search => false, :local_search_options => false )
    @map.center_zoom_init([loc.lat, loc.lng],15)
    @map.overlay_init(GMarker.new([loc.lat, loc.lng],:title => @restaurant.name, :info_window => @restaurant.popup_desc(@restaurant.photo.url(:thumb))))
    
    # Pobranie specjalności zakładu (3 najdroższe dania w danej restauracji)
    @special_menu = Menu.find(:all, :conditions => ['restaurant_id = ?', @restaurant.id], :order => 'price desc', :limit => 3)
  end

  # GET /restaurants/show_meal/1
  def show_meal
    @restaurant = Restaurant.find(params[:id])

    # Pobranie listy kategori do wyświetlenia w Menu danej restauracji (tylko te kategorie w których są przypisane dania)
    @category_list = Menu.find(:all, :select => 'DISTINCT category_id', :conditions => ['restaurant_id = ?', @restaurant.id], :order => 'category_id asc')

    @menu_meal = Menu.find(params[:menu_id])
  end

  def get_meal_of_the_day

    if(params[:id] != nil)
      @restaurant = Restaurant.find(params[:id])

      # Pobierane ostatnie 7 dodanych posiłków i wybierane 3 losowe
      @hot_menu = Menu.find(:all, :conditions => ['restaurant_id = ?', @restaurant.id], :order => 'created_at desc', :limit => 7 )
      @hot_menu = @hot_menu.sort_by{rand}.first(3)
    end

  end

end
