require_relative "heap"

class Array
  def heap_sort!
    max_heap = BinaryMinHeap.new { |a, b| b <=> a }
    self.each do |num|
      max_heap.push(num)
    end

    while max_heap.count > 0
      self[max_heap.count - 1] = max_heap.extract
    end
    self
  end
end
