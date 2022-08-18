# frozen_string_literal: true

require 'pry-byebug'
require_relative 'node'

# creates and balances BST from array
class Tree
  attr_reader :root

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

  def insert(value)
    insert_value(value, @root)
  end

  def insert_value(value, root)
    if root.nil?
      root = Node.new(value)
    elsif root.data == value
      root
    elsif root.data > value
      root.left_chldn = insert_value(value, root.left_chldn)
    else
      root.rt_chldn = insert_value(value, root.rt_chldn)
    end
    root
  end

  def delete(value)
    delete_value(value, @root)
  end

  def delete_value(value, root)
    if root.nil?
      root
    elsif root.data > value
      root.left_chldn = delete_value(value, root.left_chldn)
    elsif root.data < value
      root.rt_chldn = delete_value(value, root.rt_chldn)
    else
      root = check_chldrn(root)
    end
    root
  end

  def check_chldrn(root)
    if root.left_chldn.nil?
      root.rt_chldn
    elsif root.rt_chldn.nil?
      root.left_chldn
    else
      root.data = find_min(root.rt_chldn)
      root.rt_chldn = delete_value(root.data, root.rt_chldn)
      root
    end
  end

  def find_min(root)
    min = root.data
    until root.left_chldn.nil?
      min = root.left_chldn.data
      root = root.left_chldn
    end
    min
  end

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
