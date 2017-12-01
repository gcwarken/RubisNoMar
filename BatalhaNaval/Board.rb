module NavalBattle
  class Board
    @board_size
    @board_matrix
    attr_reader :size

    # constructor
    def initialize(size)
      @board_size = size
      @board_matrix = Array.new(@board_size, Array.new(@board_size, false))
    end

    def is_occupied(position_x, position_y)
      @board_matrix[position_x][position_y]
    end
  end
end
