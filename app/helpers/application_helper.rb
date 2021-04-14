module ApplicationHelper
  def items_added
    cart_items = current_buyer.items.count
    cart_items.zero? ? '' : cart_items
  end
end
