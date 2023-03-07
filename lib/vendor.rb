class Vendor
  attr_reader :name, :inventory
  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def stock(item, quantity)
    @inventory[item] += quantity
  end

  def check_stock(item)
    @inventory[item]
  end

  def potential_revenue
    revenue = 0
    @inventory.each do |item, quantity|
      revenue += item.price.delete_prefix("$").to_f.round(2) * quantity
    end
    # require 'pry'; binding.pry
    revenue
  end
end
