module NavalBattle
  def consoleFullBoardDraw(board)
    (0...board.size).each do |i|
      str = ""
      (0...board.size).each do |j|
        str += board.is_occupied(i, j) ? "\e[47m#{"  "}\e[0m" : "\e[44m#{"  "}\e[0m"
      end
      puts str
    end
  end

  module_function :consoleFullBoardDraw
end
