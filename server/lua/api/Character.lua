local Interface = require("illarion-api.server.lua.interface")

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
            Interface.LTE.RemoveEffect(user, idOrNameOrEffect)
        end
    } end,
    waypoints = function(user) return {
        addWaypoint = function(waypoint)
            print("waypoints.addWaypoint", waypoint)
        end,
        clear = function()
           print("waypoints.clear")
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
        return user.SelenePlayer:GetIdleTime()
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
    inform = function(user, message)
        Interface.Player.Inform(user, message)
    end,
    introduce = function(user)
        print("introduce")
    end,
    move = function(user, direction, activeMove)
        -- TODO ActiveMove??
        user.SeleneEntity():Move(direction)
    end,
    turn = function(user, direction)
        local seleneDirection = nil
        if direction == Character.north then
            seleneDirection = "north"
        elseif direction == Character.south then
            seleneDirection = "south"
        elseif direction == Character.east then
            seleneDirection = "east"
        elseif direction == Character.west then
            seleneDirection = "west"
        end
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
        local seleneDirection = user.SeleneEntity().Facing
        if seleneDirection == "north" then
            return Character.north
        elseif seleneDirection == "south" then
            return Character.south
        elseif seleneDirection == "east" then
            return Character.east
        elseif seleneDirection == "west" then
            return Character.west
        end
        return Character.north
    end,
    getType = function(user)
        -- TODO Monster/NPC
        print("getType")
        return Character.player
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
        local prev = Interface.Attributes.GetAttribute(user, attribute)
        local new = prev + value
        Interface.Attributes.SetAttribute(user, attribute, new)
        return new
    end,
    setAttrib = function(user, attribute, value)
        Interface.Attributes.SetAttribute(user, attribute, value)
    end,
    isBaseAttributeValid = function(user, attribute, value)
        -- TODO Checks against race data in IllaServer
        print("isBaseAttributeValid")
        return true
    end,
    getBaseAttributeSum = function(user)
        return user:getBaseAttribute("agility") + user:getBaseAttribute("constitution") +
               user:getBaseAttribute("dexterity") + user:getBaseAttribute("essence") +
               user:getBaseAttribute("intelligence") + user:getBaseAttribute("perception") +
               user:getBaseAttribute("strength") + user:getBaseAttribute("willpower")
    end,
    getMaxAttributePoints = function(user)
        print("getMaxAttributePoints")
        return 50 -- TODO Checks against race in IllaServer
    end,
    saveBaseAttributes = function(user)
        -- TODO IllaServer resets base attributes to those defined in race if sum does not match getMaxAttributePoints
        -- Not currently used in scripts.
        print("saveBaseAttributes")
    end,
    getBaseAttribute = function(user, attribute)
        return Interface.Attributes.GetBaseAttribute(user, attribute)
    end,
    setBaseAttribute = function(user, attribute, value)
        if user:isBaseAttributeValid(attribute, value) then
            Interface.Attributes.SetBaseAttribute(user, attribute, value)
            -- TODO IllaServer syncs health / alive status here too
            return true
        end
        return false
     end,
    increaseBaseAttribute = function(user, attribute, amount)
        local new = user:getBaseAttribute(attribute) + amount
        if user:isBaseAttributeValid(attribute, new) then
            user:setBaseAttribute(attribute, new)
            -- TODO IllaServer syncs health / alive status here too
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
        user:setMagicType(magicType) -- TODO IllaServer only does this if the player has no flags in any magic type

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
    callAttackScript = function(user)
        Interface.Combat.CallAttackScript(user)
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
    return setmetatable({SelenePlayer = player, SeleneEntity = function() return player:GetControlledEntity() end}, CharacterMT)
end

function Character.fromSeleneEntity(entity)
    return setmetatable({SeleneEntity = function() return entity end}, CharacterMT)
end

function isValidChar(character) 
    return true 
end
