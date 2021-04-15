class ItemsController < ApplicationController
  before_action :set_item, only: %i[destroy]
  before_action :authenticate_buyer!

  def purchase
    items = current_buyer.items.all

    items.each do |item|
      book = Book.find(item.book_id)
      current_buyer.wallet -= book.price
      current_buyer.save
      item.destroy
    end

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Thank you for buy-in BookStore' }
      format.json { head :no_content }
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
end
