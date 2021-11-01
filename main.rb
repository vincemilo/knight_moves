class Board
  attr_accessor :tiles, :history, :end_point, :solutions

  def initialize(end_point)
    #@tiles = (0..7).to_a.repeated_permutation(2).to_a
    @history = []
    @end_point = end_point
    @solutions = []
  end

  def build_tree(parent)
    queue = []
    parent.children.each { |e| queue << e }
    until queue.empty?
      knight = queue.shift
      create_children(knight)
      build_tree(knight)
    end
  end

  def create_children(knight)
    @history << knight.position
    knight.moves.each do |e|
      x = knight.position[0] + e[0]
      y = knight.position[1] + e[1]
      next unless valid_move?(x, y)

      return find_shortest_path(knight) if @end_point == [x, y]

      child = Knight.new([x, y], knight)
      knight.children << child
    end
  end

  def find_shortest_path(knight)
    path = [@end_point]
    until knight.parent.nil?
      path << knight.position
      knight = knight.parent
    end
    path << knight.position
    @solutions << path.reverse
  end

  def valid_move?(x, y)
    x.negative? || y.negative? || x > 7 || y > 7 || @history.include?([x, y]) ? false : true
  end

  # def create_board
  #   board = Board.new
  #   placement = board.tiles.map { |e| e == knight.position ? 'K' : e }
  #   p placement
  #   p knight.position
  # end
end

class Knight
  attr_accessor :moves, :children, :position, :parent

  def initialize(position, parent = nil)
    @position = position
    @parent = parent
    @children = []
    @moves = [[2, 1], [1, 2], [-1, 2], [-2, 1], [-2, -1], [-1, -2], [1, -2], [2, -1]]
  end
end

def knight_moves(start_point, end_point)
  knight = Knight.new(start_point)
  board = Board.new(end_point)
  board.create_children(knight)
  board.build_tree(knight)
  shortest_route = board.solutions.sort_by(&:length)
  puts "You made it in #{shortest_route[0].length - 1} moves! Here's your path:"
  puts shortest_route[0].to_s
end

knight_moves([0, 0], [3, 3])
knight_moves([3, 3], [0, 0])
knight_moves([3, 3], [4, 3])
knight_moves([0, 0], [7, 7])