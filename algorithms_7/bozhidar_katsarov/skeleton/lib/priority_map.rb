require_relative 'heap2'

class PriorityMap
  def initialize(&prc)
    @map = {}
    @queue = BinaryMinHeap.new(&prc)
  end

  def [](key)
    @map[key]
  end

  def []=(key, value)
    @map[key] = value
    queue.push(key)
  end

  def count
    @map.count
  end

  def empty?
    return true if count < 1
    false
  end

  def extract
    key = queue.extract
    value = @map.delete(key)
    [key, value]
  end

  def has_key?(key)
    return true if @map[key]
    false
  end

  protected
  attr_accessor :map, :queue

  def insert(key, value)
  end

  def update(key, value)
  end
end
