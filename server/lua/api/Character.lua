local Interface = require("illarion-api.server.lua.interface")
local DirectionUtils = require("illarion-api.server.lua.lib.directionUtils")

Character = {
    -- body_pos
    backpack = 0,
    head = 1,
    neck = 2,
    breast = 3,
    hands = 4,
    left_tool = 5,
    right_tool = 6,
    finger_left_hand = 7,
    finger_right_hand = 8,
    legs = 9,
    feet = 10,
    coat = 11,
    belt_pos_1 = 12,
    belt_pos_2 = 13,
    belt_pos_3 = 14,
    belt_pos_4 = 15,
    belt_pos_5 = 16,
    belt_pos_6 = 17,

    -- magic_flags
    mage = 0,
    priest = 1,
    bard = 2,
    druid = 3,

    -- talk_type
    say = 0,
    whisper = 1,
    yell = 2,

    -- direction
    dir_north = 0,
    dir_northeast = 1,
    dir_east = 2,
    dir_southeast = 3,
    dir_south = 4,
    dir_southwest = 5,
    dir_west = 6,
    dir_northwest = 7,
    dir_up = 8,
    dir_down = 9,

    -- character_type
    player = 0,
    monster = 1,
    npc = 2,

    -- sex_type
    male = 0,
    female = 1,

    -- face_to
    north = 0,
    northeast = 1,
    east = 2,
    southeast = 3,
    south = 4,
    southwest = 5,
    west = 6,
    northwest = 7,

    -- inform_type
    lowPriority = 100,
    mediumPriority = 101,
    highPriority = 102,
}

local CharacterGetters = {
    lastSpokenText = function(user)
        -- TODO remember to set last spoken text once chat is implemented
        return Interface.Chat.GetLastSpokenText(user)
    end,
    effects = function(user) return {
        addEffect = function(self, effect)
            return Interface.LTE.AddEffect(user, effect)
        end,
        find = function(self, idOrName)
            return Interface.LTE.FindEffect(user, idOrName)
        end,
        removeEffect = function(self, idOrNameOrEffect)
            local effect = idOrNameOrEffect
            if type(idOrNameOrEffect) == "number" or type(idOrNameOrEffect) == "string" then
                effect = self:find(idOrNameOrEffect)
            end
            if not effect then
                return false
            end
            return Interface.LTE.RemoveEffect(user, effect)
        end
    } end,
    waypoints = function(user) return {
        addWaypoint = function(waypoint)
            print("waypoints.addWaypoint", waypoint) -- TODO Waypoints
        end,
        clear = function()
           print("waypoints.clear") -- TODO Waypoints
        end
    } end,
    pos = function(user)
        return user.SeleneEntity().Coordinate
    end,
    name = function(user) return user.SeleneEntity().Name end,
    id = function(user) return Interface.Player.GetID(user) end,
    activeLanguage = function(user) return Interface.Chat.GetLanguage(user) end,
    movepoints = function(user) return Interface.Movement.GetMovePoints(user) end,
    fightpoints = function(user) return Interface.Combat.GetFightPoints(user:GetFightPoints()) end,
    speed = function(user) return Interface.Movement.GetSpeed(user) end,
    isinvisible = function(user) return user.SeleneEntity():IsInvisible() end,
    attackmode = function(user) return Interface.Combat.IsInCombat(user) end,
}

local CharacterSetters = {
    activeLanguage = function(user, value)
        Interface.Chat.SetLanguage(user, value)
    end,
    movepoints = function(user, value)
         Interface.Movement.SetMovePoints(user, value)
    end,
    fightpoints = function(user, value)
        Interface.Combat.SetFightPoints(user, value)
    end,
    speed = function(user, value)
        Interface.Movement.SetSpeed(user, value)
    end,
    isinvisible = function(user, value)
        user.SeleneEntity():MakeInvisible()
    end
}

local CharacterMethods = {
    isNewPlayer = function(user)
        return Interface.Player.GetTotalOnlineTime(user) < 10 * 60 * 60
    end,
    pageGM = function(user, message)
        Interface.Player.PageGM(user, message)
    end,
    requestInputDialog = function(user, dialog)
        Interface.Dialog.RequestInput(user, dialog)
    end,
    requestMessageDialog = function(user, dialog)
        Interface.Dialog.ShowMessage(user, dialog)
    end,
    requestMerchantDialog = function(user, dialog)
        Interface.Dialog.ShowMerchant(user, dialog)
    end,
    requestSelectionDialog = function(user, dialog)
        Interface.Dialog.RequestSelection(user, dialog)
    end,
    requestCraftingDialog = function(user, dialog)
        Interface.Dialog.ShowCrafting(user, dialog)
    end,
    idleTime = function(user)
        return user.SelenePlayer.IdleTime
    end,
    sendBook = function(user, bookId)
        Interface.Dialog.ShowBook(user, bookId)
    end,
    updateAppearance = function(user)
        user.SeleneEntity():UpdateVisual()
    end,
    performAnimation = function(user, animId)
        print("performAnimation", animId)
    end,
    actionRunning = function(user)
        print("actionRunning")
        return false -- TODO Actions
    end,
    changeQualityAt = function(user, bodyPosition, amount)
        Interface.Inventory.ChangeQualityAt(user, bodyPosition, amount)
    end,
    isAdmin = function(user)
        return Interface.Player.IsAdmin(user)
    end,
    talk = function(user, mode, message, messageEnglish)
        Interface.Chat.Talk(user, mode, message, messageEnglish)
    end,
    sendCharDescription = function(user, charId, message)
        Interface.Dialog.ShowCharDescription(user, charId, message)
    end,
    startAction = function(user, duration, gfxId, gfxInterval, sfxId, sfxInterval)
        print("startAction", duration, gfxId, gfxInterval, sfxId, sfxInterval)
        -- TODO We need to get the current "entrypoint" here, i.e. the function the engine called directly that got us here
        -- TODO Play GFX and SFX
    end,
    abortAction = function(user)
        print("abortAction")
    end,
    successAction = function(user)
        print("completeAction")
    end,
    disturbAction = function(user, disturber)
        print("disturbAction")
    end,
    changeSource = function(user, item)
        print("changeSource")
    end,
    inform = function(user, message, messageEnglish, priority)
        Interface.Player.Inform(user, message, messageEnglish, priority)
    end,
    introduce = function(user)
        print("introduce")
    end,
    move = function(user, direction, activeMove)
        -- TODO ActiveMove??
        user.SeleneEntity():Move(direction)
    end,
    turn = function(user, direction)
        local seleneDirection = DirectionUtils.IllaToSelene(direction)
        if seleneDirection then
            user.SeleneEntity():SetFacing(seleneDirection)
        end
    end,
    getNextStepDir = function(user, position, outDir)
        -- Not used in scripts. Normally performs a pathfind and returns the first step to take, discarding the rest.
        print("getNextStepDir")
        return false, nil
    end,
    setRace = function(user, race)
        Interface.Character.SetRace(user, race)
    end,
    getRace = function(user)
        return Interface.Character.GetRace(user)
    end,
    getFaceTo = function(user)
        return DirectionUtils.SeleneToIlla(user.SeleneEntity().Facing) or Character.north
    end,
    getType = function(user)
        return Interface.Character.GetType(user)
    end,
    createItem = function(user, itemId, count, quality, data)
        return Interface.Inventory.CreateItem(user, itemId, count, quality, data)
    end,
    getLoot = function(user)
        print("getLoot")
        return {}
    end,
    increasePoisonValue = function(user, amount)
        user:setPoisonValue(user:getPoisonValue() + amount)
    end,
    getPoisonValue = function(user)
        return Interface.Attributes.GetPoisonValue(user)
    end,
    setPoisonValue = function(user, value)
        Interface.Attributes.SetPoisonValue(user, value)
    end,
    getMentalCapacity = function(user)
        return Interface.Attributes.GetMentalCapacity(user)
    end,
    setMentalCapacity = function(user, value)
        Interface.Attributes.SetMentalCapacity(user, value)
    end,
    increaseMentalCapacity = function(user, amount)
        user:setMentalCapacity(user:getMentalCapacity() + amount)
    end,
    setClippingActive = function(user, status)
        user.SeleneEntity():SetNoClip(status)
    end,
    getClippingActive = function(user)
        return user.SeleneEntity():IsNoClip()
    end,
    countItem = function(user, itemId)
        return Interface.Inventory.CountItem(user, itemId)
    end,
    countItemAt = function(user, slots, itemId, data)
        return Interface.Inventory.CountItemAt(user, slots, itemId, data)
    end,
    eraseItem = function(user, itemId, count, data)
        return Interface.Inventory.EraseItem(user, itemId, count, data)
    end,
    increaseAtPos = function(user, bodyPosition, count)
        Interface.Inventory.IncreaseAtPos(user, bodyPosition, count)
    end,
    swapAtPos = function(user, bodyPosition, itemId, quality)
        Interface.Inventory.SwapAtPos(user, bodyPosition, itemId, quality)
    end,
    createAtPos = function(user, bodyPosition, itemId, count)
        Interface.Inventory.CreateAtPos(user, bodyPosition, itemId, count)
    end,
    getItemAt = function(user)
        return Interface.Inventory.GetItemAt(user)
    end,
    getSkillName = function(user, skillId)
        return Interface.Skills.GetSkillName(skillId)
    end,
    getSkill = function(user, skillId)
        return Interface.Skills.GetSkill(user, skillId)
    end,
    getMinorSkill = function(user, skillId)
        return Interface.Skills.GetMinorSkill(user, skillId)
    end,
    increaseAttrib = function(user, attribute, value)
        if attribute == "sex" then
            return Interface.Attributes.GetSex(user)
        end

        local baseValue = Interface.Attributes.GetTransientBaseAttribute(user, attribute)
        local offset = Interface.Attributes.GetAttributeOffset(user, attribute)
        local prev = Interface.Attributes.ClampAttribute(user, attribute, baseValue + offset)
        local new = Interface.Attributes.ClampAttribute(user, attribute, prev + value)
        if prev ~= new then
            if baseValue == 0 then
                Interface.Attributes.SetBaseAttribute(user, attribute, new)
                Interface.Attributes.SetAttributeOffset(user, attribute, 0)
            else
                Interface.Attributes.SetAttributeOffset(user, attribute, new - baseValue)
            end
            Interface.Attributes.HandleAttributeChange(user, attribute)
        end
        return new
    end,
    setAttrib = function(user, attribute, value)
        local baseValue = Interface.Attributes.GetTransientBaseAttribute(user, attribute)
        local offset = Interface.Attributes.GetAttributeOffset(user, attribute)
        local prev = Interface.Attributes.ClampAttribute(user, attribute, baseValue + offset)
        local new = Interface.Attributes.ClampAttribute(user, attribute, value)
        if prev ~= new then
            if baseValue == 0 then
                Interface.Attributes.SetBaseAttribute(user, attribute, new)
                Interface.Attributes.SetAttributeOffset(user, attribute, 0)
            else
                Interface.Attributes.SetAttributeOffset(user, attribute, new - baseValue)
            end
            Interface.Attributes.HandleAttributeChange(user, attribute)
        end
    end,
    isBaseAttributeValid = function(user, attribute, value)
        return Interface.Attributes.IsBaseAttributeValid(user, attribute, value)
    end,
    getBaseAttributeSum = function(user)
        return Interface.Attributes.GetTransientBaseAttribute(user, "agility") + Interface.Attributes.GetTransientBaseAttribute(user, "constitution") +
               Interface.Attributes.GetTransientBaseAttribute(user, "dexterity") + Interface.Attributes.GetTransientBaseAttribute(user, "essence") +
               Interface.Attributes.GetTransientBaseAttribute(user, "intelligence") + Interface.Attributes.GetTransientBaseAttribute(user, "perception") +
               Interface.Attributes.GetTransientBaseAttribute(user, "strength") + Interface.Attributes.GetTransientBaseAttribute(user, "willpower")
    end,
    getMaxAttributePoints = function(user)
        return Interface.Attributes.GetMaxAttributePoints(user)
    end,
    saveBaseAttributes = function(user)
        -- This behaviour is insane and should not exist
        if getMaxAttributePoints(user) ~= getBaseAttributeSum(user) then
            Interface.Attributes.SetTransientBaseAttribute(user, "agility", Interface.Attributes.GetBaseAttribute(user, "agility"))
            Interface.Attributes.SetTransientBaseAttribute(user, "constitution", Interface.Attributes.GetBaseAttribute(user, "constitution"))
            Interface.Attributes.SetTransientBaseAttribute(user, "dexterity", Interface.Attributes.GetBaseAttribute(user, "dexterity"))
            Interface.Attributes.SetTransientBaseAttribute(user, "essence", Interface.Attributes.GetBaseAttribute(user, "essence"))
            Interface.Attributes.SetTransientBaseAttribute(user, "intelligence", Interface.Attributes.GetBaseAttribute(user, "intelligence"))
            Interface.Attributes.SetTransientBaseAttribute(user, "perception", Interface.Attributes.GetBaseAttribute(user, "perception"))
            Interface.Attributes.SetTransientBaseAttribute(user, "strength", Interface.Attributes.GetBaseAttribute(user, "strength"))
            Interface.Attributes.SetTransientBaseAttribute(user, "willpower", Interface.Attributes.GetBaseAttribute(user, "willpower"))
            return false
        end

        Interface.Attributes.SetBaseAttribute(user, "agility", Interface.Attributes.GetTransientBaseAttribute(user, "agility"))
        Interface.Attributes.SetBaseAttribute(user, "constitution", Interface.Attributes.GetTransientBaseAttribute(user, "constitution"))
        Interface.Attributes.SetBaseAttribute(user, "dexterity", Interface.Attributes.GetTransientBaseAttribute(user, "dexterity"))
        Interface.Attributes.SetBaseAttribute(user, "essence", Interface.Attributes.GetTransientBaseAttribute(user, "essence"))
        Interface.Attributes.SetBaseAttribute(user, "intelligence", Interface.Attributes.GetTransientBaseAttribute(user, "intelligence"))
        Interface.Attributes.SetBaseAttribute(user, "perception", Interface.Attributes.GetTransientBaseAttribute(user, "perception"))
        Interface.Attributes.SetBaseAttribute(user, "strength", Interface.Attributes.GetTransientBaseAttribute(user, "strength"))
        Interface.Attributes.SetBaseAttribute(user, "willpower", Interface.Attributes.GetTransientBaseAttribute(user, "willpower"))
        return true
    end,
    getBaseAttribute = function(user, attribute)
        return Interface.Attributes.GetTransientBaseAttribute(user, attribute)
    end,
    setBaseAttribute = function(user, attribute, value)
        if Interface.Attributes.isBaseAttributeValid(user, attribute, value) then
            local prev = Interface.Attributes.GetTransientBaseAttribute(user, attribute)
            local new = Interface.Attributes.ClampAttribute(user, attribute, value)
            if prev ~= new then
                Interface.Attributes.SetBaseAttribute(user, attribute, new)
                Interface.Attributes.HandleAttributeChange(user, attribute)
            end
            return true
        end
        return false
     end,
    increaseBaseAttribute = function(user, attribute, amount)
        local prev = Interface.Attributes.GetTransientBaseAttribute(user, attribute)
        local new = prev + amount
        if Interface.Attributes.isBaseAttributeValid(user, attribute, new) then
            new = Interface.Attributes.ClampAttribute(user, attribute, new)
            if prev ~= new then
                Interface.Attributes.SetBaseAttribute(user, attribute, new)
                Interface.Attributes.HandleAttributeChange(user, attribute)
            end
            return true
        end
        return false
    end,
    increaseSkill = function(user, skill, value)
        local prev = user:getSkill(skill)
        user:setSkill(skill, prev + value, user:getMinorSkill(skill))
    end,
    increaseMinorSkill = function(user, skillId, value)
        local prev = user:getMinorSkill(skillId)
        user:setSkill(skillId, user:getSkill(skillId), prev + value)
    end,
    setSkill = function(user, skillId, major, minor)
        Interface.Skills.SetSkill(user, skillId, major)
        Interface.Skills.SetSkillMinor(user, skillId, minor)
    end,
    setSkinColour = function(user, skinColor)
        Interface.Character.SetSkinColor(user, skinColor)
    end,
    getSkinColour = function(user)
        return Interface.Character.GetSkinColor(user)
    end,
    setHairColour = function(user, hairColor)
        Interface.Character.SetHairColor(user, hairColor)
    end,
    getHairColour = function(user)
        return Interface.Character.GetHairColor(user)
    end,
    setHair = function(user, hairId)
        Interface.Character.SetHair(user, hairId)
    end,
    getHair = function(user)
        return Interface.Character.GetHair(user)
    end,
    setBeard = function(user, beardId)
        Interface.Character.SetBeard(user, beardId)
    end,
    getBeard = function(user)
        return Interface.Character.GetBeard(user)
    end,
    learn = function(user, skillId, actionPoints, learnLimit)
        Interface.Skills.Learn(user, skillId, actionPoints, learnLimit)
    end,
    getSkillValue = function(user, skill)
        return user:getSkill(skill)
    end,
    teachMagic = function(user, magicType, magicFlag)
        local anyFlags = false
        for i = 0, 4 do
            if user:getMagicFlags(i) ~= 0 then
                anyFlags = true
                break
            end
        end

        if not anyFlags then
            user:setMagicType(magicType)
        end

        local flags = user:getMagicFlags(magicType)
        flags = flags | magicFlag
        Interface.Magic.SetMagicFlags(user, magicType, flags)
    end,
    isInRange = function(user, other, distance)
        return user:isInRangeToPosition(other.position, distance)
    end,
    isInRangeToPosition = function(user, position, distance)
        local dx = math.abs(user.pos.x - position.x)
        local dy = math.abs(user.pos.y - position.y)
        local dz = math.abs(user.pos.z - position.z)
        return (dx <= distance) and (dy <= distance) and dz == 0
    end,
    distanceMetric = function(user, other)
        return user:distanceMetricToPosition(other.position)
    end,
    distanceMetricToPosition = function(user, position)
        local dx = math.abs(user.pos.x - position.x)
        local dy = math.abs(user.pos.y - position.y)
        local dz = math.abs(user.pos.z - position.z)
        return math.max(dx, dy, dz)
    end,
    getMagicType = function(user)
        return Interface.Magic.GetMagicType(user)
    end,
    setMagicType = function(user, magicType)
        Interface.Magic.SetMagicType(user, magicType)
    end,
    getMagicFlags = function(user, magicType)
        return Interface.Magic.GetMagicFlags(user, magicType)
    end,
    warp = function(user, pos)
        -- TODO illa fails this if occupied
        user.SeleneEntity():SetCoordinate(pos)
    end,
    forceWarp = function(user, pos)
        user.SeleneEntity():SetCoordinate(pos)
    end,
    startMusic = function(user, music)
        print("startMusic")
    end,
    defaultMusic = function(user)
        print("defaultMusic")
    end,
    callAttackScript = function(attacker, defender)
        Interface.Combat.CallAttackScript(attacker, defender)
    end,
    getItemList = function(user, itemId) return Interface.Inventory.GetItemList(user, itemId) end,
    getPlayerLanguage = function(user) return Interface.Player.GetLanguage(user) end,
    getBackPack = function(user) return Interface.Inventory.GetBackPack(user) end,
    getDepot = function(user, depotId) return Interface.Inventory.GetDepot(user, depotId) end,
    setQuestProgress = function(user, questId, progress)
        Interface.Quests.SetQuestProgress(user, questId, progress)
    end,
    getQuestProgress = function(user, questId)
        return Interface.Quests.GetQuestProgress(user, questId)
    end,
    getOnRoute = function(user)
        print("getOnRoute")
        return false
    end,
    setOnRoute = function(user, isOnRoute)
        print("setOnRoute")
    end,
    getMonsterType = function(user)
        print("getMonsterType")
        return 0
    end,
    logAdmin = function(user, message)
        Interface.Logger.LogAdmin(user, message)
    end,
    stopAttack = function(user)
        Interface.Combat.StopCombat(user)
    end,
    getAttackTarget = function(user)
        return Interface.Combat.GetTarget(user)
    end,
}

local CharacterMT = {
    __index = function(table, key)
        local method = CharacterMethods[key]
        if method then
            return method
        end
        local getter = CharacterGetters[key]
        if getter then
            return getter(table)
        end

        return rawget(table, key)
    end,
    __newindex = function(table, key, value)
        local setter = CharacterSetters[key]
        if setter then
            setter(table, value)
            return
        end
    end
}

function Character.fromSelenePlayer(player)
    return setmetatable({SelenePlayer = player, SeleneEntity = function() return player.ControlledEntity end}, CharacterMT)
end

function Character.fromSeleneEntity(entity)
    return setmetatable({SeleneEntity = function() return entity end}, CharacterMT)
end

function isValidChar(character)
    return true
end
