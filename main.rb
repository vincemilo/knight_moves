class Board
  attr_accessor :tiles

  def initialize
    @tiles = (0..7).to_a.repeated_permutation(2).to_a
  end
end

class Knight
  attr_accessor :moves, :moves2, :children, :position

  def initialize(position)
    @moves = [[2, 1], [1, 2], [-1, 2], [-2, 1], [-2, -1], [-1, -2], [1, -2], [2, -1]]
    @moves2 = Hash[@moves.collect do |e|
      neg = [e[0], e[1] * -1]
      [e, neg.reverse]
    end]
    @position = position
  end
end

def valid_move?(x, y, history)
  x.negative? || y.negative? || x > 7 || y > 7 || history.include?([x, y]) ? false : true
end

def knight_moves(start_point, end_point, history = [])
  history.push(start_point)
  valid_moves = []
  knight = Knight.new(start_point)
  #board = Board.new
  # placement = board.tiles.map { |e| e == knight.position ? 'K' : e }
  # p placement
  # p knight.position
  queue = knight.moves2
  queue.each do |e|
    x = knight.position[0] + e[1][0]
    y = knight.position[1] + e[1][1]
    # p [x, y]
    # p end_point
    if end_point == [x, y]
      history.push([e])
    # puts "You made it in #{history.length - 1} move(s)! Here's your path:"
    elsif valid_move?(x, y, history)
      valid_moves.push(e)
    end
  end
  p valid_moves
  # p history
end

def find_shortest_path(start_point, end_point)
end

knight_moves([1, 2], [3, 3])
