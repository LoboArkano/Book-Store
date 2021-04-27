class ItemsController < ApplicationController
  before_action :total_price, only: %i[purchase index]
  before_action :set_item, only: %i[destroy]
  before_action :authenticate_buyer!

  def purchase
    if @total <= current_buyer.wallet
      items = current_buyer.items.all
      store = Store.all.first

      payment(items, store)

      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Thank you for buy-in BookStore!' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to items_index_path, alert: 'There is no enough money in your wallet!' }
        format.json { head :no_content }
      end
    end
  end

  def index
    @items = current_buyer.items.all.order('created_at desc')
  end

  def create
    @item = current_buyer.items.new(book_id: params[:book_id])
    item_book

    respond_to do |format|
      if @item.save
        @book.stock -= 1
        @book.save
        format.html { redirect_to items_index_path, notice: 'Book was added to the shopping cart.' }
        format.json { render :index, status: :created, location: @item }
      else
        format.html { redirect_to root_path, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @item.destroy
    item_book
    @book.stock += 1
    @book.save
    respond_to do |format|
      format.html { redirect_to items_index_path, notice: "#{@book.title} was deleted of the shopping cart." }
      format.json { head :no_content }
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_book
    @book = Book.find(@item.book_id)
  end

  def total_price
    book_ids = current_buyer.items.all.pluck(:book_id)
    books = Book.all.where(id: book_ids)
    @total = books.pluck(:price).sum
  end

  def payment(items, store)
    revenue = 1

    items.each do |item|
      book = Book.find(item.book_id)
      book.seller.wallet += (book.price - revenue)
      book.seller.save
      book.seller.sales.create(book_title: book.title, book_price: book.price, profit: (book.price - revenue))
    end

    store.revenue += items.count
    store.save
    current_buyer.wallet -= @total
    current_buyer.save
    items.destroy_all
  end
end
