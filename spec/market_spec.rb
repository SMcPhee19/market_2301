require 'rspec'
require './lib/item'
require './lib/vendor'
require './lib/market'

RSpec.describe Market do
  let (:market1) {Market.new("South Pearl Street Farmers Market")}

  let (:item1) {Item.new({name: 'Peach', price: "$0.75"})}
  let (:item2) {Item.new({name: 'Tomato', price: '$0.50'})}
  let (:item3) {Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})}
  let (:item4) {Item.new({name: "Banana Nice Cream", price: "$4.25"})}

  let (:vendor1) {Vendor.new("Rocky Mountain Fresh")}
  let (:vendor2) {Vendor.new("Ba-Nom-a-Nom")}
  let (:vendor3) {Vendor.new("Palisade Peach Shack")}

  describe '#it exists with attributes' do
    it 'the market exists' do
      expect(market1).to be_a Market
    end

    it 'the market has a name' do
      expect(market1.name).to eq("South Pearl Street Farmers Market")
    end

    it 'market starts with an empty array of vendors' do
      expect(market1.vendors).to eq([])
    end
  end

  describe '#vendors and the market' do
    it 'the market can add vendors' do
      market1.add_vendor(vendor1)
      market1.add_vendor(vendor2)
      market1.add_vendor(vendor3)

      expect(market1.vendors).to eq([vendor1, vendor2, vendor3])
      expect(market1.vendor_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    end

    it 'the market can check where items are sold' do
      market1.add_vendor(vendor1)
      market1.add_vendor(vendor2)
      market1.add_vendor(vendor3)

      vendor1.stock(item1, 35)
      vendor1.stock(item2, 7)
      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)
      vendor3.stock(item1, 65)

      expect(market1.vendors_that_sell(item1)).to eq([vendor1, vendor3])
      expect(market1.vendors_that_sell(item4)).to eq([vendor2])
    end
  end

  describe '#items and the market' do
    it 'the vendor can show a total inventory' do
      market1.add_vendor(vendor1)
      market1.add_vendor(vendor2)
      market1.add_vendor(vendor3)

      vendor1.stock(item1, 45)
      vendor1.stock(item2, 10)
      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)
      vendor3.stock(item1, 65)
      vendor3.stock(item4, 10)

      expected = {
        item1 => {quantity: 110, vendors: [vendor1, vendor3]},
        item2 => {quantity: 10, vendors: [vendor1]},
        item3 => {quantity: 25, vendors: [vendor2]},
        item4 => {quantity: 60, vendors: [vendor2, vendor3] }
      }

      expect(market1.total_inventory).to eq(expected)

    end

    it 'the market can sort items' do
      market1.add_vendor(vendor1)
      market1.add_vendor(vendor2)
      market1.add_vendor(vendor3)

      vendor1.stock(item1, 35)
      vendor1.stock(item2, 7)
      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)
      vendor3.stock(item1, 65)

      expect(market1.sorted_item_list).to eq(["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Tomato"])
    end

    it 'the market can show an if an item is overstocked' do
      market1.add_vendor(vendor1)
      market1.add_vendor(vendor2)
      market1.add_vendor(vendor3)

      vendor1.stock(item1, 35)
      vendor1.stock(item2, 7)
      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)
      vendor3.stock(item1, 65)
      vendor3.stock(item4, 10)

      expect(market1.overstocked_items).to eq([item1, item4])
    end
  end
end