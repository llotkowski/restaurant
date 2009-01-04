class User < ActiveRecord::Base
  validates_presence_of :login, :message => "^Login jest wymagany."
  validates_presence_of :password, :message => "^Hasło jest wymagane."
  validates_presence_of :name, :message => "^Imię jest wymagane."
  validates_presence_of :surname, :message => "^Nazwisko jest wymagane."
  validates_presence_of :email, :message => "^Adres e-mail jest wymagany."
end
