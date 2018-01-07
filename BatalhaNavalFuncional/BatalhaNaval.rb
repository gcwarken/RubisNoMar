#!/usr/bin/env ruby
$LOAD_PATH << '.'
# require all files in current folder
Dir["./*.rb"].each { |file| require file unless file == "./BatalhaNaval.rb" }

# Board Position Types
brdWater = 0
brdShip  = 1
brdWreck = 2

board_size = 15

game_board = Array.new(board_size) { Array.new(board_size, brdWater) }

# Type Point
Point = Struct.new(:posX, :posY)

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
  if board[position.posX][position.posY] > 0
    return false

  else
    next_pos = position

    if hor_oriented
      next_pos.posX = next_pos.posX + 1
    else
      next_pos.posY = next_pos.posY + 1
    end

    checkIfBoardFree(board, ship-1, hor_oriented, next_pos) unless ship == 1
  end
end

def addShip(board, ship, hor_oriented, position)
  board[position.posX][position.posY] = brdShip

  next_pos = position

  if hor_oriented
    next_pos.posX = next_pos.posX + 1
  else
    next_pos.posY = next_pos.posY + 1
  end

  addShip(board, ship-1, hor_oriented, next_pos) unless ship == 1
end

def fillBoard(board, ships)
  curr_ship = ships.pop

  board_free = false
  while not board_free
    horizontal_oriented = [true, false].sample
    if hor_oriented
      ship_position = Point.new([rand(board_size - ship), rand(board_size)])
    else
      ship_position = Point.new([rand(board_size), rand(board_size - ship)])
    end
    board_free = checkIfBoardFree(board, curr_ship, horizontal_oriented, ship_position)
  end

  addShip(board, curr_ship, horizontal_oriented, ship_position)

  fillBoard(board, ships) unless not ships.any?
end


game = GameControl.new
game.new_game(board_size)

# add ships to board
(1..2).each do |curr_player|
  ships.each do |ship_size|
    begin
      horizontal_oriented = [true, false].sample
      if horizontal_oriented
        ship_position = Array.new([rand(board_size - ship_size), rand(board_size)])
      else
        ship_position = Array.new([rand(board_size), rand(board_size - ship_size)])
      end

      curr_ship = Ship.new(ship_size, ship_position, horizontal_oriented)
    end while not game.add_ship(curr_ship, curr_player)

    puts "ship of size #{ship_size} added to player #{curr_player}!"
  end
end

game.draw_board(NavalBattle.method(:consoleFullBoardDraw))

# game loop
end_game = false
while not end_game
  (1..2).each do |player|
    if not end_game
      puts "\nTurno do player #{player}..."

      # Recebe input do jogador.
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

      # Não houve desistência.
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

      # Verifica vitorioso.
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
end
