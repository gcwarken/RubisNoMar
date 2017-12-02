#!/usr/bin/env ruby
$LOAD_PATH << '.'
# require all files in current folder
Dir["./*.rb"].each { |file| require file unless file == "./BatalhaNaval.rb" }

module NavalBattle
  mine_size = 1
  sub_size  = 2
  ship_size = 3

  print "Select board size: "
  board_size = gets.chomp.to_i

  ships = Array.new()

  print "How many mines of size #{mine_size}?\t"
  mine_quant = gets.chomp.to_i
  for i in 0..mine_quant - 1
    ships.push(mine_size)
  end

  print "How many submarines of size #{sub_size}?\t"
  submarine_quant = gets.chomp.to_i
  for i in 0..submarine_quant - 1
    ships.push(sub_size)
  end

  print "How many ships of size #{ship_size}?\t"
  ship_quant = gets.chomp.to_i
  for i in 0..ship_quant - 1
    ships.push(ship_size)
  end

  game = GameControl.new()
  game.new_game(board_size)

  # add ships to board
  for curr_player in 1..2
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
    for player in 1..2

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
end
