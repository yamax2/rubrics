crumb :root do
  link "home", root_path
end

crumb :clients do
  link "clients", clients_path
end

crumb :client do |client|
  link client.name || %Q(new #{client.model_name.human}).capitalize, client
  parent :clients
end

crumb :request do |client, request|
  if request.id
    link request.title, client_request_path(client, request)
  else
    link %Q(new #{request.model_name.human}).capitalize, new_client_request_path(client)
  end
  parent :requests, client
end

crumb :requests do |client|
  link 'requests', client_requests_path(client)
  parent :client, client
end