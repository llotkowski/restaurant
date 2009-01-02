class Restaurant < ActiveRecord::Base
  acts_as_mappable

  def address
    street+" "+number+" "+city
  end
  def popup_desc
    "<h2>"+name+"</h2><br/><b>Adres:</b><br/>ul. "+street+" "+number+" "+city+"<br /><b>Opis:</b><br />"+desc+"<br/><br/><b><a href=\"/restaurant/home/"+id.to_s+"\">Wejdź na stronę</b>"
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
