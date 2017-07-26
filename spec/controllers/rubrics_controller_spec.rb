require 'rails_helper'

RSpec.describe RubricsController do
  let(:rubric) { create(:rubric) }

  describe '#index' do
    context 'with more than 9 rubrics' do
      let(:rubrics) { create_list(:rubric, 9) }

      it do
        expect(assigns(:rubrics)).to_not match_array(rubrics)
      end
    end

    context 'with less than 9 rubrics' do
      let(:rubrics) { create_list(:rubric, 2) }
      before { get :index }

      it do
        expect(assigns(:rubrics)).to match_array(rubrics)
        expect(response).to render_template :index
      end
    end
  end

  describe '#show' do
    before { get :show, params: {id: rubric.id} }

    it do
      expect(assigns(:rubric)).to eq rubric
      expect(response).to render_template :show
    end
  end

  describe '#new' do
    before { get :new, params: {rubric_id: rubric} }

    it do
      expect(assigns(:rubric)).to be_a_new(Rubric)
      expect(response).to render_template :new
    end
  end

  describe '#edit' do
    before { get :edit, params: {id: rubric.id} }

    it do
      expect(assigns(:rubric)).to eq rubric
      expect(response).to render_template :edit
    end
  end


  describe '#create' do
    let(:request) { post :create, params: {rubric: attributes_for(:rubric)} }

    context 'valid attributes' do
      it do
        expect { request }.to change(Rubric, :count).by(1)
        expect(response).to redirect_to rubric_path(assigns(:rubric))
      end
    end

    context 'invalid attributes' do
      let(:request) { post :create, params: {rubric: {title: nil}} }

      it do
        expect { request }.not_to change(Rubric, :count)
        expect(assigns(:rubric).errors).not_to be_empty
        expect(assigns(:rubric).errors).to include(:title)
        expect(response).to render_template :new
      end
    end
  end

  describe '#update' do
    context 'valid attributes' do
      let(:change) { post :update,  params: {id: rubric.id, rubric: attributes_for(:rubric, title: 'change_title')} }

      before do
        change
        rubric.reload
      end

      it do
        expect(assigns(:rubric)).to eq rubric
        expect(rubric.title).to eq 'change_title'
        expect(response).to redirect_to rubric
      end
    end

    context 'invalid attributes' do
      let(:change) { post :update,  params: {id: rubric.id, rubric: attributes_for(:rubric, title: nil)} }

      before { change }

      it do
        expect(assigns(:rubric).errors).not_to be_empty
        expect(response).to render_template :edit
      end
    end
  end

  describe '#destroy' do
    before { rubric }
    let(:del_request) { delete :destroy, params: {id: rubric.id} }

    context 'valid id' do
      it do
        expect { del_request }.to change(Rubric, :count).by(-1)
        expect(assigns(:rubric)).to eq(rubric)
        expect(response).to redirect_to rubrics_path
      end
    end

    context 'invalid id' do
      before { rubric }
      let(:del_request) { delete :destroy, params: {id: -9000} }
      it do
        expect { del_request }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
