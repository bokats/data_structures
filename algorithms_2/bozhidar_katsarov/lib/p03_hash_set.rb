require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count == num_buckets
    @store[key.hash % num_buckets].push(key)
    @count += 1
  end

  def include?(key)
    @store[key.hash % num_buckets].include?(key)
  end

  def remove(key)
    bucket = @store[key.hash % num_buckets]
    bucket.delete_at(bucket.index(key) || bucket.length)
    @store[key.hash % num_buckets] = bucket
    @count -= 0
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { Array.new }
    @store.each do |bucket|
      bucket.each do |num|
        new_store[num.hash % new_store.length] << num
      end
    end
    @store = new_store
  end
end
