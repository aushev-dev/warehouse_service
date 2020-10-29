require "rails_helper"

RSpec.describe Warehouse, :type => :model do
  context "Validation test" do
    it "Ensures name is present" do
      warehouse = Warehouse.new(name: "SDG")
      expect(warehouse.valid?).to eq(false)
    end

    it "Ensures address is present" do
      warehouse = Warehouse.new(address: "Domodedovo")
      expect(warehouse.valid?).to eq(false)
    end

    it "Ensures name and address  is present" do
      warehouse = Warehouse.new(name: "SDG", address: "Domodedovo")
      expect(warehouse.valid?).to eq(true)
    end

  end
end