class Rubric < ApplicationRecord
  strip_attributes only: :title
  validates :title, presence: true, length: {maximum: 55}
  has_many :rubrics, dependent: :destroy
  belongs_to :rubric, optional: true

  scope :without_rubric, -> { where(rubric_id: nil) }
end

