class Logistics::MapController < Sinatra::Base

  post '/' do
    data = Logistics::MapParamsValidator.new(params.slice('name','file'))
    halt 400, {errors: data.errors.messages}.to_json unless data.valid?

    map = Logistics::Map.new(name: data.name)
    map.build_routes(data.file[:tempfile])

    if map.valid?
      map.save!
      halt 201
    else
      halt 400, { errors: map.errors.messages }.to_json
    end
  end
end
