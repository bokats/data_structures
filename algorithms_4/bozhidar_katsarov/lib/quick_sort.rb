class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new { |a, b| a <=> b }
    return array if length < 2
    pivot_idx = partition(array, start, length, &prc)
    left_length = pivot_idx - start
    right_length = length - (left_length + 1)
    self.sort2!(array, start, left_length, &prc)
    self.sort2!(array, pivot_idx + 1, right_length, &prc)
    array
  end

  def self.partition(array, start, length, &prc)

    prc ||= Proc.new { |a, b| a <=> b }

    pivot_idx = start
    divider = start + 1
    (start + 1).upto(length + start - 1) do |i|
      if prc.call(array[i], array[pivot_idx]) == -1
        array[divider], array[i] = array[i], array[divider]
        divider += 1
      end

    end
    array[pivot_idx], array[divider - 1] = array[divider - 1], array[pivot_idx]
    divider - 1
  end
end

puts QuickSort.sort2!([10,9,8,7], 0, 4)
