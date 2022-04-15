class Order < ApplicationRecord

  belongs_to :costomer
  has_many :order_details, dependent: :destroy

  enum payment_method: {credit_card: 0, transfer: 1}
  enum status: {waiting_for_deposit: 0,
                payment_confirmation: 1,
                production: 2,
                ready_to_ship: 3,
                sent: 4}

end
