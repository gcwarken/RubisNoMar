module NavalBattle
  class Board
    @size
    @board_matrix
    attr_reader :size

    # constructor
    def initialize(size)
      @size = size
      @board_matrix = Array.new(10) { Array.new(10, false) }
    end

    def is_occupied(position_x, position_y)
      @board_matrix[position_x][position_y]
    end

    def change_occupation(position_x, position_y, occupation)
      @board_matrix[position_x][position_y] = occupation
    end
  end
end
