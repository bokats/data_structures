class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    result = 0
    if self.empty?
      return 0
    else
      self.each_with_index do |el, i|
        result += el.hash * (i + 1)
      end
    end
    result
  end
end

class String
  def hash
    result = 0
    if self.empty?
      return 0
    else
      count = 1
      self.each_char do |el|
        result += el.ord.hash * count
        count += 1
      end
    end
    result
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    result = 0
    if self.empty?
      return 0
    else
      self.each do |k, v|
        result += k.to_s.sum.hash
        result += v.to_s.sum.hash 
      end
    end
    result
  end
end



# self.hash
