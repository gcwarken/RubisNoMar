#!/usr/bin/env ruby
$LOAD_PATH << '.'

# Board Position Types
$brdWater = 0
$brdShip  = 1
$brdWreck = 2

$board_size = 15

game_board = Array.new($board_size) { Array.new($board_size, $brdWater) }

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
  if board[position[0]][position[1]] > 0
    false
  else
    if ship == 1
      true
    else
      next_pos = position

      if hor_oriented
        next_pos[0] = next_pos[0] + 1
      else
        next_pos[1] = next_pos[1] + 1
      end

      checkIfBoardFree(board, ship-1, hor_oriented, next_pos)
    end
  end
end

def addShip(board, ship, hor_oriented, position)
  board[position[0]][position[1]] = $brdShip

  next_pos = position

  if hor_oriented
    next_pos[0] = next_pos[0] + 1
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

def hitTarget(board, target)
  if board[target[0]][target[1]] == $brdWater
    puts "Água!\n"
  end

  if board[target[0]][target[1]] == $brdWreck
    puts "Já acertou aí antes!"
  end

  if board[target[0]][target[1]] == $brdShip
    board[target[0]][target[1]] = $brdWreck
    puts "Acertou!"
  end
end

def checkGameOver(board)
  # return true if game over
  has_any = false
  board.each do |a|
    has_any = a.grep($brdShip).any?
  end

  not has_any
end

puts "those are the ships\n"
puts ships.inspect

fillBoard(game_board, ships)

puts "Game set, prepare for battle!\n"

puts game_board[0].inspect
puts game_board[1].inspect
puts game_board[2].inspect
puts game_board[3].inspect
puts game_board[4].inspect
puts game_board[5].inspect
puts game_board[6].inspect
puts game_board[7].inspect
puts game_board[8].inspect
puts game_board[9].inspect
puts game_board[10].inspect
puts game_board[11].inspect
puts game_board[12].inspect
puts game_board[13].inspect
puts game_board[14].inspect
puts "\n"

# game loop
while not checkGameOver(game_board, $brdShip)
  x = -1
  y = -1

  while x > $board_size or x < 0
    puts "\nEntre com coordenada x:"
    x = gets.chomp.to_i
  end

  while y > $board_size or y < 0
    puts "\nEntre com coordenada y:"
    y = gets.chomp.to_i
  end

  target = [x, y]
  hitTarget(game_board, target)
end

puts "Vitória!"
