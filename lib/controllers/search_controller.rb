class Logistics::SearchController < Sinatra::Base

  get '/' do
    begin
      data = Logistics::SearchParamsValidator.new(params.slice('name','source','target','autonomy','price'))
      halt 400, {errors: data.errors.messages}.to_json unless data.valid?

      map = Logistics::Map.where(name: params["name"]).first

      if map
        route, cost = map.find_path_with_costs(params["source"], params["target"], params["autonomy"].to_f, params["price"].to_f)
        halt 200, { route: route, cost: cost }.to_json
      else
        halt 404, { errors: 'Map not found' }.to_json
      end
    rescue Logistics::PathNotFound
      halt 400, { errors: 'path not found' }.to_json
    rescue Logistics::PathEmpty
      halt 400, { errors: 'source is equal to target' }.to_json
    end
  end
end
