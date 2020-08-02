# frozen_string_literal: true

# Binary Search Tree class
class Tree
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

  public

  def pretty_print(node = @root, prefix = '', is_left = true)
    return if node.nil?

    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
