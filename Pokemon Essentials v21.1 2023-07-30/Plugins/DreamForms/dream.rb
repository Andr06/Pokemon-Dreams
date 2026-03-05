class Battle
    alias form_change_on_terrain pbStartTerrain
    def pbStartTerrain(user, newTerrain, fixedDuration = true)
        form_change_on_terrain(user, newTerrain, fixedDuration)
        allBattlers.each do |b|
            next unless @field.terrain == :Dreamy
            next unless b.isSpecies?(:TORTERRA)
            next unless b.hasItem?(:DREAMCATCHER)
            next if b.form == 1
            b.pbChangeForm(1, _INTL("{1} transformed!", b.pbThis))
        end
    end
end