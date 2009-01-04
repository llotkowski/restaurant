class Meal < ActiveRecord::Base

  has_many :menus, :dependent => :destroy

  has_attached_file :meal_photo,
    :styles => {
    :thumb => "100x100>",
    :medium => "<500x173" }

end
