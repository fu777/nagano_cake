class OrderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item
  
  validates :order_id, presence: true
  validates :item_id, presence: true
  validates :price, presence: true
  validates :amount, presence: true
  validates :making_status, presence: true

  enum making_status: {not_manufactured: 0,
                      waiting_for_deposit: 1,
                      production: 2,
                      production_completed: 3}

  def subtotal
    price*amount
  end

end
