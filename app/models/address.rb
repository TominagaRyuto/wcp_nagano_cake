class Address < ApplicationRecord
  belongs_to :customer
  validates :customer_id, :name, :postal_code, :address, presence: true
  def full_address
    "〒"+self.postal_code + self.address + "　" + self.name
  end
end
