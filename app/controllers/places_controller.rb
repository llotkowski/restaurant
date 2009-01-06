class PlacesController < ApplicationController
  # GET /places/new
  # GET /places/new.xml
  def new
    @place = Place.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @place }
    end
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
end
