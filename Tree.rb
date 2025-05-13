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

  def
end