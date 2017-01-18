class Comment < ApplicationRecord
  belongs_to :product

  validates :text, presence: true

  def created_at_h
    created_at.strftime('%B %d, %Y at %I:%M%p')
  end
end
