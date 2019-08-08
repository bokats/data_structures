def trap(height)
    length = height.length
    return 0 if length == 0
    
    left = [0] * length
    right = [0] * length
    water = 0
    
    left[0] = height[0]
    
    (1...length).each do |i|
        left[i] = [left[i-1], height[i]].max
    end
    
    right[length - 1] = height[length -1]
    
    (length - 2).downto(0) do |i|
        right[i] = [right[i+1], height[i]].max
    end
    
    (0...length).each do |i|
        water += [left[i],right[i]].min - height[i]
    end
    water
end