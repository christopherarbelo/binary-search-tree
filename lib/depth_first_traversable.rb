# frozen_string_literal: true

# Depth first traversing methods for BST
module DepthFirstTraversable
  def inorder(root = self.root, values = [])
    inorder(root.left, values) unless root.left.nil?
    values << root.data
    inorder(root.right, values) unless root.right.nil?
    values
  end

  def preorder(root = self.root, values = [])
    return if root.nil?

    values << root.data
    preorder(root.left, values)
    preorder(root.right, values)
    values
  end

  def postorder(root = self.root, values = [])
    postorder(root.left, values) unless root.left.nil?
    postorder(root.right, values) unless root.right.nil?
    values << root.data
    values
  end
end
