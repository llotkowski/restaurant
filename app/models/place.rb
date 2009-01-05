class Place < ActiveRecord::Base
  belongs_to :restaurant
  has_many :books, :dependent => :destroy
end
