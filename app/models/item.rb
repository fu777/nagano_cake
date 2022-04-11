class Item < ApplicationRecord

  has_one_attached :image

  belongs_to :genre

  enum is_active: {true: true, false: false}

  def with_tax_price
    (price*1.1).floor
  end

  def subtotal
    item.with_tax_price*amount
  end

end
