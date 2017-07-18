require 'rails_helper'

RSpec.describe ClientsController do
  let(:client) { create(:client) }

  describe '#index' do
    let(:clients) { create_list(:client, 2) }
    before { get :index }

    it do
      expect(assigns(:clients)).to match_array(clients)
      expect(response).to render_template :index
    end
  end

  describe '#show' do
    before { get :show, params: {id: client.id} }

    it do
      expect(assigns(:client)).to eq client
      expect(response).to render_template :show
    end
  end

  describe '#new' do
    before { get :new }

    it do
      expect(assigns(:client)).to be_a_new(Client)
      expect(response).to render_template :new
    end
  end

  describe '#edit' do
    before { get :edit, params: {id: client.id} }

    it do
      expect(assigns(:client)).to eq client
      expect(response).to render_template :edit
    end
  end

  describe '#create' do
    let(:request) { post :create, params: {client: client_attributes} }

    context 'with valid attributes' do
      let(:client_attributes) { attributes_for(:client) }

      it do
        expect { request }.to change(Client, :count).by(1)
        expect(response).to redirect_to client_path(assigns(:client))
      end
    end

    context 'with invalid attributes' do
      let(:client_attributes) { attributes_for(:client, name: nil) }

      it do
        expect { request }.to_not change(Client, :count)
        expect(response).to render_template :new
      end
    end
  end

  describe '#update' do
    context 'valid attributes' do
      let(:request) { post :update,  params: {id: client.id, client: attributes_for(:client, name: 'change_name')} }

      before do
        request
        client.reload
      end

      it do
        expect(assigns(:client)).to eq client
        expect(client.name).to eq 'change_name'
        expect(response).to redirect_to client
      end
    end

    context 'invalid attributes' do
      let(:request) { post :update,  params: {id: client.id, client: attributes_for(:client, name: nil) } }

      before { request }

      it do
        expect(assigns(:client).errors).not_to be_empty
        expect(response).to render_template :edit
      end
    end
  end

  describe '#destroy' do
    context 'valid id' do
      before { client }
      let(:request) { delete :destroy, params: {id: client.id} }

      it do
        expect { request }.to change(Client, :count).by(-1)
        expect(assigns(:client)).to eq client
        expect(response).to redirect_to clients_path
      end
    end

    context 'invalid id' do
      before { client }
      let(:request) { delete :destroy, params: {id: -9000} }
      it do
        expect { request }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end


