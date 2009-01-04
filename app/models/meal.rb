class Meal < ActiveRecord::Base

  has_many :menus, :dependent => :destroy

  has_attached_file :meal_photo,
    :styles => {
    :thumb => "89x71",
    :medium => "<200x175" }

  validates_attachment_presence :meal_photo, :message => "^Fotografia nie została wybrana."
  validates_attachment_size :meal_photo, :less_than => 5.megabytes, :message => "Fotografia jest zbyt duża."
  validates_attachment_content_type :meal_photo, :content_type => ['image/jpeg', 'image/png'], :message => "^Fotografia jest w złym formacie."

end
