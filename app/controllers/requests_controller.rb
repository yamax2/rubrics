class RequestsController < ApplicationController
  before_action :find_request, only: %i(show edit update destroy)
  before_action :find_client
  def index
    @requests = @client.requests.order(:id)
  end

  def new
    @request = @client.requests.new
  end

  def create
    @request = @client.requests.new(request_params)

    if @request.save
      redirect_to client_requests_path(@client), notice: 'Record was successfully created.'
    else
      render :new
    end
  end

  def update
    if @request.update(request_params)
      redirect_to client_requests_path(@client), notice: 'Record was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @request.destroy
    redirect_to client_requests_path(@client), notice: 'Record was successfully destroyed.'
  end

  private

  def find_client
    @client = Client.find(params[:client_id])
  end

  def find_request
    @request = Request.find(params[:id])
  end

  def request_params
    params.require(:request).permit(:title, :body)
  end
end
