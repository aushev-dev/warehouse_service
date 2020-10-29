class SellService
  attr_accessor :id, :count
  def initialize(id, count)
    @product = Product.find(id)
    @count = count
    @count = @count.to_i
    @warehouse = @product.warehouse
  end

  def sell
    ActiveRecord::Base.transaction do
      @product.with_lock do
        if @count <= 0 
          raise "Can't sell less than 0" 
        elsif @count == @product.count
          @sum = @product.price * @count
          @warehouse.balance += @sum
          @warehouse.save!
          @product.destroy!
        elsif @count <= @product.count
          @product.count -= @count
          @sum = @product.price * @count
          @warehouse.balance += @sum
          @warehouse.save!
          @product.save! 
        else
          raise "Can't sell more than #{@product.count} of '#{@product.name}' from warehouse id: #{@warehouse.id}"   
        end
      end
    end
  end
end