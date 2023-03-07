require 'rspec'
require './lib/item'
require './lib/vendor'

RSpec.describe Vendor do
  let (:item1) {Item.new({name: 'Peach', price: "$0.75"})}
  let (:item2) {Item.new({name: 'Tomato', price: '$0.50'})}
  let (:item3) {Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})}
  let (:item4) {Item.new({name: "Banana Nice Cream", price: "$4.25"})}

  let (:vendor1) {Vendor.new("Rocky Mountain Fresh")}
  let (:vendor2) {Vendor.new("Ba-Nom-a-Nom")}
  let (:vendor3) {Vendor.new("Palisade Peach Shack")}

  describe '#it exists with attributes' do
    it 'the vendor exists' do
      expect(vendor1).to be_a Vendor
      expect(vendor2).to be_a Vendor
      expect(vendor3).to be_a Vendor
    end

    it 'the vendor has a name' do
      expect(vendor1.name).to eq("Rocky Mountain Fresh")
      expect(vendor2.name).to eq("Ba-Nom-a-Nom")
      expect(vendor3.name).to eq("Palisade Peach Shack")
    end

    it 'the vendor starts with an empty inventory' do
      expect(vendor1.inventory).to eq({})
      expect(vendor2.inventory).to eq({})
      expect(vendor3.inventory).to eq({})
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

    it 'the vendor can calculate potential revenue' do
      vendor1.stock(item1, 35)
      vendor1.stock(item2, 7)
      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)
      vendor3.stock(item1, 65)
      
      expect(vendor1.potential_revenue).to eq(29.75)
      expect(vendor2.potential_revenue).to eq(345.00)
      expect(vendor3.potential_revenue).to eq(48.75)
    end
  end
end