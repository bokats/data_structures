require_relative 'bst_node'
require 'set'

class BinarySearchTree
  attr_accessor :root

  def initialize(value)
    @root = BSTNode.new(value)
  end

  def find(el)
    check_node = @root
    while true
      if el.val == check_node.val
        return true
      elsif el.val < check_node.val
        return false if !check_node.left
        check_node = check_node.left
      else
        return false if !check_node.right
        check_node = check_node.right
      end
    end
  end

  def insert(el)
    check_node = @root
    while true
      if el.val < check_node.val
        if check_node.left
          check_node = check_node.left
        else
          check_node.left = el
          el.parent = check_node
          break
        end
      elsif el.val > check_node.val
        if check_node.right
          check_node = check_node.right
        else
          check_node.right = el
          el.parent = check_node
          break
        end
      elsif !check_node.left
        check_node.left = el
        el.parent = check_node
        break
      elsif !check_node.right
        check_node = el
        el.parent = check_node
        break
      elsif rand(2) == 0
        check_node = check_node.left
      else
        check_node = check_node.right
      end
    end
  end

  def delete(el)
    if find(el)
      check_node = @root
      while true
        if el.val < check_node.val
          check_node = check_node.left
        elsif el.val > check_node.val
          check_node = check_node.right
        else
          if check_node.left && check_node.right
            max_node = maximum(check_node)
            check_node.val = maximum(check_node).val
            max_node.right = check_node.right
          elsif check_node.left
            check_node = check_node.left
          elsif check_node.right
            check_node = check_node.right
          end
          break
        end
      end
    else
      raise "node doesn't exist"
    end
  end

  def is_balanced?
    stack = [@root]
    while !stack.empty?
      current_node = stack.shift
      if !current_node.left
        left_depth = 0
      else
        left_depth = depth(current_node.left)
        stack << current_node.left
      end
      if !current_node.right
        right_depth = 0
      else
        right_depth = depth(current_node.right)
        stack << current_node.right
      end
      if (left_depth - right_depth).abs > 0
        return false
      end
    end
    true
  end

  def in_order_traversal
    stack = [@root]
    seen = Set.new
    result = []
    while !stack.empty?
      current_node = stack[-1]
      if !current_node.left || seen.include?(current_node.left)
        seen << current_node
        result << current_node.value
        stack.pop
        if current_node.right
          stack << current_node.right
        end
      else
        stack << current_node.left
      end
    end
  end

  def maximum(node)
    max = node.left
    while true
      if !max.right
        return max
      else
        max = max.right
      end
    end
  end

  def depth(node)
    max_count = 0
    queue = [[node, 0]]
    while !stack.empty?
      current_node = queue[0][0]
      current_count = queue[0][1]
      if current_count > max_count
        max_count = current_count
      end
      if current_node.left
        queue << [current_node.left, current_count += 1]
      elsif current_node.right
        queue << [curent_node.right, current_count += 1]
      end
      queue.shift
    end
  end
end

tree = BinarySearchTree.new(10)
