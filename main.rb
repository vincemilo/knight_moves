class Board
  attr_accessor :tiles, :row, :loop

  def initialize
    @row = Array.new(8, 0)
    @loop = 0
    @tiles = Array.new(8) { Array.new(8) { |e| [make_grid, e] } }
  end

  def make_grid
    if @row.empty?
      @loop += 1
      @row = Array.new(8, @loop)
    end
    @row.shift
  end
end

class Knight
  attr_accessor :moves

  def initialize
    @moves = [[2, 1], [1, 2], [-1, 2], [-2, 1], [-2, -1], [-1, -2], [1, -2], [2, -1]]
  end
end

class Tree
  attr_accessor :root, :data

  def initialize(arr)
    @data = arr.uniq.sort
    @root = build_tree(data)
  end

  class Node
    attr_accessor :data, :left, :right

    def initialize(data)
      @data = data
      @left = nil
      @right = nil
    end
  end

  def build_tree(arr)
    return nil if arr.empty?

    mid = (arr.length - 1) / 2
    root = Node.new(arr[mid])
    root.left = build_tree(arr[0...mid])
    root.right = build_tree(arr[(mid + 1)..-1])
    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def find(val, node = root)
    return node if node.nil? || node.data == val

    if val < node.data
      find(val, node.left)
    else
      find(val, node.right)
    end
  end

  def knight_moves(start_point, end_point, node = root)
    return start_point if start_point == end_point

    p node.data
    p start_point
    p end_point
  end
end

board = Board.new
p board.tiles
knight = Knight.new
bst = Tree.new(knight.moves)
bst.pretty_print
bst.knight_moves([0, 0], [1, 2])