class Category < ActiveRecord::Base

has_many :menus, :dependent => :destroy

end
