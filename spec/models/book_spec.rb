require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'Book' do
    context 'testing associations' do
      it 'should have one seller' do
        b = Book.reflect_on_association(:seller)
        expect(b.macro).to eq(:belongs_to)
      end
    end

    context 'validation tests' do
      let(:seller) { Seller.create!(name: 'Lorem', phone: '333', email: 'email@email.com', password: '12345678') }
      let(:book) do
        Book.create!(
          seller_id: seller.id, title: 'Dracula', description: 'Lorem', author: 'Lorem', price: 2.05, stock: 4
        )
      end
      it 'ensure presence of tittle' do
        book = Book.new(title: nil, description: 'Lorem', author: 'Lorem', price: 2.05, stock: 1)
        expect { book.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
      it 'ensure presence of description' do
        book = Book.new(title: 'Lorem', description: nil, author: 'Lorem', price: 2.05, stock: 1)
        expect { book.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
      it 'ensure presence of author' do
        book = Book.new(title: 'Lorem', description: 'Lorem', author: nil, price: 2.05, stock: 1)
        expect { book.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
      it 'ensure presence of price' do
        book = Book.new(title: 'Lorem', description: 'Lorem', author: 'Lorem', price: nil, stock: 1)
        expect { book.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
      it 'ensure presence of stock' do
        book = Book.new(title: 'Lorem', description: 'Lorem', author: 'Lorem', price: 2.05, stock: nil)
        expect { book.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
      it 'save successfuly' do
        expect(book.title).to eq('Dracula')
      end
    end
  end
end
