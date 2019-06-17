require 'rails_helper'

RSpec.describe Product, type: :model do
  category = Category.new

  describe 'Validations' do
    it 'is valid with all valid attributes' do
      @product = Product.create(
        name: 'Google Home',
        price: 6_666,
        quantity: 2,
        category: category
      )
      expect(@product).to be_valid
    end

    it 'is not valid without name' do
      @product = Product.create(
        name: nil,
        price: 6_666,
        quantity: 2,
        category: category
      )
      expect(@product.errors.full_messages).to include ("Name can't be empty")
    end

    it 'is not valid without price' do
      @product = Product.create(
        name:'Google Home',
        price: nil,
        quantity: 2,
        category: category
      )
      expect(@product.errors.full_messages).to include ("Price can't be empty")
    end

    it 'is not valid without price' do
      @product = Product.create(
        name:'Google Home',
        price: 6_666,
        quantity: nil,
        category: category
      )
      expect(@product.errors.full_messages).to include ("Quantity can't be empty")
    end

    it 'is not valid without price' do
      @product = Product.create(
        name:'Google Home',
        price: 6_666,
        quantity: 2,
        category: nil
      )
      expect(@product.errors.full_messages).to include ("Category can't be empty")
    end

    
  end

end
