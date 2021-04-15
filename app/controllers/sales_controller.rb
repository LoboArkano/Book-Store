class SalesController < ApplicationController
  before_action :authenticate_seller!

  def index
    @sales = current_seller.sales.all
  end
end
