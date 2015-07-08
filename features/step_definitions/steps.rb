Given(/^exists map with name "([^"]*)"$/) do |map_name|
  Logistics::Map.create(name: map_name)
end

Given(/^there are map with name '(.*?)' and the following routes:$/) do |map_name, table|
  map = Logistics::Map.new(name: map_name)
  data = table.raw
  data.shift
  data.each do |row|
    r = Logistics::Route.new(source: row[0], target: row[1], distance: row[2])
    map.routes << r
  end
  map.save
end

When(/^I send a POST request to "([^"]*)" with valid map name and valid routes$/) do |path|
  @map_name = 'SP'
  file_path = File.dirname(__FILE__) + '/../fixtures/routes.txt'
  post path, file: Rack::Test::UploadedFile.new(file_path, 'text/plain'), name: @map_name
end

When(/^I send a POST request to "([^"]*)" with valid routes and without name$/) do |path|
  file_path = File.dirname(__FILE__) + '/../fixtures/routes.txt'
  post path, file: Rack::Test::UploadedFile.new(file_path, 'text/plain')
end

When(/^I send a POST request to "([^"]*)" with valid map name and without valid routes$/) do |path|
  post path, name: 'SP'
end

When(/^I send a POST request to "([^"]*)" with name "([^"]*)"$/) do |path, map_name|
  file_path = File.dirname(__FILE__) + '/../fixtures/routes.txt'
  post path, file: Rack::Test::UploadedFile.new(file_path, 'text/plain'), name: map_name
end

When(/^I send a POST request to "([^"]*)" with valid routes and there are duplicated routes$/) do |path|
  file_path = File.dirname(__FILE__) + '/../fixtures/duplicated_routes.txt'
  post path, file: Rack::Test::UploadedFile.new(file_path, 'text/plain'), name: 'SP'
end

When /^I send a GET request to "([^"]*)"$/ do |path|
  get path
end

When(/^I send a POST request to "(.*?)" with valid routes and there are invalid routes$/) do |path|
  file_path = File.dirname(__FILE__) + '/../fixtures/invalid_routes.txt'
  post path, file: Rack::Test::UploadedFile.new(file_path, 'text/plain'), name: 'SP'
end

When(/^I send a POST request to "(.*?)" without params$/) do |path|
  post path
end

Then(/^the status code response should be "([^"]*)"$/) do |status_code|
  expect(last_response.status).to eq status_code.to_i
end

Then(/^the map should be created with the routes$/) do
  map = Logistics::Map.where(name: @map_name).first
  expect(map).to be_present
  expect(map.routes.size).to eq(6)
end

Then(/^the response body with the following JSON:$/) do |response_json|
  response = JSON.parse(last_response.body)
  expect(response).to include(JSON.parse(response_json))
end

Then(/^the response should have error for "([^"]*)" with "([^"]*)"$/) do |attribute, message|
  response = JSON.parse(last_response.body)["errors"][attribute]
  expect(response).to include(message)
end
