class Book < ApplicationRecord
  belongs_to :seller

  has_one_attached :picture

  validates :title, :description, :author, :price, :stock, presence: true
  validates :title, length: { maximum: 150 }
  validates :description, length: { maximum: 1000 }

  def self.search(search)
    if search
      books = Book.all.select { |book| /#{search}/i.match(book.title) }
      books ||= Book.all.order('created_at desc')
      books
    else
      Book.all.order('created_at desc')
    end
  end
end
