require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 8
    @dynamic_array = StaticArray.new(@capacity)
    @starting_idx = 0
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if index >= @length
    @dynamic_array[index]
  end

  # O(1)
  def []=(index, value)
    raise "index out of bounds" if index >= @length
    @dynamic_array[index] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    @dynamic_array[@length - 1] = nil
    @length -= 1
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    if @length == @capacity
      resize!
    end
    @length += 1
    @dynamic_array[@length] = val
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if @length == 0
    @dynamic_array[@length - 1] = nil
    @length -= 1
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    if @length == @capacity
      resize!
    end
    (@length).downto(1) do |i|
      @dynamic_array[i] = @dynamic_array[i - 1]
    end
    @dynamic_array[0] = val
    @length += 1
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity *= 2
    new_array = StaticArray.new(@capacity)
    @length.times do |i|
      new_array[i] = @dynamic_array[i]
    end
    @dynamic_array = new_array
  end
end
