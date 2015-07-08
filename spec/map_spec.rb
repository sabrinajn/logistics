require 'spec_helper'

describe Logistics::Map do
  describe '.find_path_with_costs' do
    subject { Logistics::Map.new(name: 'SP').find_path_with_costs('A', 'B', 10, 1.5) }

    it 'returns the path and costs when distance greater than 0' do
      allow_any_instance_of(Logistics::Graph).to receive(:best_path) { [['A','B'], 20] }

      expect(subject).to eq(['A B', 3.0])
    end

    it 'raises Logistics::PathNotFound when distance is Infinity' do
      allow_any_instance_of(Logistics::Graph).to receive(:best_path) { [['D'], Float::INFINITY] }

      expect{ subject }.to raise_error(Logistics::PathNotFound)
    end

    it 'raises Logistics::PathEmpty when distance is 0' do
      allow_any_instance_of(Logistics::Graph).to receive(:best_path) { [['D'], 0] }

      expect{ subject }.to raise_error(Logistics::PathEmpty)
    end
  end
end
