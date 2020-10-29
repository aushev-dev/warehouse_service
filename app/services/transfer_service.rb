class TransferService
  attr_accessor :warehouse_from_id, :warehouse_to_id, :product_id, :count

  def initialize(warehouse_from_id, warehouse_to_id, product_id, count)
    @warehouse_from = Warehouse.find(warehouse_from_id)
    @warehouse_to = Warehouse.find(warehouse_to_id)
    @product = @warehouse_from.products.find(product_id)
    @count = count
    @count = @count.to_i
  end

  def transfer 
    ActiveRecord::Base.transaction do
      @product.with_lock do
        if @count <= 0
          raise "Can't transfer less than 0"
        elsif @count == @product.count
          @warehouse_to.products.create(name: @product.name, count: @product.count, price: @product.price)
          @warehouse_to.save!
          @product.destroy!    
        elsif @count <= @product.count
          @warehouse_to.products.create(name: @product.name, count: @count, price: @product.price)
          @warehouse_to.save!
          @product.count -= @count
          @product.save!   
        else
          raise "Can't transfer more than #{@warehouse_from.products.count} of '#{@product.name}' from warehouse id: #{@warehouse_from.id}"   
        end
      end
    end
  end
end