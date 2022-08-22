# frozen_string_literal: true

# creates root and leaf nodes within BST
class Node
  include Comparable

  attr_accessor :left, :right, :data

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end
