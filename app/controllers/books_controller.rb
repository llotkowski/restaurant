class BooksController < ApplicationController

  # GET /books/new
  # GET /books/new.xml
  def new
    @book = Book.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @book }
    end
  end

  # Zapis rezerwacji.
  def create
    @book = Book.new(params[:book])
    date = DateTime.parse(params[:date_picker].to_s+" "+params[:time_picker].to_s)
    @place = Place.find(params[:place])
    @book.book_date = date
    @book.user_id = session[:user]
    @books = Book.find(:all, :conditions => ['book_date = ? and place_id = ?', @book.book_date, @place.id])
    @book.place_id = @place.id
    @restaurant = @place.restaurant

    respond_to do |format|
      if @books.length == 0 && @book.save
        flash[:notice] = 'Rezerwacja przebiegĹa pomyślnie.'
        format.html { redirect_to(:controller => "restaurants", :action => "book", :id => @restaurant.id, "date" => params[:date], "time" => params[:time]) }
        format.xml  { render :xml => @book, :status => :created, :location => @book }
      else
        flash[:notice] = 'Niestety ktoś już zarezerwował ten stolik w podanym terminie.'
        format.html { redirect_to(:controller => "restaurants", :action => "book", :id => @restaurant.id) }
        format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end
end
