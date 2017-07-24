crumb :root do
  link "Home", root_path
end

crumb :clients do
  link "Clients", clients_path
end

crumb :client do |client|
  link client.name, client_path(client)
  parent :clients
end

crumb :request do |request|
  link request.title, request_path(request)
  parent :client, request.client
end
