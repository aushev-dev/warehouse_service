class Product < ApplicationRecord
  belongs_to :warehouse
  validates :name, presence: true
  validates :warehouse_id, presence: true

end
