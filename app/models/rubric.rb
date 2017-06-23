class Rubric < ApplicationRecord
  validates :title, presence: true, length: {maximum: 255}
  has_many :rubrics, dependent: :destroy
  belongs_to :rubric
end

