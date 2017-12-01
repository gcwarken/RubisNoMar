module NavalBattle
  class Board
    @size
    @board_matrix
    @default_board_size
    attr_reader :size

    # constructor
    def initialize(size = nil)
      @default_board_size = 15
      if size.nil?
        @size = @default_board_size
      else
        @size = size
      end
      @board_matrix = Array.new(@size) { Array.new(@size, false) }
    end

    def is_occupied(position_x, position_y)
      @board_matrix[position_x][position_y]
    end

    def change_occupation(position_x, position_y, occupation)
      @board_matrix[position_x][position_y] = occupation
    end

    def draw()
      for i in 0..@size-1
        str = ""
        for j in 0..@size-1
          if @board_matrix[i][j]
            str += "\e[47m#{"  "}\e[0m"
          else
            str += "\e[44m#{"  "}\e[0m"
          end
        end
        puts str
      end
    end
  end
end
