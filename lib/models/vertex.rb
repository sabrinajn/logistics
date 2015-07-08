class Logistics::Vertex
  attr_accessor :name, :neighbours, :distance, :previous

  def initialize(name)
     self.name = name
     self.neighbours = []
     self.distance = Float::INFINITY
     self.previous = nil
  end
end
