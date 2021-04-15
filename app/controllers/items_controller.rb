class ItemsController < ApplicationController
  before_action :set_item, only: %i[destroy]
  before_action :authenticate_buyer!

  def index
    @items = current_buyer.items.all.order('created_at desc')
  end

  def create
    @item = current_buyer.items.new(book_id: params[:book_id])

    respond_to do |format|
      if @item.save
        format.html { redirect_to items_index_path, notice: 'Book was added to the shopping cart.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { redirect_to root_path, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @item.destroy
    book = Book.find(@item.book_id)
    respond_to do |format|
      format.html { redirect_to items_index_path, notice: "#{book.title} was deleted of the shopping cart." }
      format.json { head :no_content }
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end
end
