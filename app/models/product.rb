class Product < ApplicationRecord

  has_many :comments, dependent: :destroy

  validates :title, :description, :amount, :price, presence: true

  def truncated_description
	truncate(self.description, length:64)
  end

end
