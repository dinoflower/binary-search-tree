# frozen_string_literal: true

require_relative 'node'

# creates and balances BST from array
class Tree
  attr_reader :root

  def initialize(array)
    @array = array
    @root = nil
  end

  def build_tree(array); end

  def insert(value); end

  def delete(value); end

  def find(value); end

  def level_order
    # arr = child nodes to traverse
    if block_given?
      # yield queue to block
    else
      # don't do the searches
    end
    # return two nodes or array queue
  end

  # for these three, return array unless block given
  # otherwise yield nodes to block in correct order
  def inorder; end

  def preorder; end

  def postorder; end

  def height(node); end

  def depth(node); end

  def balanced?; end

  def rebalance; end
end