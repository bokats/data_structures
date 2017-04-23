require_relative 'graph'
require 'set'
require 'byebug'

# O(|V|**2 + |E|).
def dijkstra1(start_vertex)

  visited = { start_vertex => 0 }

  queue = [start_vertex]

  until queue.empty?
    
    current_node = queue.shift
    current_weight = visited[current_node]
    current_node.out_edges.each do |edge|
      weight = current_weight + edge.cost
      if !visited.include?(edge.to_vertex) || weight < visited[edge.to_vertex]
        visited[edge.to_vertex] = weight
        queue << edge.to_vertex
      end
    end
  end

  visited.sort_by(&:last)

end

v1 = Vertex.new("A")
v2 = Vertex.new("B")
v3 = Vertex.new("C")
v4 = Vertex.new("D")

Edge.new(v1, v2, 10)
Edge.new(v1, v3, 5)
Edge.new(v3, v2, 3)
Edge.new(v1, v4, 9)
Edge.new(v3, v4, 2)

dijkstra1(v1)
