class PagesController < ApplicationController
  PER_PAGE = 10

  def search
    @page = (params[:page] == nil ? 1 : params[:page])
    @query_text = params[:query]
    @books = Book.all
    @book_count = @books.length
    @found = true

    if @query_text != nil then
      @books = book_triage @books, @query_text
      @found = false if @books == []
      @last_page = (@books.length / PER_PAGE.to_f).ceil
      page_num = @page.to_i
      @total_result = @books.length
      @first_result = ((page_num - 1) * PER_PAGE)
      @last_result = [@books.length, (page_num * PER_PAGE)].min
      @books = @books[@first_result...@last_result]
      @first_result += 1
    else
      @books = []
    end
  end

  def query
    redirect_to action: 'search', query: params[:query][:query].strip
  end

  private
  def book_triage pool, query
    good = []
    query = query.downcase

    to_search = nil
    if query[0..5] == 'title:' then
      to_search = ['title']
      query = query[6...query.length]
    elsif query[0..6] == 'author:' then
      to_search = ['author']
      query = query[7...query.length]
    elsif query[0..9] == 'publisher:' then
      to_search = ['publisher']
      query = query[10...query.length]
    elsif query[0..4] == 'year:' then
      to_search = ['year']
      query = query[5...query.length]
    elsif query[0..4] == 'isbn:' then
      to_search = ['isbn']
      query = query[5...query.length]
    elsif query[0..9] == 'scannable:' then
      to_search = ['scannable']
      query = query[10...query.length]
    elsif query[0..5] == 'shelf:' then
      to_search = ['shelf']
      query = query[6...query.length]
    else
      to_search = ['title', 'author', 'publisher', 'year', 'isbn', 'scannable', 'shelf']
    end

    query = query.strip

    pool.each do |book|
      to_search.each do |field|
        if eval("book.#{field} != nil") and eval("book.#{field}.to_s.downcase.include? \"#{query}\"") then
          good << book
          break
        end
      end
    end

    return good.sort_by {|book| book.title}
  end
end
