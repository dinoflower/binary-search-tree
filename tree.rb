# frozen_string_literal: true

require 'pry-byebug'
require_relative 'node'

# creates and balances BST from array
class Tree
  attr_reader :root

  def initialize(array)
    @array = array.sort.uniq!
    @root = build_tree(array.sort.uniq, 0, array.sort.uniq.length - 1)
  end

  def build_tree(array, first, last)
    return nil if first > last

    mid = (first + last) / 2
    root = Node.new(array[mid])
    root.left = build_tree(array, first, mid - 1)
    root.right = build_tree(array, mid + 1, last)
    root
  end

  def insert(value, root = @root)
    if root.nil?
      root = Node.new(value)
    elsif root.data == value
      root
    elsif root.data > value
      root.left = insert(value, root.left)
    else
      root.right = insert(value, root.right)
    end
    root
  end

  def delete(value, root = @root)
    if root.nil?
      root
    elsif root.data > value
      root.left = delete(value, root.left)
    elsif root.data < value
      root.right = delete(value, root.right)
    else
      root = check_chldrn(root)
    end
    root
  end

  def check_chldrn(root)
    if root.left.nil?
      root.right
    elsif root.right.nil?
      root.left
    else
      root.data = find_min(root.right)
      root.right = delete(root.data, root.right)
      root
    end
  end

  def find_min(root)
    min = root.data
    until root.left.nil?
      min = root.left.data
      root = root.left
    end
    min
  end

  def find(value, root = @root)
    root = root.data > value ? root.left : root.right until root.nil? || value == root.data
    root
  end

  def level_order(&block)
    queue = [@root]
    queue.each do |node|
      queue << node.left unless node.left.nil?
      queue << node.right unless node.right.nil?
    end
    block_given? ? queue.each(&block) : queue
  end

  def inorder(root = @root, queue = [], &block)
    return if root.nil?

    inorder(root.left, queue)
    queue << root
    inorder(root.right, queue)
    block_given? ? queue.each(&block) : queue
  end

  def preorder(root = @root, queue = [], &block)
    return if root.nil?

    queue << root
    preorder(root.left, queue)
    preorder(root.right, queue)
    block_given? ? queue.each(&block) : queue
  end

  def postorder(root = @root, queue = [], &block)
    return if root.nil?

    postorder(root.left, queue)
    postorder(root.right, queue)
    queue << root
    block_given? ? queue.each(&block) : queue
  end

  def height(node); end

  def depth(node); end

  def balanced?; end

  def rebalance; end
end
