# frozen_string_literal: true

# creates root and leaf nodes within BST
class Node
  include Comparable

  attr_reader :data, :left_children, :right_children

  def initialize(data)
    @data = data
    @left_children = nil
    @right_children = nil
  end
end