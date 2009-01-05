class Restaurant < ActiveRecord::Base
  acts_as_mappable

  has_many :menus, :dependent => :destroy
  has_many :places, :dependent => :destroy

  belongs_to :cuisine

  has_attached_file :photo,
    :styles => {
    :thumb => "100x100>",
    :medium => "<500x173" }

  validates_attachment_presence :photo, :message => "^Fotografia nie została wybrana."
  validates_attachment_size :photo, :less_than => 5.megabytes, :message => "Fotografia jest zbyt duża."
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png'], :message => "^Fotografia jest w złym formacie."
  validates_presence_of :name, :message => "^Nazwa jest wymagana."
  validates_presence_of :street, :message => "^Ulica jest wymagana."
  validates_presence_of :city, :message => "^Miasto jest wymagane."
  validates_presence_of :number, :message => "^Numer jest wymagany."

  def address
    street+" "+number+" "+city
  end

  def popup_desc(photo_url)
    "<table><tr><td><img src="+photo_url+" alt="+name+"/></td><td><p style='font-size: 12px; font-weight: bold;'>"+name+"</p><b>Adres:</b><br/>"+city+"<br/>ul. "+street+" "+number+"</td></tr><tr><td><b><a href=\"/restaurants/home/"+id.to_s+"\">Wejdź na stronę</b></td></tr></table>"
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
