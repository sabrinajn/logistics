class Logistics::Graph

  #inicializa o grafo com suas arestas e vertices
  def initialize(routes)
    @vertices = Hash.new{|key,value| key[value] = Logistics::Vertex.new(value)}

    @edges = {}
    routes.each do |route|
      @vertices[route.source].neighbours << route.target
      @vertices[route.target].neighbours << route.source
      @edges[[route.source, route.target]] = @edges[[route.target, route.source]] = route.distance
    end
  end

  # Calcula o melhor caminho, ou seja, o caminho mais curto entre dois pontos
  # source = ponto de origem
  # target = ponto de destino
  # retorna um array com as arestas do caminho e a distancia entre a origem e destino
  # quando não existe caminho entre os dois pontos a distancia retornada será Float::INFINITY
  # quando a origem é igual ao destino a distancia retornada será 0
  def best_path(source, target)
    find(source)
    path = []

    point = target
    while point
      path.unshift(point)
      point = @vertices[point].previous
    end
    return path, @vertices[target].distance
  end

  private

  #Implementação do algoritmo de dijkstra, para encontrar o caminho mais curto
  def find(source)
    nodes = @vertices.values

    nodes.each do |v|
      v.distance = Float::INFINITY
      v.previous = nil
    end

    @vertices[source].distance = 0
    until nodes.empty?
      u = nodes.min_by {|vertex| vertex.distance}
      break if u.distance == Float::INFINITY
      nodes.delete(u)
      u.neighbours.each do |v|
        vv = @vertices[v]
        if nodes.include?(vv)
          alt = u.distance + @edges[[u.name, v]]
          if alt < vv.distance
            vv.distance = alt
            vv.previous = u.name
          end
        end
      end
    end
  end
end
