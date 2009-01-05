class PlacesController < ApplicationController
  # GET /places
  # GET /places.xml
  def index
    @places = Place.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @places }
    end
  end

  # GET /places/1
  # GET /places/1.xml
  def show
    @place = Place.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @place }
    end
  end

  # GET /places/new
  # GET /places/new.xml
  def new
    @place = Place.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @place }
    end
  end

  # GET /places/1/edit
  def edit
    @place = Place.find(params[:id])
  end

  # POST /places
  # POST /places.xml
  def create
    blocks = params[:blocks].to_s.split(',')
    delete = params[:to_delete].to_s.split(',')
    @restaurant = Restaurant.find(params[:restaurant_id])
    for block in blocks
      place = block.to_s.split(';')
      if place[0].to_s.index('new').nil?
        @place = Place.find(place[0])
        @place.x = place[1]
        @place.y = place[2]
        @place.save
      else
        @place = Place.new
        @place.x = place[1]
        @place.y = place[2]
        @place.restaurant_id = @restaurant.id
        @place.number = place[3]
        @place.save
      end
    end

    for block in delete
      @place = Place.find(block)
      @place.destroy
    end
    flash[:notice] = 'Zmiany zostały zapisane pomyślnie.'
    redirect_to(:controller => "restaurants", :action => "places", :id => @restaurant.id)
  end

  # PUT /places/1
  # PUT /places/1.xml
  def update
    @place = Place.find(params[:id])

    respond_to do |format|
      if @place.update_attributes(params[:place])
        flash[:notice] = 'Place was successfully updated.'
        format.html { redirect_to(@place) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @place.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1
  # DELETE /places/1.xml
  def destroy
    @place = Place.find(params[:id])
    @place.destroy

    respond_to do |format|
      format.html { redirect_to(places_url) }
      format.xml  { head :ok }
    end
  end
end
