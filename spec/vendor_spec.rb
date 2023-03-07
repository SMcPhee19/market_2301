require 'rspec'
require './lib/item'
require './lib/vendor'

RSpec.describe Vendor do
  let (:item1) {Item.new({name: 'Peach', price: "$0.75"})}
  let (:item2) {Item.new({name: 'Tomato', price: '$0.50'})}

  let (:vendor1) {Vendor.new("Rocky Mountain Fresh")}

  describe '#it exists with attributes' do
    it 'the vendor exists' do
      expect(vendor1).to be_a Vendor
    end

    it 'the vendor starts with an empty inventory' do
      expect(vendor1.inventory).to eq({})
    end
  end

  describe '#vendors and items' do 
    it 'the vendor can stock items' do
      expect(vendor1.check_stock(item1)).to eq(0)

      vendor1.stock(item1, 30)

      expect(vendor1.inventory).to eq({item1 => 30})
      expect(vendor1.check_stock(item1)).to eq(30)

      vendor1.stock(item1, 25)

      expect(vendor1.check_stock(item1)).to eq(55)

      vendor1.stock(item2, 12)

      expect(vendor1.inventory).to eq({item1 => 55, item2 => 12})
    end
  end
end