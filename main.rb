class Board
  attr_accessor :tiles, :history, :end_point

  def initialize
    @tiles = (0..7).to_a.repeated_permutation(2).to_a
    @history = []
    @end_point = nil
  end

  def build_tree(parent)
    queue = []
    parent.children.each { |e| queue << e }
    until queue.empty?
      knight = queue.shift
      create_children(knight)
    end
  end

  def create_children(knight, end_point = @end_point)
    @end_point = end_point if @end_point.nil?
    @history << knight.position
    knight.moves.each do |e|
      x = knight.position[0] + e[0]
      y = knight.position[1] + e[1]
      #p "Move #{e} new coords #{[x, y]}"
      if @end_point == [x, y]
        @history.push([x, y])
        puts "You made it in #{@history.length - 1} move(s)! Here's your path:"
        p @history
        abort
      elsif valid_move?(x, y)
        child = Knight.new([x, y])
        child.parent = knight
        knight.children << child
      end
    end
  end

  def valid_move?(x, y)
    x.negative? || y.negative? || x > 7 || y > 7 || @history.include?([x, y]) ? false : true
  end

  def create_board
    board = Board.new
    placement = board.tiles.map { |e| e == knight.position ? 'K' : e }
    p placement
    p knight.position
  end
end

class Knight
  attr_accessor :moves, :children, :position, :parent

  def initialize(position)
    @moves = [[2, 1], [1, 2], [-1, 2], [-2, 1], [-2, -1], [-1, -2], [1, -2], [2, -1]]
    @parent = nil
    @children = []
    @position = position
  end
end

def knight_moves(start_point, end_point)
  knight = Knight.new(start_point)
  board = Board.new
  board.create_children(knight, end_point)
  #p knight
  board.build_tree(knight)
end

knight_moves([0, 0], [5, 4])
