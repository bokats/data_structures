class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  include Enumerable
  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    if i >= @count
      return nil
    elsif i < 0
      return nil if i < -(@count)
      return self[@count + i]
    end

    @store[i % capacity]

  end

  def []=(i, val)
    if i >= @count
      (i - @count).times { push(nil) }
    elsif i < 0
      return nil if i < -(@count)
      return self[@count + i] = val
    end

    if i == @count
      resize! if capacity == @count
      @count += 1
    end

    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    @count.times do |i|
      if @store[i] == val
        return true
      end
    end
    false
  end

  def push(val)
    if @count == capacity
      resize!
    end
    @store[@count] = val
    @count += 1
    self
  end

  def unshift(val)
    if @count == capacity
      resize!
    end
    (@count).downto(1) do |i|
      @store[i] = @store[i - 1]
    end
    @store[0] = val
    @count += 1
    self
  end

  def pop
    return nil if @count == 0
    item = @store[@count - 1]
    @store[@count - 1] = nil
    @count -= 1
    item
  end

  def shift
    return nil if @count == 0
    item = @store[0]
    @count -= 1
    @count.times do |i|
      @store[i] = @store[i + 1]
    end
    item
  end

  def first
    @store[0]
  end

  def last
    @store[1]
  end

  def each
    @count.times do |i|
      yield self[i]
    end
    self
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    return false if other.count != @count
    @count.times do |i|
      if @store[i] != other[i]
        return false
      end
    end
    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_array = StaticArray.new(capacity * 2)
    @count.times do |i|
      new_array[i] = @store[i]
    end
    @store = new_array
  end
end
