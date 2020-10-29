class ProductsController < ApplicationController
  protect_from_forgery with: :null_session


  def sell
    begin
      SellService.new(params[:id], params[:count]).sell
    rescue StandardError => e
      render json: {error: e.message }   
    end

  end

  def transfer
   begin
    TransferService.new(params[:warehouse_from_id], params[:warehouse_to_id], params[:product_id], params[:count]).transfer
   rescue StandardError => e 
    render json: {error: e.message }   
   end
  end
end
