# *NB*: what do you need to require here? This is a good chance to review a little Ruby require syntax.
require_relative 'binary_search_tree'
require_relative 'bst_node'
require 'set'

def kth_largest(bst, k)
  stack = [bst.root]
  seen = Set.new
  count = 1
  while !stack.empty?
    current_node = stack[-1]
    if !current_node.left || seen.include?(current_node.left)
      if count == k
        return current_node
      else
        seen << current_node
        count += 1
        stack.pop
      end
      if current_node.right
        stack << current_node.right
      end
    else
      stack << current_node.left
    end
  end
  nil
end

def lowest_common_ancestor(bst, node1, node2)
  path1 = find_path(bst, node1)
  path2 = find_path(bst, node2)
  if path1.length > path2.length
    deeper_path = path1
    shallow_path = Set.new(path2)
  else
    deeper_path = path2
    shallow_path = Set.new(path1)
  end
  (deeper_path.length - 1).downto(0) do |node|
    if shallow_path.include?(node)
      return node
    end
  end
end

def post_order_traversal(bst)
  stack = [bst.root]
  seen = Set.new
  result = []
  while !stack.empty?
    current_node = stack[-1]
    if seen.include?(current_node)
      stack.pop
    elsif (!current_node.left || seen.include?(current_node.left)) ||
      (!current_node.right || seen.include?(current_node.right))
      seen << current_node
    elsif !current_node.left || seen.include?(current_node.left)
      result << current_node.left
      stack << current_node.left
    elsif current_node.right
      stack << current.right
    end
  end
end

def reconstruct(post_order, in_order)
  post_order = post_order
  in_order = in_order
  reconstruct2(0, in_order.length, post_order, in_order)

end

def reconstruct2(start, ending, post_order, in_order)

  if start < ending
    root = BSTRoot(post_order.pop)
    index = in_order.index(root.val)
    root.right = reconstruct2(index + 1, ending, post_order, in_order)
    root.left = reconstruct2(start, index, post_order, in_order)
    return root
  end
end

def find_path(bst, node)
  path = []
  if !bst.root
    return false
  end
  current_node = bst.root
  while true
    if node.value < current_node.value
      path << current_node
      current_node = current_node.left
    elsif node.value > current_node.value
      path << current_node
      current_node = current_node.right
    elsif node.value == current_node.value
      return path
    end
  end
end
