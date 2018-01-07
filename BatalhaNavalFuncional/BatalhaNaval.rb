#!/usr/bin/env ruby
$LOAD_PATH << '.'

# Board Position Types
brdWater = 0
brdShip  = 1
brdWreck = 2
<<<<<<< HEAD

$board_size = 15
=======
board_size = 15
>>>>>>> cbf93bd136ffd749a042e6077e1bb9440bf77962

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
<<<<<<< HEAD
  if board[0][1] > 0
    false
=======
  if board[position.posX][position.posY] > 0
    return false
>>>>>>> cbf93bd136ffd749a042e6077e1bb9440bf77962
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
<<<<<<< HEAD
  board[0][1] = brdShip

  next_pos = position

  if hor_oriented
    next_pos[0] = next_pos[0]+ 1
  else
    next_pos[1] = next_pos[1] + 1
  end

  addShip(board, ship-1, hor_oriented, next_pos) unless ship == 1
=======
  board[position.posX][position.posY] = brdShip
  next_pos = position
  hor_oriented ? next_pos.posX += 1 : next_pos.posY += 1
  addShip(board, ship - 1, hor_oriented, next_pos) unless ship == 1
>>>>>>> cbf93bd136ffd749a042e6077e1bb9440bf77962
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
<<<<<<< HEAD

  puts "a ship was placed. Ships remaining:\n"
  puts ships.inspect

=======
>>>>>>> cbf93bd136ffd749a042e6077e1bb9440bf77962
  fillBoard(board, ships) unless not ships.any?
end

def checkGameOver(board, ship)
  # return true if game over
<<<<<<< HEAD
  not board.grep(ship).any?
end

puts "those are the ships\n"
puts ships.inspect

fillBoard(game_board, ships)

=======
  not board.grep(brdShip).any?
end

>>>>>>> cbf93bd136ffd749a042e6077e1bb9440bf77962
puts "Game set, prepare for battle!\n"

puts game_board.inspect

# game loop
<<<<<<< HEAD
while not checkGameOver(game_board, brdShip)

=======
end_game = false
while not end_game
  (1..2).each do |player|
    if not end_game
      puts "\nTurno do player #{player}..."

      # gets player input
      choice = -1
      while choice != 1 and choice != 2
        puts "\nJogar(1) Desistir(2):"
        choice = gets.chomp
        choice = choice.to_i

        if choice == 2
          end_game = true
          break
        end
      end

      # game hasn't been quit
      if not end_game
        puts "\nEntre com coordenada x:"
        x = gets.chomp
        puts "\nEntre com coordenada y:"
        y = gets.chomp
        pos = Array.new([x.to_i, y.to_i])
        hit = game.new_turn(pos, player)
        if hit
          puts "\nACERTOU!\n"
        else
          puts "\nERRRROW!\n"
        end
      end

      # checks for win condition
      if player == 1
        if game.is_all_destroyed?(2)
          puts "\nPLAYER 1 GANHOU!\n"
          end_game = true
        end
      else
        if game.is_all_destroyed?(1)
          puts "\nPLAYER 2 GANHOU!\n"
          end_game = true
        end
      end
    end
  end
>>>>>>> cbf93bd136ffd749a042e6077e1bb9440bf77962
end
