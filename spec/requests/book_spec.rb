require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    let(:seller) { Seller.create!(name: 'Lorem', phone: '333', email: 'email@email.com', password: '12345678') }
    let(:book) do
      Book.create!(
        seller_id: seller.id, title: 'Dracula', description: 'Lorem', author: 'Lorem', price: 2.05, stock: 4
      )
    end
    it 'returns a success response' do
      get :show, params: { id: book.to_param }
      expect(response).to be_success
    end
  end
end
