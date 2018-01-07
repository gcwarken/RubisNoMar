#!/usr/bin/env ruby
$LOAD_PATH << '.'
# require all files in current folder
Dir["./*.rb"].each { |file| require file unless file == "./BatalhaNaval.rb" }

# Type Board
Board = Struct.new(:Size)

gameBoard = Board.new(15)

# Ship Types
mine_type = 1
sub_type  = 2
ship_type = 3

# Type Point
Point = Struct.new(:posX, :posY)

# Type Ship
Ship = Struct.new(:Point, :ShipType, :Direction) do

  def
  end

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
