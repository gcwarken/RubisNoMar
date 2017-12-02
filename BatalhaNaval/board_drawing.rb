module NavalBattle
  def consoleFullBoardDraw(board)
    for i in 0..board.size-1
      str = ""
      for j in 0..board.size-1
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
