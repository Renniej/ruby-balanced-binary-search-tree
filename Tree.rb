class Tree
  @root

  def initialize(arr)
    @root = build_tree(sort(arr)) #requires Sortable Mixin
  end

  def build_tree(sorted)
    return nil if sorted.empty?
    return Node.new(sorted.first) if sorted.length == 1
    
    midIndex = sorted.length / 2
    right_half = sorted[0..midIndex]
    left_half = sorted[mid+1..arr.size -1]
    
    root = Node.new(arr[midIndex])
    root.set_left_child build_tree(left_half)
    root.set_right_child build_tree(right_Half)
    return root
  end



  def replace_child_of_value(node, new_node, value) 
    if node.right_child.value == value
      node.set_right_child(new_node)
    elsif node.left_child.value == value
      node.set_left_child(new_node)
    else 
      raise "Prev node does not contain a child with value : #{value}"
    end
  end

  def delete_case_one(node)
    return false if !node.leaf_node?
    replace_child_of_value(prev_node, nil, value) 
    true
  end

  def delete_case_two(node)
    return false if node.num_of_children != 1
    prev_node = node.prev_node
    child = (node.right_child.nil?) ? node.left_child : node.right_child
    replace_child_of_value(prev_node, child, value)
    node.prev_node = nil
    true
  end

  def delete_case_three(node) 
    return false if node.num_of_children != 2
    successor = nil
    inorder(node.right_child) do |node|
      if (successor.nil? || node.value <= successor.value)
        successor = node
      end
    end
    node.right_child.prev_node = successor
    replace_child_of_value(successor.prev_node, node, successor.value)
    [
      delete_case_one, 
      delete_case_two, 
      delete_case_three
    ].any? { |delete_case| delete_case(node)}
    true
  end

  def delete(value)
    return nil unless (node = find(value))
    [
      delete_case_one, 
      delete_case_two, 
      delete_case_three
    ].any? { |delete_case| delete_case(node)}
  end

  def height
  end

  def balanced?
  end

  def rebalance
  end




  def find_and_replace(value, node, new_child)
    right = node.prev_node.right_child
    left = node.prev_node.left_child
    return  right.set_right_child(new_child) if right.value == value
    return left.set_left_child(new_child) if left.value == value
      raise "Node's do not contain the value passed"
  end

  def level_order(queue = [@root], &block)
    return if queue.empty?
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

  def find_insertion_leaf(value, root)
    return root if root.leaf_node?
    if root.value <= value 
      find_insertion_leaf(value, root.left_child)
    else 
      find_insertion_leaf(value, root.right_child)
    end
  end

  def insert(value)
    leaf_node =  find_insertion_leaf(value, @root)
    new_node = Node.new(value)
    if leaf_node.value <= value
        leaf_node.set_left_child(new_node)
    else
      leaf_node.set_right_child(new_node)
    end
  end

  def toArray(&block = inorder)
    arr = []
    block.call({|node| arr.push(node)})
    return arr
  end

  def inorder(&block, root = @root)
    return toArray(inorder) if block.nil?
    left_node = root.left_node
    right_node = root.right_node
    [left_node, root, right_node].compact.each {|node| block.call(node)}
  end
  
  def preorder(&block, root = @root)
    return toArray(preorder) if block.nil?
    left_node = root.left_node
    right_node = root.right_node
    [ root, left_node, right_node].compact.each {|node| block.call(node)}
  end
  
  def postorder(&block, root = @root)
    return toArray(postorder) if block.nil?
    left_node = root.left_node
    right_node = root.right_node
    [ left_node, right_node,root].compact.each {|node| block.call(node)}
  end

end