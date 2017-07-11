class Request < ApplicationRecord
  validates :title, presence: true, length: {maximum: 255}
  validates :body, presence: true
  belongs_to :client
end

