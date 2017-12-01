$LOAD_PATH << '.'
require './Board.rb'
require './ShipInterface.rb'

module NavalBattle
  class GameControl
    @board
    @p1_ships
    @p2_ships

    def initialize()
      @board = nil
      @p1_ships = Array.new()
      @p2_ships = Array.new()
    end

    def new_game(board_size)
      @board = NavalBattle::Board.new(board_size)
      @p1_ships = Array.new()
      @p2_ships = Array.new()
    end

    def add_ship(ship, player)
      if player != 1 and player != 2
        raise "Invalid player! Must be 1 or 2."
      end

      ship_added = false

      if positions_inside_board?(ship.positions()) and
          positions_are_available?(ship.positions())
        ship_added = true
        occupy_board(ship.positions())
        if player == 1
          p1_ships.push(ship)
        else
          p2_ships.push(ship)
        end
      end

      return ship_added
    end

    def new_turn(position, player)
      hit = false
      target_ships = nil
      if player == 1
        target_ships = @p2_ships
      elsif player == 2
        target_ships = @p1_ships
      else player != 1 and player != 2
        raise "Invalid player! Must be 1 or 2."
      end

      for ship in target_ships
        hit = ship.destroy_position(position)
        if hit
          break
        end
      end

      return hit
    end

    def is_all_destroyed?(player)
      ships = nil

      if player == 1
        ships = @p1_ships
      elsif player ==2
        ships = @p2_ships
      else player != 1 and player != 2
        raise "Invalid player! Must be 1 or 2."
      end

      destroyed = true
      for ship in ships
        if ship.is_destroyed? == false
          destroyed = false
          break
        end
      end

      return destroyed
    end

    private

    def positions_inside_board?(positions)
      is_inside = true
      for pos in positions
        if pos[0] < 0 or pos[0] > board.size
          is_inside = false
          break
        elsif pos[1] < 0 or pos[1] > board.size
          is_inside = false
          break
        end
      end
    end

    def positions_are_available?(positions)
      are_available = true
      for pos in positions
        if @board.is_occupied(pos[0], pos[1])
          are_available = false
          break
        end
      end

      return are_available
    end

    def occupy_board(positions)
      for pos in positions
        @board.change_occupation(pos[0], pos[1], true)
      end
    end
  end
end
