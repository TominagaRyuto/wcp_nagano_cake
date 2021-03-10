class Order < ApplicationRecord
  validates :postal_code, :address, :name, :shipping_cost, :total_payment, presence: true
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  enum payment_method: [:クレジットカード, :銀行振込]
end
