class Tree
  @root

  def initialize(arr)
    @root = build_tree(sort(arr)) #requires Sortable Mixin
  end

  def build_tree(sorted)
    return nil if sorted.empty?
    return Node.new(sorted.first) if sorted.length == 1
    
    midIndex = sorted.length / 2
    mid = arr[midIndex]
    right_half = sorted[0..midIndex]
    left_half = sorted[mid+1..arr.size -1]
    
    root = Node.new(mid)
    root.set_left_child Node.new(build_tree(left_half))
    root.set_right_child Node.new(build_tree(right_Half))
    return root
  end

  def find_and_replace(value, node, new_child)
    right = node.prev_node.right_child
    left = node.prev_node.left_child
    return  right.set_right_child(new_child) if right.value == value
    return left.set_left_child(new_child) if left.value == value
      raise "Node's do not contain the value passed"
  end

  def level_order(queue = [@root], &block)
    node = queue.first
    left = node.left_child
    right = node.right_child
  
    block.call(node)
    if !left.nil?
      queue.push(left)
    end
    if !right.nil?
      queue.push(right)
    end

    level_order(queue, block)
  end

  def find(value)
    found_node = nil
    inorder do | node |
      if node.value == value
        found_node = node
        break;
      end
    end
    found_node
  end

  def find_insertion_leave(value, root)
    return root if root.leaf_node?
    if root.value <= value 
       findInsertionLeaf(value, root.left_child)
    else 
        findInsertionLeaf(value, root.right_child)
    end
  end

  ch
end