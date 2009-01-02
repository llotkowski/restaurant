class Restaurant < ActiveRecord::Base
  def address
    city+"<br/>"+"ul. "+street+" "+number
  end
  def location
    if(latitude.nil?)
      [52,18]
    else
      [longitude, latitude]
    end
  end
  def has_map?
    ! latitude.nil?
  end
end
