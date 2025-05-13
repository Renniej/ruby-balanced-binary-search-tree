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

    if right.value == value
      node.prev_node.right_child = new_child
    elsif left.value == value
      node.prev_node.left_child = new_child
    else
      raise "Node's do not contain the value passed"
    end
  end

  

end