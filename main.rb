class Board
  def initialize
    @tiles = Array.new(8) { Array.new(8) }
  end
end

class Knight
  def initialize
    @moves = [[2, 1], [1, 2], [-1, 2], [-2, 1], [-2, -1], [-1, -2], [1, -2], [2, -1]]
  end
end

board = Board.new
p board
knight = Knight.new
p knight
