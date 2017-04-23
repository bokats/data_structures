require_relative 'graph'
require 'byebug'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  sorted = []
  queue = []
  vertices.each do |vertex|
    if vertex.in_edges.empty?
      queue << vertex
    end
  end

  until queue.empty?
    current_vertex = queue.shift
    sorted << current_vertex

    until current_vertex.out_edges.empty?
      edge = current_vertex.out_edges[0]

      if edge.to_vertex.in_edges.length == 1
        queue << edge.to_vertex
      end
      edge.destroy!
    end
    current_vertex.in_edges = nil
    current_vertex.out_edges = nil
  end
  p sorted
end

# v1 = Vertex.new("Wash Markov")
# v2 = Vertex.new("Feed Markov")
# v3 = Vertex.new("Dry Markov")
# v4 = Vertex.new("Brush Markov")
#
# vertices = []
# vertices.push(v1, v2, v3, v4)
#
# Edge.new(v1, v2)
# Edge.new(v1, v3)
# Edge.new(v2, v4)
# Edge.new(v3, v4)
#
# topological_sort(vertices)
