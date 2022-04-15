class OrderDetail < ApplicationRecord
  
  belongs_to :order
  belongs_to :item
  
  enum making_status: {not_manufactured: 0,
                      waiting_for_deposit: 1,
                      production: 2,
                      production_completed: 3}
  
end
