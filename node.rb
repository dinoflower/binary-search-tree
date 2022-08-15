# frozen_string_literal: true

# creates root and leaf nodes within BST
class Node
  include Comparable

  attr_accessor :left_chldn, :rt_chldn
  attr_reader :data

  def initialize(data)
    @data = data
    @left_chldn = nil
    @rt_chldn = nil
  end
end
