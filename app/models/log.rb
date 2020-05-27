class Log < ApplicationRecord
  belongs_to :post
  default_scope -> { order(created_at: :desc) }
  validates :post_id, presence: true
end
