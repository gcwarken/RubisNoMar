#!/usr/bin/env ruby
$LOAD_PATH << '.'

# Board Position Types
BRD_WATER = 0
BRD_SHIP  = 1
BRD_WRECK = 2

# Other constants 

BOARD_SIZE = 15
SHIP_SIZE = 3
SUB_SIZE = 2
MINE_SIZE = 1
SHIP_COUNT = 3
SUB_COUNT = 4
MINE_COUNT = 5

game_board = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE, BRD_WATER) }

# Struct for water object instantiating
WaterObject = Struct.new(:count, :size)


# Create a list with all objects to be put on the board
init_water_objects = lambda do |count, size, a_list|
  count.times { a_list << size }
  a_list
end

# Define specific water object initialization functions with currying
init_ships = init_water_objects.curry[SHIP_COUNT][SHIP_SIZE]
init_subs = init_water_objects.curry[SUB_COUNT][SUB_SIZE]
init_mines = init_water_objects.curry[MINE_COUNT][MINE_SIZE]

def init_water_objects_list(fn1, fn2, fn3)
  lst = Array.new
  fn1[lst.dup].concat(fn2[lst.dup], fn3[lst.dup])
end

def checkIfBoardFree(board, ship, hor_oriented, position)
  if board[position[0]][position[1]] > 0
    false
  else
    if ship == 1
      true
    else
      next_pos = position
      hor_oriented ? next_pos[0] += 1 : next_pos[1] += 1
      checkIfBoardFree(board, ship-1, hor_oriented, next_pos)
    end
  end
end

def addShip(board, ship, hor_oriented, position)
  board[position[0]][position[1]] = BRD_SHIP
  next_pos = position
  hor_oriented ? next_pos[0] += 1 : next_pos[1] += 1
  addShip(board, ship-1, hor_oriented, next_pos) unless ship == 1
end

def fillBoard(board, ships)
  curr_ship = ships.pop
  board_free = false
  while not board_free
    horizontal_oriented = [true, false].sample
    if horizontal_oriented
      ship_position = Array.new([rand(BOARD_SIZE - curr_ship), rand(BOARD_SIZE)])
    else
      ship_position = Array.new([rand(BOARD_SIZE), rand(BOARD_SIZE - curr_ship)])
    end
    board_free = checkIfBoardFree(board, curr_ship, horizontal_oriented, ship_position)
  end

  addShip(board, curr_ship, horizontal_oriented, ship_position)

  puts "a ship was placed. Ships remaining:\n"
  puts ships.inspect

  fillBoard(board, ships) unless not ships.any?
end

def hitTarget(board, target)
  if board[target[0]][target[1]] == BRD_WATER
    puts "Água!\n"
  end

  if board[target[0]][target[1]] == BRD_WRECK
    puts "Já acertou aí antes!"
  end

  if board[target[0]][target[1]] == BRD_SHIP
    board[target[0]][target[1]] = BRD_WRECK
    puts "Acertou!"
  end
end

def checkGameOver(board)
  # return true if game over
  not board.flatten.grep(BRD_SHIP).any?
end


def test_init(fn1, fn2, fn3)
  a = init_water_objects_list(fn1, fn2, fn3)
  p a.inspect
  p a.length == (SHIP_COUNT + SUB_COUNT + MINE_COUNT)
end

water_objects = init_water_objects_list(init_ships, init_subs, init_mines)

fillBoard(game_board.dup, water_objects.dup)

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
while not checkGameOver(game_board)
  x = -1
  y = -1

  while x > BOARD_SIZE or x < 0
    puts "\nEntre com coordenada x:"
    x = gets.chomp.to_i
  end

  while y > BOARD_SIZE or y < 0
    puts "\nEntre com coordenada y:"
    y = gets.chomp.to_i
  end

  target = [x, y]
  hitTarget(game_board, target)
end

puts "Vitória!"
