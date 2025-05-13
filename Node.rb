class Node
  @value
  @prev_node
  @left_child
  @right_child

  def initialize(value)
    @value = value
  end

  def num_of_children
    [@left_child, @right_child].compact.size
  end

  def leaf_node?
    @left_child.nil? && @right_child.nil?
  end

  def set_right_child(node)
    node.prev_node = self
    @right_child = node
  end

  def set_left_child(node)
    node.prev_node = self
    @left_child = node
  end
  
end