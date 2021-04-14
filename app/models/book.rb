class Book < ApplicationRecord
  belongs_to :seller, dependent: :destroy

  has_one_attached :picture

  validates :title, :description, :author, :price, :stock, presence: true
  validates :title, length: { maximum: 150 }
  validates :description, length: { maximum: 1000 }
end
