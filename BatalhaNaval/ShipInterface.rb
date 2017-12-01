module NavalBattle
  class ShipInterface
    def initialize(size, position, horizontal_oriented)
      raise NotImplementedError "Should be implemented in child class."
    end

    def positions()
      raise NotImplementedError "Should be implemented in child class."
    end

    def destroyed_segments()
      raise NotImplementedError "Should be implemented in child class."
    end

    def destroy_position(position)
      raise NotImplementedError "Should be implemented in child class."
    end

    def is_destroyed?(position = nil)
        raise NotImplementedError "Should be implemented in child class."
    end

    def is_in_position?(position)
      raise NotImplementedError "Should be implemented in child class."
    end
  end
end
