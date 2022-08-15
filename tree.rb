# frozen_string_literal: true

require 'pry-byebug'
require_relative 'node'

# creates and balances BST from array
class Tree
  attr_reader :root, :array

  def initialize(array)
    @array = array
    @root = build_tree(array, 0, array.length - 1)
  end

  def build_tree(array, first, last)
    array.sort.uniq!
    return nil if first > last

    mid = (first + last) / 2
    root = Node.new(array[mid])
    root.left_chldn = build_tree(array, first, mid - 1)
    root.rt_chldn = build_tree(array, mid + 1, last)
    root
  end

  # currently not inserting as proper subchildren and parent nodes
  def insert(value, root)
    if root.nil?
      Node.new(value)
    elsif root > value
      root.right_chldn.insert(value, rt_chldn.root)
    elsif root < value
      root.left_chldn.insert(value, left_chldn.root)
    end
  end

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
