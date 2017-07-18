class Client < ApplicationRecord
  validates :name, presence: true, length: {maximum: 255}
  has_many :requests, dependent: :destroy
end

