require 'rails_helper'

RSpec.describe RequestsController do
  let(:client) { create(:client) }

  describe '#new' do
    before { get :new, params: { client_id: client } }

    it do
      expect(assigns(:request)).to be_a_new(Request)
      expect(response).to render_template :new
    end
  end

  describe '#create' do
    let(:request) { post :create, params: { client_id: client.id, request: req_attributes } }

    context 'valid attributes' do
      let(:req_attributes) { attributes_for(:request) }

      it do
        expect { request }.to change(Request, :count).by(1)
        expect(response).to redirect_to client_requests_path(client)
      end
    end

    context 'invalid attributes' do
      let(:req_attributes) { attributes_for(:request, body: nil,  title: nil) }

      it do
        expect { request }.not_to change(Request, :count)
        expect(assigns(:request).errors).not_to be_empty
        expect(assigns(:request).errors).to include(:title, :body)
      end
    end
  end

  describe '#update' do
    let(:request) { create(:request) }
    context 'valid attributes' do
      let(:change) { post :update,  params: {client_id: client.id, id: request.id, request: attributes_for(:request, title: 'change_title') } }

      before do
        change
        request.reload
      end

      it do
        expect(assigns(:request)).to eq request
        expect(request.title).to eq 'change_title'
        expect(response).to redirect_to client_requests_path(client)
      end
    end

    context 'invalid attributes' do
      let(:change) { post :update,  params: {client_id: client.id, id: request.id, request: attributes_for(:request, title: nil)} }

      before { change }

      it do
        expect(assigns(:request).errors).not_to be_empty
        expect(response).to render_template :edit
      end
    end
  end

  describe '#destroy' do
    let!(:request) { create(:request, client: client) }
    let(:del_request) { delete :destroy, params: { client_id: client.id, id: request.id } }

    it do
      expect { del_request }.to change(Request, :count).by(-1)
      expect(assigns(:request)).to eq(request)
      expect(response).to redirect_to client_requests_path(client)
    end
  end
end
