require 'rails_helper'

RSpec.describe Rubric do
  describe 'structure' do
    it { is_expected.to have_db_column(:title).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:content).of_type(:text) }
    it { is_expected.to have_db_index(:rubric_id) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:rubrics).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(55) }

    context 'when parent_id is wrong' do
      let(:rubric) { build :rubric, rubric_id: -1231312 }
      it { expect { rubric.save! }.to raise_error ActiveRecord::InvalidForeignKey }
    end

    context 'when has whitespace' do
      let(:rubric) { create :rubric, title: ' word1 word2 '}

      it { expect(rubric.title).to eq 'word1 word2' }
    end
  end

  describe 'rubrics' do
    let(:sub_rubrics) { create_list(:rubric, 10) }
    let(:rubric) { create :rubric, rubrics: sub_rubrics }

    it { expect(rubric.rubrics.count).to eq 10 }
    it { expect { rubric.destroy }.to change{ Rubric.count }.by (0) }
  end
end
