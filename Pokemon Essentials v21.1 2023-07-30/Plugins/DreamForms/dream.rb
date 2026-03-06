class Battle
  alias form_change_on_terrain pbStartTerrain
  def pbStartTerrain(user, newTerrain, fixedDuration = true)
    oldTerrain = @field.terrain
    form_change_on_terrain(user, newTerrain, fixedDuration)
    return if oldTerrain == @field.terrain
    allBattlers.each do |b|
      next unless b.isSpecies?(:TORTERRA)
      next unless b.hasActiveItem?(:DREAMCATCHER)
      case @field.terrain
      when :Dreamy
        next if b.form == 1
        b.pbChangeForm(1, _INTL("{1}'s dreams came true!", b.pbThis))
      end
    end
  end
      
  alias form_change_end_terrain pbEOREndTerrain
  def pbEOREndTerrain
    form_change_end_terrain
    return unless @field.terrain == :None
    allBattlers.each do |b|
      next unless b.isSpecies?(:TORTERRA)
      next unless b.hasActiveItem?(:DREAMCATCHER)
      next if b.form == 0
      b.pbChangeForm(0, _INTL("{1} stopped dreaming!", b.pbThis))
    end
  end
      
end

MultipleForms.register(:TORTERRA, {
  "getFormOnLeavingBattle" => proc { |pkmn, battle, usedInBattle, endBattle|
    next 0
  }
})

###script by wrigty12