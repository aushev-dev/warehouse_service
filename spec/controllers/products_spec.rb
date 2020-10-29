require "rails_helper"

RSpec.describe "Product controller test", :type => :request do
  before(:each) do
    @warehouse_1 = FactoryBot.create(:warehouse)
    @warehouse_2 = FactoryBot.create(:warehouse)
    @product = FactoryBot.create(:product, warehouse: @warehouse_1)
  end

  it "It selling product less than 0" do
    put "/sell", :params => { :id => 1, :count => -1 }
    @product.reload
    @warehouse_1.reload
    expect(JSON.parse(response.body)["error"]).to eq("Can't sell less than 0")
  end

  it "It selling product less than have in stock" do
    put "/sell", :params => { :id => 1, :count => 100 }
    @product.reload
    @warehouse_1.reload
    expect(@product.count).to eq(200)
    expect(@warehouse_1.products.sum(:count)).to eq(200)
    expect(@warehouse_1.balance).to eq(100*50000)
  end

  it "It selling product equal than have in stock" do
    put "/sell", :params => { :id => 1, :count => 300 }
    @warehouse_1.reload
    expect(@warehouse_1.balance).to eq(300*50000)
  end

  it "It selling product more than have in stock" do
    put "/sell", :params => { :id => 1, :count => 3000 }
    @product.reload
    @warehouse_1.reload
    expect(JSON.parse(response.body)["error"]).to eq("Can't sell more than #{@product.count} of '#{@product.name}' from warehouse id: #{@warehouse_1.id}")
    expect(response.body["error"]).not_to be_nil
  end

  it "It transfer product from warehouse to warehouse less than 0" do
    put "/transfer", :params => { :warehouse_from_id => 1, :warehouse_to_id => 2, :product_id => 1, :count => -1 }
    expect(JSON.parse(response.body)["error"]).to eq("Can't transfer less than 0")
    expect(response.body["error"]).not_to be_nil
  end

  it "It transfer product from warehouse to warehouse less than have in stock" do
    put "/transfer", :params => { :warehouse_from_id => 1, :warehouse_to_id => 2, :product_id => 1, :count => 200 }
    expect(@warehouse_2.products.sum(:count)).to eq(200)
    expect(@warehouse_1.products.sum(:count)).to eq(100)
  end

  it "It transfer product from warehouse to warehouse more than have in stock" do
    put "/transfer", :params => { :warehouse_from_id => 1, :warehouse_to_id => 2, :product_id => 1, :count => 400 }
    expect(JSON.parse(response.body)["error"]).to eq("Can't transfer more than #{@warehouse_1.products.count} of '#{@product.name}' from warehouse id: #{@warehouse_1.id}")
    expect(response.body["error"]).not_to be_nil
  end
  
  it "It transfer product from warehouse to warehouse equal in the stock" do
    put "/transfer", :params => { :warehouse_from_id => 1, :warehouse_to_id => 2, :product_id => 1, :count => 300 }
    expect(@warehouse_2.products.sum(:count)).to eq(300)
  end

end
