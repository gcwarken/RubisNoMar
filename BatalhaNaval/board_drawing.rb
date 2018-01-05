module NavalBattle
  def consoleFullBoardDraw(board)
    (0...board.size).each do |i|
      str = ""
      (0...board.size).each do |j|
        if board.is_occupied(i, j)
          str += "\e[47m#{"  "}\e[0m"
        else
          str += "\e[44m#{"  "}\e[0m"
        end
      end
      puts str
    end
  end

  module_function :consoleFullBoardDraw
end
