require 'spec_helper'

describe Logistics::Route do
  describe 'validations' do
    let(:route) { Logistics::Route.new(source: 'A', target: 'B', distance: 10) }

    describe '#distance' do
      it 'is required' do
        route.distance = nil
        expect(route).not_to be_valid
      end

      it 'is invalid when less than 0' do
        route.distance = -1
        expect(route).not_to be_valid
      end

      it 'is invalid when equals 0' do
        route.distance = 0
        expect(route).not_to be_valid
      end

      it 'is valid when greater than 0' do
        route.distance = 10
        expect(route).to be_valid
      end
    end

    describe '#source' do
      it 'is required' do
        route.source = nil
        expect(route).not_to be_valid
      end

      it 'must be different of target' do
        route.target = "A"
        expect(route).not_to be_valid
      end
    end

    describe '#target' do
      it 'is required' do
        route.target = nil
        expect(route).not_to be_valid
      end

      it 'must be different of source' do
        route.source = "B"
        expect(route).not_to be_valid
      end
    end
  end
end
