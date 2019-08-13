class BooksController < ApplicationController
  def index
    @books = Book.all.reverse
    @books = @books[0...[20, @books.length].min]
  end

  # Create
  def new
    @title = params[:title]
    @author = params[:author]
    @publisher = params[:publisher]
    @year = params[:year]
    @isbn = params[:isbn]
    @scannable = params[:scannable]
    @shelf = params[:shelf]

    @query_errors = []
    @query_errors << 'No Book With That ISBN found in the GoogleBooks Database' if params[:successful] == 'false'
    @query_errors << 'ISBN can\'t be blank' if params[:is_empty] != nil

    @book = Book.new
  end

  def create
    if params[:isbn_fill] then
      if params[:isbn_fill][:isbn] == '' then
        redirect_to action: 'new',
                    successful: true,
                    is_empty: true
        return
      end

      books = GoogleBooks.search('isbn:' << params[:isbn_fill][:isbn])
      book = books.first
      
      if book == nil then
        redirect_to action: 'new',
                  successful: false
      else
        redirect_to action: 'new',
                    successful: true,
                    title: book.title,
                    author: book.authors,
                    publisher: book.publisher,
                    year: (book.published_date == nil ? nil : book.published_date.split('-')[0]),
                    isbn: params[:isbn_fill][:isbn]
      end
    else
      if params[:book][:shelf] != nil
        params[:book][:shelf] = params[:book][:shelf].upcase
      end

      @book = Book.new(book_params)

      if @book.save then
        redirect_to @book
      else
        render 'new', no_reset: true
      end
    end
  end

  # Read
  def show
    @book = Book.find(params[:id])
  end

  # Edit
  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])

    if @book.update book_params then
      redirect_to @book
    else
      render 'new'
    end
  end

  # Destroy
  def destroy
      @book = Book.find(params[:id])
      @book.destroy

      redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :author, :publisher, :year, :isbn, :scannable, :shelf)
  end
end
