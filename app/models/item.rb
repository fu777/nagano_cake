class Item < ApplicationRecord

  has_one_attached :image

  has_many :cart_items, dependent: :destroy
  belongs_to :genre
  has_many :order_details, dependent: :destroy

  enum is_active: {true: true, false: false}

  def with_tax_price
    (price*1.1).floor
  end

end
