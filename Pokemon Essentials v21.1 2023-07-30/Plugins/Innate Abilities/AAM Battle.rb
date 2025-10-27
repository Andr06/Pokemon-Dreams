class Battle

  alias aam_pbCanSwitch? pbCanSwitch?
  def pbCanSwitch?(idxBattler, idxParty = -1, partyScene = nil)
    $aam_trapping=false

    aam_switch =  aam_pbCanSwitch?(idxBattler, idxParty, partyScene)

    $aam_trapping=true
    battler = @battlers[idxBattler]
    # Trapping abilities for All Abilities Mutation
    allOtherSideBattlers(idxBattler).each do |b|
      next if !b.abilityActive?
      if Battle::AbilityEffects.triggerTrappingByTarget(b.ability, battler, b, self)
		$aamName = b.abilityName
        partyScene&.pbDisplay(_INTL("{1}'s {2} prevents switching!",
                                    b.pbThis, $aamName))
        return false
      end
    end
    return aam_switch
  end

  alias aam_pbCanRun? pbCanRun?
  def pbCanRun?(idxBattler)
    $aam_trapping=true
    return aam_pbCanRun?(idxBattler)
  end  
  
  alias_method :original_pbShowAbilitySplash, :pbShowAbilitySplash
  def pbShowAbilitySplash(battler, delay = false, logTrigger = true)
  puts "[pbShowAbilitySplash] Battler ability: #{battler.abilityName}"
  if battler.ability
    puts "[pbShowAbilitySplash] Setting $aamName to #{battler.abilityName}"
    $aamName = battler.abilityName
  end
  puts "[pbShowAbilitySplash] $aamName is now: #{$aamName}, $aamName2 is: #{$aamName2}"

  original_pbShowAbilitySplash(battler, delay, logTrigger)
  puts "[pbShowAbilitySplash] After original call: $aamName is: #{$aamName}, $aamName2 is: #{$aamName2}"
  end
end
  
  
