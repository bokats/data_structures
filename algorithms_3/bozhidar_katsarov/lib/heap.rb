class BinaryMinHeap
  def initialize(&prc)
    @store = []
    @prc = prc
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[count - 1] = @store[count - 1], @store[0]
    result = @store.pop
    if @prc
      BinaryMinHeap.heapify_down(@store, 0, count, &@prc)
    else
      BinaryMinHeap.heapify_down(@store, 0)
    end
    result
  end

  def peek
  end

  def push(val)
    @store << val
    if @prc
      BinaryMinHeap.heapify_up(@store, count - 1, &@prc)
    else
      BinaryMinHeap.heapify_up(@store, count - 1)
    end
  end

  # protected
  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_index)
    result = []
    first_child = (2 * parent_index) + 1
    second_child = (2 * parent_index) + 2
    result << first_child if first_child < len
    result << second_child if second_child < len
    result
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index < 1
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    current_idx = parent_idx
    swap = true
    prc ||= Proc.new { |a, b| a <=> b }
    while swap
      swap = false
      children = BinaryMinHeap.child_indices(len, current_idx)
      swap_idx = current_idx
      children.each do |i|
        if prc.call(array[i], array[swap_idx]) == -1
          swap = true
          swap_idx = i
        end
      end
      if swap
        array[current_idx], array[swap_idx] = array[swap_idx], array[current_idx]
        current_idx = swap_idx
      end
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    current_idx = child_idx
    swap = true
    prc ||= Proc.new { |a, b| a <=> b }
    until !swap || current_idx == 0
      swap = false
      parent = BinaryMinHeap.parent_index(current_idx)
      if prc.call(array[current_idx], array[parent]) == -1
        swap = true
        swap_idx = parent
      end
      if swap
        array[current_idx], array[swap_idx] = array[swap_idx], array[current_idx]
        current_idx = swap_idx
      end
    end
    array
  end
end
