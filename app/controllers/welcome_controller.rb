class WelcomeController < ApplicationController
  protect_from_forgery :only => [:create, :update, :destroy]

  def about

  end

  def main

  end

  def show
    if params[:city].nil?
      @title = "Nasze restauracje"
      @restaurants = Restaurant.find(:all)
    else
      @title = "Wyniki wyszukiwania"
      city = params[:city]
      street = params[:street]

      @restaurants = Restaurant.find(:all, :conditions => ['street like ? and city like ?', '%'+street+'%', '%'+city+'%'])
    end
    @map = GMap.new("map_div")
    polLoc = GeoKit::Geocoders::GoogleGeocoder.geocode("Polska")
    @map.center_zoom_init([polLoc.lat, polLoc.lng],6)

    for restaurant in @restaurants
      loc = GeoKit::Geocoders::GoogleGeocoder.geocode(restaurant.address)
      @map.control_init(:large_map => true,:map_type => true)
      @map.overlay_init(GMarker.new([loc.lat, loc.lng],:title => restaurant.name, :info_window => restaurant.popup_desc))
    end
  end
end
