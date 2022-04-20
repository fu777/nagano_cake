class Item < ApplicationRecord

  has_one_attached :image

  has_many :cart_items, dependent: :destroy
  belongs_to :genre
  has_many :order_details

  validates :image, presence: true
  validates :genre_id, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  validates :is_active, presence: true

  enum is_active: {true: true, false: false}

  def with_tax_price
    (price*1.1).floor
  end

  def self.search(search)
    if search
      Item.where(["name LIKE?", "%#{search}%"]).where(is_active: true)
    end
  end

end
