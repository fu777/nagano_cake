class Item < ApplicationRecord

  has_one_attached :image

  has_many :cart_items, dependent: :destroy
  belongs_to :genre

  enum is_active: {true: true, false: false}

  def with_tax_price
    (price*1.1).floor
  end

end
