local Moonlight = require("moonlight")

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

    -- race_type
    human = 0,
    dwarf = 1,
    halfling = 2,
    elf = 3,
    orc = 4,
    lizardman = 5,
    columnOfResurrection = 7,
    forestTroll = 9,
    mummy = 10,
    skeleton = 11,
    floatingEye = 12,
    sheep = 18,
    spider = 19,
    pig = 24,
    wasp = 27,
    golem = 30,
    cow = 37,
    wolf = 39,
    bear = 51,
    raptor = 52,
    zombie = 53,
    hellhound = 54,
    imp = 55,
    ironGolem = 56,
    ratman = 57,
    dog = 58,
    beetle = 59,
    fox = 60,
    slime = 61,
    chicken = 62,
    boneDragon = 63,
    rat = 111,
    fleshDragon = 112,
    rabbit = 113,
    akaltut = 114,
    fairy = 115,
    deer = 116,
    etting = 117,

    -- inform_type
    lowPriority = 100,
    mediumPriority = 101,
    highPriority = 102,

    -- skills TODO
    tailoring = 14,
    blacksmithing = 15,
    gemcutting = 18,
    carpentry = 13,
    cookingAndBaking = 12,
    finesmithing = 10,
    glassBlowing = 8,
    pottery = 36,
    armourer = 50,
    brewing = 51,
    harp = 34,
    horn = 32,
    flute = 31,
    lute = 30,
    herblore = 16,
    mining = 9,
    fishing = 19,
    farming = 17,
    woodcutting = 11,
    tanningAndWeaving = 49,
    husbandry = 48,
    digging = 47,
    parry = 24,
    heavyArmour = 45,
    mediumArmour = 44,
    lightArmour = 43,
    distanceWeapons = 29,
    slashingWeapons = 27,
    concussionWeapons = 26,
    punctureWeapons = 28,
    wrestling = 21,
    blessing = 54,
    praying = 55,
    vowing = 56,
    confessing = 57,
    ceremony = 58,
    consecrateWeapons = 59,
    consecrateArmours = 60,
    magicResistance = 37,
    alchemy = 20,
    potionLore = 61,
    animalTaming = 62,
    summoning = 63,
    natureLore = 64,
    cauldronLore = 65,
    enchanting = 46,
    fireMagic = 42,
    spiritMagic = 41,
    windMagic = 40,
    earthMagic = 39,
    waterMagic = 38,
    spatialMagic = 66,
    panpipe = 35,
    clavichord = 67
}

local CharacterGetters = {
    lastSpokenText = function(User) return User.SeleneEntity():GetChatHistory(-1) end,
    effects = function(User) return { -- TODO Need to think about how we want to expose scheduled scripts / tickers in Selene
        addEffect = function(User, effect) end,
        find = function(User, idOrName) return false, nil end,

        removeEffect = function(User, idOrNameOrEffect) return false end
    } end,
    waypoints = function(User) return {} end, -- TODO not sure what methods are exposed here
    pos = function(User)
        return User.SeleneEntity().Coordinate
    end,
    name = function(User) return User.SeleneEntity().Name end,
    id = function(User) return User.SelenePlayer:GetPersistentNumericID() end,
    activeLanguage = function(User) return User.SeleneEntity():GetChatLanguage().Data.IllarionID end,
    movepoints = function(User) return 21 end, -- TODO We need to think about this since it's not strictly only script-related.
    fightpoints = function(User) return User.SeleneEntity():GetFightPoints() end,
    speed = function(User) return 1 end, -- TODO We need to think about this since it's not strictly only script-related.
    isinvisible = function(User) return User.SeleneEntity():IsInvisible() end,
    attackmode = function(User) return User.SeleneEntity():IsInCombat() end,
}

local CharacterSetters = {
    activeLanguage = function(User, Value)
        local language = Moonlight.Chat.Languages[Value] -- TODO Find the language by its IllarionID instead
        User.SeleneEntity():SetChatLanguage(language)
    end,
    movepoints = function(User, Value)
         -- TODO We need to think about this since it's not strictly only script-related.
    end,
    fightpoints = function(User, Value)
        User.SeleneEntity():SetFightPoints(value)
    end,
    speed = function(User, Value)
         -- TODO We need to think about this since it's not strictly only script-related.
    end,
    isinvisible = function(user, value)
        User.SeleneEntity():MakeInvisible()
    end
}

local CharacterMethods = {
    isNewPlayer = function(User)
        -- TODO In Illarion, runs an is_new_player database query. We probably want to track Noobia completion to set a persisted flag for this client.
        return false
    end,
    pageGM = function(User, Text)
        -- Illarion has persisted GM tickets, we just pipe it into the GM chat channel.
        return Moonlight.Chat.GetChannel("GM"):SendAs(User, Text)
    end,
    requestInputDialog = function(User, Dialog)
        Moonlight.Dialog.RequestInput(User, Dialog)
    end,
    requestMessageDialog = function(User, Dialog)
        Moonlight.Dialog.ShowMessage(User, Dialog)
    end,
    requestMerchantDialog = function(User, Dialog)
        Network.SendToPlayer(User, "illarion:merchant", dialog)
    end,
    requestSelectionDialog = function(User, Dialog)
        Moonlight.Dialog.RequestSelection(User, Dialog)
    end,
    requestCraftingDialog = function(User, Dialog)
        Network.SendToPlayer(User, "illarion:crafting", dialog)
    end,
    idleTime = function(User)
        return User.SelenePlayer:GetIdleTime()
    end,
    sendBook = function(User, BookID)
        Network.SendToPlayer(User, "illarion:book", BookID)
    end,
    updateAppearance = function(User)
        User.SeleneEntity():ResyncVisuals()
    end,
    performAnimation = function(User, AnimID)
        User.SeleneEntity():PlayAnimation(AnimID)
    end,
    actionRunning = function(User)
        return User.SeleneEntity():IsPerformingAction()
    end,
    changeQualityAt = function(User, BodyPosition, Amount)
        local equipment = User.SeleneEntity():GetInventory(BodyPosition)
        local item = equipment:GetItem(0)
        item.Data.Quality = Amount
        item.MarkDirty()
    end,
    isAdmin = function(User)
        return Moonlight.Permissions.HasRole(User.SelenePlayer, "GM")
    end,
    talk = function(User, Mode, Message, MessageEnglish)
        Moonlight.Chat.GetChannel("Talk"):SendAs(User, Message)
    end,
    sendCharDescription = function(User, ID, Text)
        Network.SendToPlayer(User.SelenePlayer, "illarion:char_description", ID, Text)
    end,
    startAction = function(User, Duration, gfxId, gfxInterval, sfxId, sfxInterval)
        -- TODO We need to get the current "entrypoint" here, i.e. the function the engine called directly that got us here
        -- TODO Play GFX and SFX
        -- TODO User.SeleneEntity():StartAction(Duration)
    end,
    abortAction = function(User)
        User.SeleneEntity():CancelAction()
    end,
    successAction = function(User)
        User.SeleneEntity():CompleteAction()
    end,
    disturbAction = function(User, Disturber)
        User.SeleneEntity():CancelAction({
            CauseEntity = Disturber.SeleneEntity()
        })
    end,
    changeSource = function(User, Item)
        -- TODO
    end,
    inform = function(User, Message)
        User.SelenePlayer:Inform(Message)
    end,
    introduce = function(User)
        -- TODO introduce
    end,
    move = function(User, Direction, ActiveMove)
        -- TODO ActiveMove??
        User.SeleneEntity():MoveTowards(Direction)
    end,
    turn = function(User, Direction)
        User.SeleneEntity():TurnTowards(Direction)
    end,
    getNextStepDir = function(User, Position, OutDir)
        -- TODO Not used in scripts. Performs a pathfind and returns the first step to take.
        return false, nil
    end,
    setRace = function(User, Race)
        User.SeleneEntity():SetCustomData("illarion:race", Race)
    end,
    getRace = function(User)
        return User.SeleneEntity():GetCustomData("illarion:race")
    end,
    getFaceTo = function(User)
        return User.SeleneEntity():GetFacingDirection()
    end,
    getType = function(User)
        -- TODO Monster/NPC
        return Character.player
    end,
    createItem = function(User, ItemID, Count, Quality, Data)
        -- TODO Items
        return 0
    end,
    getLoot = function(user)
        -- TODO Monster Loot
        return {}
    end,
    increasePoisonValue = function(User, Amount)
        local prev = User.SeleneEntity():GetAttribute("PoisonValue")
        User.SeleneEntity():SetAttribute("PoisonValue", prev + Amount)
    end,
    getPoisonValue = function(User)
        return User.SeleneEntity():GetAttribute("PoisonValue")
    end,
    setPoisonValue = function(User, Value)
        User.SeleneEntity():SetAttribute("PoisonValue", Value)
    end,
    getMentalCapacity = function(User)
        return User.SeleneEntity():GetAttribute("MentalCapacity")
    end,
    setMentalCapacity = function(User, Value)
        User.SeleneEntity():SetAttribute("MentalCapacity", Value)
    end,
    increaseMentalCapacity = function(User, Amount)
        local prev = User.SeleneEntity():GetAttribute("MentalCapacity")
        User.SeleneEntity():SetAttribute("MentalCapacity", prev + Amount)
    end,
    setClippingActive = function(User, Status)
        User.SeleneEntity():SetNoClip(Status)
    end,
    getClippingActive = function(User)
        return User.SeleneEntity():IsNoClip()
    end,
    countItem = function(user, itemID) return 0 end,
    countItemAt = function(user, slots, itemID, data) return 0 end,
    eraseItem = function(user, itemID, count, data) return 0 end,
    increaseAtPos = function(user, bodyPosition, count) end,
    swapAtPos = function(user, bodyPosition, itemID, quality) end,
    createAtPos = function(user, bodyPosition, itemID, count) end,
    getItemAt = function(user) end,
    getSkillName = function(user, targetSkill) return "" end,
    getSkill = function(User, TargetSkill)
        return User.SeleneEntity():GetSkill(TargetSkill)
    end,
    getMinorSkill = function(User, TargetSkill)
        return User.SeleneEntity():GetSkillXp(TargetSkill)
    end,
    increaseAttrib = function(User, Attribute, Value)
        local prev = User.SeleneEntity():GetAttribute(Attribute)
        local new = prev + Value
        if prev ~= new then
            User.SeleneEntity():SetAttribute(Attribute, new)
        end
        return Value
    end,
    setAttrib = function(User, Attribute, Value)
        User.SeleneEntity():SetAttribute(Attribute, Value)
    end,
    isBaseAttributeValid = function(User, Attribute, Value)
        -- TODO Checks against race data in IllaServer
        return false
    end,
    getBaseAttributeSum = function(User)
        return User:getBaseAttribute("agility") + User:getBaseAttribute("constitution") +
               User:getBaseAttribute("dexterity") + User:getBaseAttribute("essence") +
               User:getBaseAttribute("intelligence") + User:getBaseAttribute("perception") +
               User:getBaseAttribute("strength") + User:getBaseAttribute("willpower")
    end,
    getMaxAttributePoints = function(User)
        return 0 -- TODO Checks against race in IllaServer
    end,
    saveBaseAttributes = function(User)
        -- TODO IllaServer resets base attributes if sum does not match getMaxAttributePoints
        -- TODO Not used in scripts, we might just no-op this and include them in regular saving
    end,
    getBaseAttribute = function(User, Attribute)
        return User.SeleneEntity():GetBaseAttribute(Attribute)
    end,
    setBaseAttribute = function(User, Attribute, Value)
        if User:isBaseAttributeValid(Attribute, Value) then
            User.SeleneEntity():SetBaseAttribute(Attribute, Value)
            -- TODO IllaServer syncs health / alive status here too
            return
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
        User:IncreaseSkill(TargetSkill, Value)
    end,
    increaseMinorSkill = function(User, TargetSkill, Value)
        User:IncreaseSkillXp(TargetSkill, Value)
    end,
    setSkill = function(User, TargetSkill, Major, Minor)
        User:SetSkill(TargetSkill, Major)
        User:SetSkillXp(TargetSkill, Minor)
    end,
    setSkinColour = function(User, SkinColour) end,
    getSkinColour = function(User) return colour(0, 0, 0) end,
    setHairColour = function(User, HairColour) end,
    getHairColour = function(User) return colour(0, 0, 0) end,
    setHair = function(User, HairID) end,
    getHair = function(User) return 0 end,
    setBeard = function(User, BeardID) end,
    getBeard = function(User) return 0 end,
    learn = function(User, TargetSkill, ActionPoints, LearnLimit)
        -- TODO delegate to "learn" script
    end,
    getSkillValue = function(User, TargetSkill)
        return User:GetSkill(TargetSkill)
    end,
    teachMagic = function(User, MagicType, MagicFlag)
        User:setMagicType(MagicType) -- TODO IllaServer only does this if the player has no flags in any magic type
        local flags = User.SeleneEntity():GetCustomData("illarion:magicFlags" .. MagicType, 0)
        flags = flags | MagicFlag
        User.SeleneEntity():SetCustomData("illarion:magicFlags" .. MagicType, flags)
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
        return User.SeleneEntity():GetCustomData("illarion:magicType", Character.mage)
    end,
    setMagicType = function(User, MagicType)
        User.SeleneEntity():SetCustomData("illarion:magicType", MagicType)
    end,
    getMagicFlags = function(User, MagicType)
        return User.SeleneEntity():GetCustomData("illarion:magicFlags" .. MagicType, 0)
    end,
    warp = function(User, Pos)
        User.SeleneEntity():TryTeleport(Pos)
    end,
    forceWarp = function(User, Pos)
        User.SeleneEntity():Teleport(Pos)
    end,
    startMusic = function(User, Track)
        -- TODO How do we handle Music?
    end,
    defaultMusic = function(User)
        -- TODO How do we handle Music?
    end,
    callAttackScript = function(User)
        -- TODO delegate
    end,
    getItemList = function(user, itemID) return {} end,
    getPlayerLanguage = function(user, id, text) return Player.german end,
    getBackPack = function(user) return SeleneContainer() end,
    getDepot = function(User, DepotID) return SeleneContainer() end,
    setQuestProgress = function(User, QuestID, Progress)
        User.SeleneEntity():SetCustomData("illarion:questProgress" .. QuestID, Progress)
    end,
    getQuestProgress = function(User, QuestID)
        return User.SeleneEntity():GetCustomData("illarion:questProgress" .. QuestID, 0)
    end,
    getOnRoute = function(User) return false end,
    setOnRoute = function(User, IsOnRoute) end,
    getMonsterType = function(User) return 0 end,
    logAdmin = function(user, message)
        print("[Admin] " .. message)
    end,
    stopAttack = function()
        User.SeleneEntity():ExitCombat()
    end,
    getAttackTarget = function()
        return User.SeleneEntity():GetCombatTarget()
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

function isValidChar(character) 
    return true 
end
