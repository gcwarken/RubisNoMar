#!/usr/bin/env ruby
$LOAD_PATH << '.'
# require all files in current folder
Dir["./*.rb"].each { |file| require file unless file == "./BatalhaNaval.rb"}

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
  for i in 0..mine_quant - 1
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

        ship_position = Array.new([rand(board_size), rand(board_size)])
        curr_ship = Ship.new(ship_size, ship_position, horizontal_oriented)
      end while game.add_ship(curr_ship, curr_player)

      #puts "ship of size #{ship_size} added to player #{curr_player}!"
    end
  end


end
