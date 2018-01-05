$LOAD_PATH << '.'
require './ShipInterface.rb'

module NavalBattle
  class Ship < NavalBattle::ShipInterface
    @size
    @position
    @positions
    @destroyed_segments
    @horizontal_oriented

    def initialize(size, position, horizontal_oriented)
      if size < 1
        raise "Argument size is invalid!"
      end
      @size = size

      if not position.respond_to?(:[])
        raise "Argument position is invalid! No [] operator!"
      elsif not position.respond_to?(:size)
        raise "Argument position is invalid! No size method!"
      elsif position.size != 2
        raise "Argument position is invalid! position.size != 2"
      end
      @position = position

      if horizontal_oriented != true and horizontal_oriented != false
        raise "Argument horizontal_oriented is invalid!"
      end
      @horizontal_oriented = horizontal_oriented

      @destroyed_segments = Array.new(@size, false)

      @positions = Array.new(@size)
      @positions[0] = position
      if horizontal_oriented == true
        (1...@size).each do |n|
          @positions[n] = [position[0] + n, position[1]]
        end
      else
        (1...@size).each do |n|
          @positions[n] = [position[0], position[1] + n]
        end
      end
    end

    def positions
      Array.new(@positions)
    end

    def destroyed_segments
      Array.new(@destroyed_segments)
    end

    def destroy_position(position)
      was_destroyed = false
      if is_in_position?(position)
        i = segment_index(position)
        @destroyed_segments[i] = true
        was_destroyed = true
      end

      return was_destroyed
    end

    def is_destroyed?(position = nil)
      if position == nil  # Checks if is fully destroyed.
        @destroyed_segments.all?
      elsif is_in_position?(position)  # Checks if position is destroyed.
        @destroyed_segments[segment_index(position)]
      end
    end

    def is_in_position?(position)
      in_pos = false

      if @horizontal_oriented == true and position[1] == @position[1]
        # Goes from left to right.
        if position[0] >= @position[0] and position[0] < @position[0] + @size
          in_pos = true
        end
      elsif @horizontal_oriented == false and position[0] == @position[0]
        # Goes from bottom to top.
        if position[1] >= @position[1] and position[1] < @position[1] + @size
          in_pos = true
        end
      end

      return in_pos
    end

    private

    def segment_index(position)
      i = -1

      if is_in_position?(position)
        if @horizontal_oriented == true
          i = position[0] - @position[0]
        else
          i = position[1] - @position[1]
        end
      end

      return i
    end
  end
end
