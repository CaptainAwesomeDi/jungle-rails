require 'rails_helper'
#require '../../app/models/product.rb'

RSpec.describe Product, type: :model do
  describe 'Validations'do
    it 'should be saved if user fills every field' do
      @product = Product.new
      @product.name = 'Bob head'
      @product.price = 100
      @category = Category.new({name:'Toys'})
      @product.category = @category
      @product.quantity = 25
      @product.save!
      expect(@product.errors.full_messages).to be_empty
    end

    it 'should not be saved if user leave name field empty' do
      @product = Product.new
      @product.name = nil
      @product.price = 100
      @category = Category.new({name:'Toys'})
      @product.category = @category
      @product.quantity = 25
      @product.valid?
      expect(@product.errors[:name]).to include("can't be blank")
    end

    it 'should not be saved if user leave price is empty' do
      @product = Product.new
      @product.name = 'Bobby Head'
      @product.price = nil
      @category = Category.new({name:'Toys'})
      @product.category = @category
      @product.quantity = 25
      @product.valid?
      expect(@product.errors[:price]).to include("can't be blank")
    end

    it 'should not be saved if user leave category is empty' do
      @product = Product.new
      @product.name = 'Bobby Head'
      @product.price = 100
      @category = Category.new({name:'Toys'})
      @product.category = nil
      @product.quantity = 25
      @product.valid?
      expect(@product.errors[:category]).to include("can't be blank")
    end

    it 'should not be saved if user leave quantity is empty' do
      @product = Product.new
      @product.name = 'Bobby Head'
      @product.price = 100
      @category = Category.new({name:'Toys'})
      @product.category = @category
      @product.quantity = nil
      @product.valid?
      expect(@product.errors[:quantity]).to include("can't be blank")
    end

   end
end
