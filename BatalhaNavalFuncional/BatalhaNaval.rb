#!/usr/bin/env ruby
$LOAD_PATH << '.'

# Board Position Types
brdWater = 0
brdShip  = 1
brdWreck = 2

$board_size = 15

game_board = Array.new($board_size) { Array.new($board_size, brdWater) }

# Ship Types
mine_type  = 1
mine_quant = 5

sub_type   = 2
sub_quant  = 4

ship_type  = 3
ship_quant = 3

ships = Array.new

def insert_ships(type, quant, shipList)
  shipList.push(type) unless quant == 0
  insert_ships(type, quant-1, shipList) unless quant == 0
end

insert_ships(mine_type, mine_quant, ships)
insert_ships(sub_type, sub_quant, ships)
insert_ships(ship_type, ship_quant, ships)

def checkIfBoardFree(board, ship, hor_oriented, position)
  if board[0][1] > 0
    false
  else
    next_pos = position

    if hor_oriented
      next_pos[0]= next_pos[0]+ 1
    else
      next_pos[1] = next_pos[1] + 1
    end

    checkIfBoardFree(board, ship-1, hor_oriented, next_pos) unless ship == 1
  end
end

def addShip(board, ship, hor_oriented, position)
  board[0][1] = brdShip

  next_pos = position

  if hor_oriented
    next_pos[0] = next_pos[0]+ 1
  else
    next_pos[1] = next_pos[1] + 1
  end

  addShip(board, ship-1, hor_oriented, next_pos) unless ship == 1
end

def fillBoard(board, ships)
  curr_ship = ships.pop

  board_free = false
  while not board_free
    horizontal_oriented = [true, false].sample
    if horizontal_oriented
      ship_position = Array.new([rand($board_size - curr_ship), rand($board_size)])
    else
      ship_position = Array.new([rand($board_size), rand($board_size - curr_ship)])
    end
    board_free = checkIfBoardFree(board, curr_ship, horizontal_oriented, ship_position)
  end

  addShip(board, curr_ship, horizontal_oriented, ship_position)

  puts "a ship was placed. Ships remaining:\n"
  puts ships.inspect

  fillBoard(board, ships) unless not ships.any?
end

def checkGameOver(board, ship)
  # return true if game over
  not board.grep(ship).any?
end

puts "those are the ships\n"
puts ships.inspect

fillBoard(game_board, ships)

puts "Game set, prepare for battle!\n"

puts game_board.inspect

# game loop
while not checkGameOver(game_board, brdShip)

end
