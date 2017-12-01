module NavalBattle
  class ShipInterface
    def destroy_pos(position)
      raise NotImplementedError "Should be implemented in child class."
    end

    def is_destroyed()
        raise NotImplementedError "Should be implemented in child class."
    end
  end
end
