require 'rspec'
require './lib/item'
require './lib/vendor'

RSpec.describe Market do
  let (:market1) {Market.new("South Pearl Street Farmers Market")}

  let (:item1) {Item.new({name: 'Peach', price: "$0.75"})}
  let (:item2) {Item.new({name: 'Tomato', price: '$0.50'})}
  let (:item3) {Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})}
  let (:item4) {item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})}

  let (:vendor1) {Vendor.new("Rocky Mountain Fresh")}
  let (:vendor2) {Vendor.new("Ba-Nom-a-Nom")}
  let (:vendor3) {Vendor.new("Palisade Peach Shack")}

  describe '#it exists with attributes' do
    it 'the market exists' do
      expect(market1).to be_a Market
    end
  end
end