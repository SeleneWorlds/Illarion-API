local Registries = require("selene.registries")
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

local allRaces = Registries.FindAll("illarion:races")
for _, Race in ipairs(allRaces) do
    local name = Race:GetMetadata("name")
    local id = Race:GetMetadata("id")
    if name and id then
        Character[name] = tonumber(id)
    end
end

local allSkills = Registries.FindAll("illarion:skills")
for _, Skill in ipairs(allSkills) do
    local name = Skill:GetMetadata("name")
    local id = Skill:GetMetadata("id")
    if name and id then
        Character[name] = tonumber(id)
    end
end

local CharacterGetters = {
    lastSpokenText = function(User)
        return Interface.Chat.GetLastSpokenText(User.SeleneEntity())
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
    waypoints = function(User) return {
        addWaypoint = function(Waypoint)
            print("waypoints.addWaypoint")
        end,
        clear = function()
           print("waypoints.clear")
        end
    } end,
    pos = function(User)
        return User.SeleneEntity().Coordinate
    end,
    name = function(User) return User.SeleneEntity().Name end,
    id = function(User) return Interface.Player.GetID(User.SelenePlayer) end,
    activeLanguage = function(User) return Interface.Chat.GetLanguage(User.SeleneEntity()) end,
    movepoints = function(User) return Interface.Movement.GetMovePoints(User.SeleneEntity()) end,
    fightpoints = function(User) return Interface.Combat.GetFightPoints(User.SeleneEntity():GetFightPoints()) end,
    speed = function(User) return Interface.Movement.GetSpeed(User.SeleneEntity()) end,
    isinvisible = function(User) return User.SeleneEntity():IsInvisible() end,
    attackmode = function(User) return Interface.Combat.IsInCombat(User.SeleneEntity()) end,
}

local CharacterSetters = {
    activeLanguage = function(User, Value)
        Interface.Chat.SetLanguage(User.SeleneEntity(), Value)
    end,
    movepoints = function(User, Value)
         Interface.Movement.SetMovePoints(User.SeleneEntity(), Value)
    end,
    fightpoints = function(User, Value)
        Interface.Combat.SetFightPoints(User.SeleneEntity(), Value)
    end,
    speed = function(User, Value)
        Interface.Movement.SetSpeed(User.SeleneEntity(), Value)
    end,
    isinvisible = function(user, value)
        User.SeleneEntity():MakeInvisible()
    end
}

local CharacterMethods = {
    isNewPlayer = function(User)
        return Interface.Player.GetTotalOnlineTime(User.SelenePlayer) < 10 * 60 * 60
    end,
    pageGM = function(User, Text)
        Interface.Player.PageGM(User.SelenePlayer, Text)
    end,
    requestInputDialog = function(User, Dialog)
        Interface.Dialog.RequestInput(User.SelenePlayer, Dialog)
    end,
    requestMessageDialog = function(User, Dialog)
        Interface.Dialog.ShowMessage(User.SelenePlayer, Dialog)
    end,
    requestMerchantDialog = function(User, Dialog)
        Interface.Dialog.ShowMerchant(User.SelenePlayer, Dialog)
    end,
    requestSelectionDialog = function(User, Dialog)
        Interface.Dialog.RequestSelection(User.SelenePlayer, Dialog)
    end,
    requestCraftingDialog = function(User, Dialog)
        Interface.Dialog.ShowCrafting(User.SelenePlayer, Dialog)
    end,
    idleTime = function(User)
        return User.SelenePlayer:GetIdleTime()
    end,
    sendBook = function(User, BookID)
        Interface.Dialog.ShowBook(User.SelenePlayer, BookID)
    end,
    updateAppearance = function(User)
        User.SeleneEntity():UpdateVisual()
    end,
    performAnimation = function(User, AnimID)
        print("performAnimation", AnimID)
    end,
    actionRunning = function(User)
        print("actionRunning")
        return false -- TODO Actions
    end,
    changeQualityAt = function(User, BodyPosition, Amount)
        Interface.Inventory.ChangeQualityAt(User.SeleneEntity(), BodyPosition, Amount)
    end,
    isAdmin = function(User)
        return Interface.Player.IsAdmin(User.SelenePlayer)
    end,
    talk = function(User, Mode, Message, MessageEnglish)
        Interface.Chat.Talk(User.SeleneEntity(), Mode, Message, MessageEnglish)
    end,
    sendCharDescription = function(User, ID, Text)
        Interface.Dialog.ShowCharDescription(User.SelenePlayer, ID, Text)
    end,
    startAction = function(User, Duration, gfxId, gfxInterval, sfxId, sfxInterval)
        print("startAction", Duration, gfxId, gfxInterval, sfxId, sfxInterval)
        -- TODO We need to get the current "entrypoint" here, i.e. the function the engine called directly that got us here
        -- TODO Play GFX and SFX
        -- TODO User.SeleneEntity():StartAction(Duration)
    end,
    abortAction = function(User)
        print("abortAction")
    end,
    successAction = function(User)
        print("completeAction")
    end,
    disturbAction = function(User, Disturber)
        print("disturbAction")
    end,
    changeSource = function(User, Item)
        print("changeSource")
    end,
    inform = function(user, message)
        Interface.Player.Inform(user, message)
    end,
    introduce = function(User)
        print("introduce")
    end,
    move = function(User, Direction, ActiveMove)
        -- TODO ActiveMove??
        User.SeleneEntity():Move(Direction)
    end,
    turn = function(User, Direction)
        local SeleneDirection = nil
        if Direction == Character.north then
            SeleneDirection = "north"
        elseif Direction == Character.south then
            SeleneDirection = "south"
        elseif Direction == Character.east then
            SeleneDirection = "east"
        elseif Direction == Character.west then
            SeleneDirection = "west"
        end
        if SeleneDirection then
            User.SeleneEntity():SetFacing(SeleneDirection)
        end
    end,
    getNextStepDir = function(User, Position, OutDir)
        -- Not used in scripts. Normally performs a pathfind and returns the first step to take, discarding the rest.
        print("getNextStepDir")
        return false, nil
    end,
    setRace = function(User, Race)
        Interface.Character.SetRace(User.SeleneEntity(), Race)
    end,
    getRace = function(User)
        return Interface.Character.GetRace(User.SeleneEntity())
    end,
    getFaceTo = function(User)
        local SeleneDirection = User.SeleneEntity().Facing
        if SeleneDirection == "north" then
            return Character.north
        elseif SeleneDirection == "south" then
            return Character.south
        elseif SeleneDirection == "east" then
            return Character.east
        elseif SeleneDirection == "west" then
            return Character.west
        end
        return Character.north
    end,
    getType = function(User)
        -- TODO Monster/NPC
        print("getType")
        return Character.player
    end,
    createItem = function(User, ItemID, Count, Quality, Data)
        return Interface.Inventory.CreateItem(User.SeleneEntity(), ItemID, Count, Quality, Data)
    end,
    getLoot = function(user)
        print("getLoot")
        return {}
    end,
    increasePoisonValue = function(User, Amount)
        User:setPoisonValue(User:getPoisonValue() + Amount)
    end,
    getPoisonValue = function(User)
        return Interface.Attributes.GetPoisonValue(User.SeleneEntity())
    end,
    setPoisonValue = function(User, Value)
        Interface.Attributes.SetPoisonValue(User.SeleneEntity(), Value)
    end,
    getMentalCapacity = function(User)
        return Interface.Attributes.GetMentalCapacity(User.SeleneEntity())
    end,
    setMentalCapacity = function(User, Value)
        Interface.Attributes.SetMentalCapacity(User.SeleneEntity(), Value)
    end,
    increaseMentalCapacity = function(User, Amount)
        User:setMentalCapacity(User:getMentalCapacity() + Amount)
    end,
    setClippingActive = function(User, Status)
        User.SeleneEntity():SetNoClip(Status)
    end,
    getClippingActive = function(User)
        return User.SeleneEntity():IsNoClip()
    end,
    countItem = function(user, itemID)
        return Interface.Inventory.CountItem(user.SeleneEntity(), itemID)
    end,
    countItemAt = function(user, slots, itemID, data)
        return Interface.Inventory.CountItemAt(user.SeleneEntity(), slots, itemID, data)
    end,
    eraseItem = function(user, itemID, count, data)
        return Interface.Inventory.EraseItem(user.SeleneEntity(), itemID, count, data)
    end,
    increaseAtPos = function(user, bodyPosition, count)
        Interface.Inventory.IncreaseAtPos(user.SeleneEntity(), bodyPosition, count)
    end,
    swapAtPos = function(user, bodyPosition, itemID, quality)
        Interface.Inventory.SwapAtPos(user.SeleneEntity(), bodyPosition, itemID, quality)
    end,
    createAtPos = function(user, bodyPosition, itemID, count)
        Interface.Inventory.CreateAtPos(user.SeleneEntity(), bodyPosition, itemID, count)
    end,
    getItemAt = function(user)
        return Interface.Inventory.GetItemAt(user.SeleneEntity())
    end,
    getSkillName = function(user, SkillId)
        local skill = Registries.FindByMetadata("illarion:skills", "id", SkillId)
        return skill:GetMetadata("name")
    end,
    getSkill = function(User, TargetSkill)
        return Interface.Skills.GetSkill(User.SeleneEntity(), TargetSkill)
    end,
    getMinorSkill = function(User, TargetSkill)
        return Interface.Skills.GetMinorSkill(User.SeleneEntity(), TargetSkill)
    end,
    increaseAttrib = function(User, Attribute, Value)
        local prev = Interface.Attributes.GetAttribute(User.SeleneEntity(), Attribute)
        local new = prev + Value
        Interface.Attributes.SetAttribute(User.SeleneEntity(), Attribute, new)
        return new
    end,
    setAttrib = function(User, Attribute, Value)
        Interface.Attributes.SetAttribute(User.SeleneEntity(), Attribute, Value)
    end,
    isBaseAttributeValid = function(User, Attribute, Value)
        -- TODO Checks against race data in IllaServer
        print("isBaseAttributeValid")
        return true
    end,
    getBaseAttributeSum = function(User)
        return User:getBaseAttribute("agility") + User:getBaseAttribute("constitution") +
               User:getBaseAttribute("dexterity") + User:getBaseAttribute("essence") +
               User:getBaseAttribute("intelligence") + User:getBaseAttribute("perception") +
               User:getBaseAttribute("strength") + User:getBaseAttribute("willpower")
    end,
    getMaxAttributePoints = function(User)
        print("getMaxAttributePoints")
        return 50 -- TODO Checks against race in IllaServer
    end,
    saveBaseAttributes = function(User)
        -- TODO IllaServer resets base attributes to those defined in race if sum does not match getMaxAttributePoints
        -- Not currently used in scripts.
        print("saveBaseAttributes")
    end,
    getBaseAttribute = function(User, Attribute)
        return Interface.Attributes.GetBaseAttribute(User.SeleneEntity(), Attribute)
    end,
    setBaseAttribute = function(User, Attribute, Value)
        if User:isBaseAttributeValid(Attribute, Value) then
            Interface.Attributes.SetBaseAttribute(User.SeleneEntity(), Attribute, Value)
            -- TODO IllaServer syncs health / alive status here too
            return true
        end
        return false
     end,
    increaseBaseAttribute = function(User, Attribute, Amount)
        local new = User:getBaseAttribute(Attribute) + Amount
        if User:isBaseAttributeValid(Attribute, new) then
            User:setBaseAttribute(Attribute, new)
            -- TODO IllaServer syncs health / alive status here too
            return true
        end
        return false
    end,
    increaseSkill = function(User, TargetSkill, Value)
        local prev = User:getSkill(TargetSkill)
        User:setSkill(TargetSkill, prev + Value, User:getMinorSkill(TargetSkill))
    end,
    increaseMinorSkill = function(User, TargetSkill, Value)
        local prev = User:getMinorSkill(TargetSkill)
        User:setSkill(TargetSkill, User:getSkill(TargetSkill), prev + Value)
    end,
    setSkill = function(User, TargetSkill, Major, Minor)
        Interface.Skills.SetSkill(User, TargetSkill, Major)
        Interface.Skills.SetSkillMinor(User, TargetSkill, Minor)
    end,
    setSkinColour = function(User, SkinColour)
        Interface.Character.SetSkinColour(User.SeleneEntity(), SkinColour)
    end,
    getSkinColour = function(User)
        return Interface.Character.GetSkinColour(User.SeleneEntity())
    end,
    setHairColour = function(User, HairColour)
        Interface.Character.SetHairColour(User.SeleneEntity(), HairColour)
    end,
    getHairColour = function(User)
        return Interface.Character.GetHairColour(User.SeleneEntity())
    end,
    setHair = function(User, HairID)
        Interface.Character.SetHair(User.SeleneEntity(), HairID)
    end,
    getHair = function(User)
        return Interface.Character.GetHair(User.SeleneEntity())
    end,
    setBeard = function(User, BeardID)
        Interface.Character.SetBeard(User.SeleneEntity(), BeardID)
    end,
    getBeard = function(User)
        return Interface.Character.GetBeard(User.SeleneEntity())
    end,
    learn = function(User, TargetSkill, ActionPoints, LearnLimit)
        Interface.Skills.Learn(User.SeleneEntity(), TargetSkill, ActionPoints, LearnLimit)
    end,
    getSkillValue = function(User, TargetSkill)
        return User:getSkill(TargetSkill)
    end,
    teachMagic = function(User, MagicType, MagicFlag)
        User:setMagicType(MagicType) -- TODO IllaServer only does this if the player has no flags in any magic type

        local flags = User:getMagicFlags(MagicType)
        flags = flags | MagicFlag
        Interface.Magic.SetMagicFlags(User.SeleneEntity(), MagicType, flags)
    end,
    isInRange = function(User, SecondCharacter, Distance)
        return User:isInRangeToPosition(SecondCharacter.position, Distance)
    end,
    isInRangeToPosition = function(User, Position, Distance)
        local dx = math.abs(User.pos.x - Position.x)
        local dy = math.abs(User.pos.y - Position.y)
        local dz = math.abs(User.pos.z - Position.z)
        return (dx <= Distance) and (dy <= Distance) and dz == 0
    end,
    distanceMetric = function(User, SecondCharacter)
        return User:distanceMetricToPosition(SecondCharacter.position)
    end,
    distanceMetricToPosition = function(User, Position)
        local dx = math.abs(User.pos.x - Position.x)
        local dy = math.abs(User.pos.y - Position.y)
        local dz = math.abs(User.pos.z - Position.z)
        return math.max(dx, dy, dz)
    end,
    getMagicType = function(User)
        return Interface.Magic.GetMagicType(User.SeleneEntity())
    end,
    setMagicType = function(User, MagicType)
        Interface.Magic.SetMagicType(User.SeleneEntity(), MagicType)
    end,
    getMagicFlags = function(User, MagicType)
        return Interface.Magic.GetMagicFlags(User.SeleneEntity(), MagicType)
    end,
    warp = function(User, Pos)
        -- TODO illa fails this if occupied
        User.SeleneEntity():SetCoordinate(Pos)
    end,
    forceWarp = function(User, Pos)
        User.SeleneEntity():SetCoordinate(Pos)
    end,
    startMusic = function(User, Track)
        print("startMusic")
    end,
    defaultMusic = function(User)
        print("defaultMusic")
    end,
    callAttackScript = function(User)
        Interface.Combat.CallAttackScript(User.SeleneEntity())
    end,
    getItemList = function(User, ItemID) return Interface.Inventory.GetItemList(User.SeleneEntity(), ItemID) end,
    getPlayerLanguage = function(User) return Interface.Player.GetLanguage(User.SelenePlayer) end,
    getBackPack = function(User) return Interface.Inventory.GetBackPack(User.SeleneEntity()) end,
    getDepot = function(User, DepotID) return Interface.Inventory.GetDepot(User.SeleneEntity(), DepotID) end,
    setQuestProgress = function(User, QuestID, Progress)
        Interface.Quests.SetQuestProgress(User.SeleneEntity(), QuestID, Progress)
    end,
    getQuestProgress = function(User, QuestID)
        return Interface.Quests.GetQuestProgress(User.SeleneEntity(), QuestID)
    end,
    getOnRoute = function(User)
        print("getOnRoute")
        return false
    end,
    setOnRoute = function(User, IsOnRoute)
        print("setOnRoute")
    end,
    getMonsterType = function(User)
        print("getMonsterType")
        return 0
    end,
    logAdmin = function(User, Message)
        Interface.Logger.LogAdmin(User.SelenePlayer, Message)
    end,
    stopAttack = function(User)
        Interface.Combat.StopCombat(User.SeleneEntity())
    end,
    getAttackTarget = function(User)
        return Interface.Combat.GetTarget(User)
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

function Character.fromSelenePlayer(Player)
    return setmetatable({SelenePlayer = Player, SeleneEntity = function() return Player:GetControlledEntity() end}, CharacterMT)
end

function Character.fromSeleneEntity(Entity)
    return setmetatable({SeleneEntity = function() return Entity end}, CharacterMT)
end

function isValidChar(character) 
    return true 
end
