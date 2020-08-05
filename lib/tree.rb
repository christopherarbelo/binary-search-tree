# frozen_string_literal: true

require_relative 'depth_first_traversable'

# Binary Search Tree class
class Tree
  include DepthFirstTraversable
  attr_reader :root
  def initialize(array)
    @array = array.sort.uniq
    @root = build_tree(@array)
  end

  private

  def build_tree(array)
    return if array.length.zero?

    midpoint = array.length / 2
    root = Node.new(array[midpoint])
    root.left = build_tree(array[0...midpoint])
    root.right = build_tree(array[(midpoint + 1)..-1])
    root
  end

  def delete_with_two_children(node)
    temp = minimum_node(node.right)
    node.data = temp.data
    node.right = delete(temp.data, node.right)
  end

  def minimum_node(node)
    node = node.left until node.left.nil?
    node
  end

  def one_or_less_child?(node)
    child_count = 0
    child_count += 1 if node.left
    child_count += 1 if node.right
    child_count < 2
  end

  def replace(node)
    node.left.nil? ? node.right : node.left
  end

  public

  def pretty_print(node = @root, prefix = '', is_left = true)
    return if node.nil?

    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false)
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true)
  end

  def insert(node, root = self.root)
    @root = node and return if root.nil?

    if root.data < node.data
      root.right.nil? ? root.right = node : insert(node, root.right)
    elsif root.left.nil?
      root.left = node
    else
      insert(node, root.left)
    end
  end

  def delete(key, node = root)
    return if node.nil?

    if node.data < key then node.right = delete(key, node.right)
    elsif node.data > key then node.left = delete(key, node.left)
    elsif one_or_less_child?(node) then return replace(node)
    else delete_with_two_children(node) end
    node
  end

  def find(target_data, node = root)
    return node if node.data == target_data
    return if node.left.nil? && node.right.nil?
    return find(target_data, node.right) if node.data < target_data
    return find(target_data, node.left) if node.data > target_data
  end

  def level_order(values = [], queue = [root])
    node = queue.pop
    return values if node.nil?

    values << node.data
    queue.unshift(node.left) unless node.left.nil?
    queue.unshift(node.right) unless node.right.nil?
    level_order(values, queue)
  end

  def height(node = root, height = 0, leaf_heights = [])
    return if node.nil?

    height(node.left, height + 1, leaf_heights)
    height(node.right, height + 1, leaf_heights)
    leaf_heights << height if node.left.nil? && node.right.nil?
    leaf_heights.max
  end

  def depth(key, depth = 0, node = root)
    return depth if node.nil? || node.data == key

    depth(key, depth + 1, node.data < key ? node.right : node.left)
  end

  def balanced?(node = root)
    return true if node.nil?
    return false if ((height(node.left) || -1) - (height(node.right) || -1)).abs > 1

    balanced?(node.left) && balanced?(node.right)
  end

  def rebalance
    @root = build_tree(inorder.sort)
  end
end
