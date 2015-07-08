require 'spec_helper'

describe Logistics::Graph do

  describe '.best_path' do
    before do
       r1 = Logistics::Route.new(source: 'A', target: 'B', distance: 10)
       r2 = Logistics::Route.new(source: 'B', target: 'D', distance: 15)
       r3 = Logistics::Route.new(source: 'A', target: 'C', distance: 20)
       r4 = Logistics::Route.new(source: 'C', target: 'D', distance: 30)
       r5 = Logistics::Route.new(source: 'B', target: 'E', distance: 50)
       r6 = Logistics::Route.new(source: 'D', target: 'E', distance: 30)

      @graph = Logistics::Graph.new([r1,r2,r3,r4,r5,r6])
    end

    it 'returns the best path' do
      path, distance = @graph.best_path('A', 'D')

      expect(path).to eq(['A','B', 'D'])
      expect(distance).to eq(25)
    end

    it 'returns infinity when does not exist path' do
      path, distance = @graph.best_path('A', 'I')

      expect(distance).to eq(Float::INFINITY)
    end

    it 'returns infinity when does not exist source and target in graph' do
      path, distance = @graph.best_path('O', 'I')

      expect(distance).to eq(Float::INFINITY)
    end

    it 'returns zero when source is equals to target' do
      path, distance = @graph.best_path('A', 'A')

      expect(distance).to eq(0)
    end
  end
end
