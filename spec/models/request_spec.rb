require 'rails_helper'

RSpec.describe Request do
  describe 'structure' do
    it { is_expected.to have_db_column(:title).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:body).of_type(:text) }
    it { is_expected.to have_db_index(:client_id) }
  end
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(255) }

    context 'when parent_id is wrong' do
      let(:request) { build :request, client_id: -1231312 }
      before { request.validate }

      it { expect(request.errors).to include(:client) }
    end
  end
end
