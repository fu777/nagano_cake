class Order < ApplicationRecord

  belongs_to :costomer
  has_many :order_details, dependent: :destroy
  
  validates :customer_id, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true
  validates :shipping_cost, presence: true
  validates :total_payment, presence: true
  validates :payment_method, presence: true
  validates :status, presence: true

  enum payment_method: {credit_card: 0, transfer: 1}
  enum status: {waiting_for_deposit: 0,
                payment_confirmation: 1,
                production: 2,
                ready_to_ship: 3,
                sent: 4}


end
