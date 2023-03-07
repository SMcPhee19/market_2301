class Market
  attr_reader :name, :vendors
  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor_name)
    @vendors << vendor_name
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.inventory.include?(item)
    end
  end


  def total_inventory
    total_market_stock = {}
    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        if total_market_stock[item]  ## if the total market stock already has the item key, we want to just add to it
          total_market_stock[item][:quantity] += quantity
        elsif ## otherwise make the new nested hash
          total_market_stock[item] = {quantity: vendor.inventory[item], vendors: vendors_that_sell(item)}
        end
      end
    end
    total_market_stock
  end

  def sorted_item_list
    ## look at all of the keys in the total_inventory hash and alphabetize them
    total_inventory.keys.map{ |x| x.name }.sort
  end

  def overstocked_items
    ## Set an empty array to return the items
    ## look through the total_market_stock hash from total_inventory and see if quantity of that item is over 50 and vendors key has more than one vendor value in it
    overstocked_items = []
    total_inventory.each do |item_name, item_info_hash|
      if item_info_hash[:quantity] > 50 && item_info_hash[:vendors].length > 1
        overstocked_items << item_name
      end
    end
    overstocked_items
  end
end
