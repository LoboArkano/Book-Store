class Book < ApplicationRecord
  belongs_to :seller

  has_one_attached :picture
end
