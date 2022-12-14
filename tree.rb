# frozen_string_literal: true

require_relative 'node'

# creates balanced BST from array and includes methods for traversal, insertion, and deletion
class Tree
  def initialize(array)
    @array = array.sort.uniq!
    @root = build_tree(array.sort.uniq, 0, array.sort.uniq.length - 1)
  end

  def print_tree(node = @root, prefix = '', is_left = true)
    print_tree(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    print_tree(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value, root = @root)
    return Node.new(value) if root.nil?

    root.data > value ? root.left = insert(value, root.left) : root.right = insert(value, root.right)
    root
  end

  def delete(value, root = @root)
    return root if root.nil?

    if root.data == value
      root = check_chldrn(root)
    else
      root.data > value ? root.left = delete(value, root.left) : root.right = delete(value, root.right)
    end
    root
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

  def height(node = @root)
    return -1 if node.nil?

    [height(node.left), height(node.right)].max + 1
  end

  def depth(node, root = @root)
    return 0 if node == root

    node.data < root.data ? depth(node, root.left) + 1 : depth(node, root.right) + 1
  end

  def balanced?(node = @root)
    return true if node.nil?

    if (height(node.left) - height(node.right)).abs <= 1 && balanced?(node.left) && balanced?(node.right)
      true
    else
      false
    end
  end

  def rebalance
    queue = []
    inorder { |node| queue << node.data }
    @root = build_tree(queue.sort.uniq, 0, queue.sort.uniq.length - 1)
  end

  private

  attr_reader :root

  def build_tree(array, first, last)
    return nil if first > last

    mid = (first + last) / 2
    root = Node.new(array[mid])
    root.left = build_tree(array, first, mid - 1)
    root.right = build_tree(array, mid + 1, last)
    root
  end

  def check_chldrn(root)
    return root.right if root.left.nil?

    return root.left if root.right.nil?

    temp = find_min(root.right)
    root.right = delete(temp.data, root.right)
    root
  end

  def find_min(root)
    min = root.left until root.left.nil?
    min
  end
end
