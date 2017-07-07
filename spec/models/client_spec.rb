require 'rails_helper'

RSpec.describe Client do
  describe 'structure' do
    it { is_expected.to have_db_column(:name).of_type(:string).with_options(null: false) }
  end
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(255) }
  end
end
