class Order < ApplicationRecord
  before_create :set_order_status
  before_save :update_subtotal
  validates :total, presence: true
  has_many :order_items
  belongs_to :order_status

  def subtotal
    order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
  end

  private

  def set_order_status
    self.order_status_id = 1
  end

  def update_subtotal
    self[:subtotal] = subtotal
  end
end
