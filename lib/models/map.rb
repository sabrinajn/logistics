class Logistics::Map < ActiveRecord::Base
  has_many :routes

  validates :name, presence: true, uniqueness: true
  validate  :validate_routes

  def build_routes(file)
    File.read(file).each_line do |line|
      route = Logistics::Route.new(
        source: line.split(" ")[0],
        target: line.split(" ")[1],
        distance: line.split(" ")[2]
      )

      self.routes << route
    end
  end

  def find_path_with_costs(source, target, autonomy, price)
    graph = Logistics::Graph.new(routes)

    path, distance = graph.best_path(source, target)
    raise Logistics::PathNotFound if distance == Float::INFINITY
    raise Logistics::PathEmpty if distance == 0

    costs = (distance/autonomy) * price
    return path.join(" "), costs
  end

  private

  def validate_routes
    unless self.routes.size == self.routes.map { |r| [r[:source], r[:target]] }.uniq.size
      errors.add(:routes, "there are duplicate routes")
    end
  end
end

class Logistics::PathNotFound < ::StandardError; end
class Logistics::PathEmpty < ::StandardError; end
