def quick_sort(array, start = 0, length = array.length)
  return array if length < 2
  pivot_idx = partition(array, start, length)
  left_length = pivot_idx - start
  right_length = length - (left_length + 1)
  quick_sort(array, start, left_length)
  quick_sort(array, pivot_idx + 1, right_length)
  array
end

def partition(array, start, length)
  pivot_idx = rand(start...start + length)
  array[pivot_idx], array[start] = array[start], array[pivot_idx]
  pivot_idx = start

  divider = start + 1
  (start + 1).upto(length + start - 1) do |i|
    if array[i] < array[pivot_idx]
      array[divider], array[i] = array[i], array[divider]
      divider += 1
    end

  end
  array[pivot_idx], array[divider - 1] = array[divider - 1], array[pivot_idx]
  divider - 1
end

p quick_sort([5,10,8,1,2])
p quick_sort([1,2,4])

