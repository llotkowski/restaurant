class RestaurantController < ApplicationController
  def home
    @restaurant = Restaurant.find(params[:id])
  end

  def menu
  end

  def book
  end

  def contact
  end

end
