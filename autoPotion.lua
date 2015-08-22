--[[ Auto Potion by DD13Scripts]]--
--[[ Will prioritise the use of Health potion and Mana potion over Crystal Flask.
version
    1.0 ]]--

function OnLoad()
apCfg = scriptConfig("Auto Potion", "AutoPotion")
apCfg:addParam("usePotion", "Auto Potion", SCRIPT_PARAM_ONOFF, true)
PrintChat("Auto Potion by --DD13Scripts-- has loaded")
end

function OnTick()
    usePotion()
end

function usePotion() -- Auto Potions
if not myHero.dead then -- Check hero alive
    if myHero.health < myHero.maxHealth * 0.70 then -- Hero less than 70% health.
        for slot = ITEM_1, ITEM_7 do -- Scan items.
            if myHero:GetSpellData(slot).name == "RegenerationPotion" then --if Health potion in inventory.
                if buffCheck("RegenerationPotion") == false then --Check if potion currently working.
                    CastSpell(slot) --Use potion.
                end
            end
        end
        for slot = ITEM_1, ITEM_7 do
            if myHero:GetSpellData(slot).name == "ItemMiniRegenPotion" then
                if buffCheck("ItemMiniRegenPotion") == false then
                    CastSpell(slot)
                end
            end
        end
        for slot = ITEM_1, ITEM_7 do
            if myHero:GetSpellData(slot).name == "ItemCrystalFlask" and myHero:CanUseSpell(slot) then
                if buffCheck("ItemCrystalFlask") == false then
                    CastSpell(slot)
                end
            end
        end
    end
    if myHero.mana < myHero.maxMana * 0.40 then -- If mana less than 40%.
        for slot = ITEM_1, ITEM_7 do
            if myHero:GetSpellData(slot).name == "FlaskOfCrystalWater" then
                if buffCheck("FlaskOfCrystalWater") == false then
                    CastSpell(slot)
                end
            end
        end
        for slot = ITEM_1, ITEM_7 do
            if myHero:GetSpellData(slot).name == "ItemCrystalFlask" and myHero:CanUseSpell(slot) then -- CanUseSpell to check if flask has stacks for use.
                if buffCheck("ItemCrystalFlask") == false then
                    CastSpell(slot)
                end
            end
        end
    end
end
end

function buffCheck(buffName) --Check for potion buff passing string as parameter.
    for i = 1, myHero.buffCount, 1 do --Iterator to scan each buff on hero
        local buff = myHero:getBuff(i) --Variable to store the current buff data.
        if buff.valid then
            if buff.name == buffName then -- If names match potion buff is already active.
                return true
            end
        end
    end

    return false
end
