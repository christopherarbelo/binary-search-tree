# frozen_string_literal: true

# Node class for the Binary Search Tree
class Node
  include Comparable
  attr_accessor :data, :left, :right
  def initialize(data)
    self.data = data
  end

  def <=>(other)
    data <=> other.data
  end
end
