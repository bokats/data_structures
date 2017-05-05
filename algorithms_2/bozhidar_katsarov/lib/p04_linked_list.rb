class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    link = @head.next
    while !link.next.nil?
      if link.key == key
        return link.val
      else
        link = link.next
      end
    end
    nil
  end

  def include?(key)
    link = @head.next
    while !link.next.nil?
      if link.key == key
        return true
      else
        link = link.next
      end
    end
    false
  end

  def append(key, val)
    new_link = Link.new(key, val)
    new_link.next = @tail
    new_link.prev = @tail.prev
    @tail.prev.next = new_link
    @tail.prev = new_link
    new_link
  end

  def update(key, val)
    link = @head.next
    while !link.next.nil?
      if link.key == key
        link.key = key
        link.val = val
        break
      else
        link = link.next
      end
    end
    link
  end

  def remove(key)
    link = @head.next
    while !link.next.nil?
      if link.key == key
        link.prev.next = link.next
        link.next.prev = link.prev
        link.remove
        break
      else
        link = link.next
      end
    end
  end

  def each
    link = @head.next
    while !link.next.nil?
      yield link
      link = link.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
