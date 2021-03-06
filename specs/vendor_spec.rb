require_relative './spec_helper'

describe FarMar::Vendor do 

	let(:vendor_test_one) { FarMar::Vendor.new({id: "1", name: "Feil-Farrell", num_of_employees: "8", market_id: "1"}) }
	let(:vendor_test_two) { FarMar::Vendor.new({id: "90180", market_id: "10000"}) }
	let(:all_vendors) { FarMar::Vendor.all('./support/vendors.csv') }

	it "has an 'all' method that returns an array of vendors" do
		all_vendors.wont_be_empty
	end

	it "populates each object with data from the CSV when #all is called" do
		vendor_to_test = rand(1..(all_vendors.length - 1))

		all_vendors[vendor_to_test].id.wont_be_empty
		all_vendors[vendor_to_test].name.wont_be_empty
	end

	it "returns the correct vendor when self#find is called" do
		FarMar::Vendor.find(18).name.must_equal("Von-Hamill")
	end

	it "has a market method that will return the market this vendor is associated with" do 
		market = vendor_test_one.market

		market.name.must_equal("People's Co-op Farmers Market")
		market.id.must_equal("1")
	end

	it "has a market method that will return nil if no market is found" do
		vendor_test_two.market.must_be_nil
	end

	it "returns a collection of FarMar::Product instances associated by FarMar::Product vendor_id field" do
		vendors_product = vendor_test_one.products

		vendors_product[0].name.must_equal("Dry Beets")
	end

	it "returns an empty array when no products are found" do
		vendor_test_two.products.must_be_empty
		vendor_test_two.products.must_be_instance_of(Array)
	end

	it "returns a collection of sales by this vendor when #sales is called" do
		vendor_test_one.sales.wont_be_empty
		vendor_test_one.sales.must_be_instance_of(Array)
	end

	it "returns an empty collection if #sales is called on a vendor with no sales" do
		vendor_test_two.products.must_be_empty
		vendor_test_two.products.must_be_instance_of(Array)
	end

	it "returns a collection of vendors for a given market_id" do
		market_one_vendors = FarMar::Vendor.by_market(1)

		market_one_vendors.length.must_equal(6)
	end

	it "returns a Fixnum representing profits from all sales by vendor in cents" do 
		vendor_test_one.revenue.must_equal(38259)
	end


end