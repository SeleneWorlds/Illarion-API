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

local function nyi(name)
    return function() error(name .. " not yet implemented") end
end

local CharacterGetters = {
    lastSpokenText = nyi("lastSpokenText"),
    effects = nyi("effects"),
    waypoints = nyi("waypoints"),
    pos = nyi("pos"),
    name = nyi("name"),
    id = nyi("id"),
    activeLanguage = nyi("activeLanguage"),
    movepoints = nyi("movepoints"),
    fightpoints = nyi("fightpoints"),
    speed = nyi("speed"),
    isinvisible = nyi("isinvisible"),
    attackmode = nyi("attackmode")
}

local CharacterSetters = {
    activeLanguage = nyi("activeLanguage"),
    movepoints = nyi("movepoints"),
    fightpoints = nyi("fightpoints"),
    speed = nyi("speed"),
    isinvisible = nyi("isinvisible")
}

local CharacterMethods = {
    isNewPlayer = nyi("isNewPlayer"),
    pageGM = nyi("pageGM"),
    requestInputDialog = nyi("requestInputDialog"),
    requestMessageDialog = nyi("requestMessageDialog"),
    requestMerchantDialog = nyi("requestMerchantDialog"),
    requestSelectionDialog = nyi("requestSelectionDialog"),
    requestCraftingDialog = nyi("requestCraftingDialog"),
    idleTime = nyi("idleTime"),
    sendBook = nyi("sendBook"),
    updateAppearance = nyi("updateAppearance"),
    performAnimation = nyi("performAnimation"),
    actionRunning = nyi("actionRunning"),
    changeQualityAt = nyi("changeQualityAt"),
    isAdmin = nyi("isAdmin"),
    talk = nyi("talk"),
    sendCharDescription = nyi("sendCharDescription"),
    startAction = nyi("startAction"),
    abortAction = nyi("abortAction"),
    successAction = nyi("successAction"),
    disturbAction = nyi("disturbAction"),
    changeSource = nyi("changeSource"),
    inform = nyi("inform"),
    introduce = nyi("introduce"),
    move = nyi("move"),
    turn = nyi("turn"),
    getNextStepDir = nyi("getNextStepDir"),
    setRace = nyi("setRace"),
    getRace = nyi("getRace"),
    getFaceTo = nyi("getFaceTo"),
    getType = nyi("getType"),
    createItem = nyi("createItem"),
    getLoot = nyi("getLoot"),
    increasePoisonValue = nyi("increasePoisonValue"),
    getPoisonValue = nyi("getPoisonValue"),
    setPoisonValue = nyi("setPoisonValue"),
    getMentalCapacity = nyi("getMentalCapacity"),
    setMentalCapacity = nyi("setMentalCapacity"),
    increaseMentalCapacity = nyi("increaseMentalCapacity"),
    setClippingActive = nyi("setClippingActive"),
    getClippingActive = nyi("getClippingActive"),
    countItem = nyi("countItem"),
    countItemAt = nyi("countItemAt"),
    eraseItem = nyi("eraseItem"),
    increaseAtPos = nyi("increaseAtPos"),
    swapAtPos = nyi("swapAtPos"),
    createAtPos = nyi("createAtPos"),
    getItemAt = nyi("getItemAt"),
    getSkillName = nyi("getSkillName"),
    getSkill = nyi("getSkill"),
    getMinorSkill = nyi("getMinorSkill"),
    increaseAttrib = nyi("increaseAttrib"),
    setAttrib = nyi("setAttrib"),
    isBaseAttributeValid = nyi("isBaseAttributeValid"),
    getBaseAttributeSum = nyi("getBaseAttributeSum"),
    getMaxAttributePoints = nyi("getMaxAttributePoints"),
    saveBaseAttributes = nyi("saveBaseAttributes"),
    getBaseAttribute = nyi("getBaseAttribute"),
    setBaseAttribute = nyi("setBaseAttribute"),
    increaseBaseAttribute = nyi("increaseBaseAttribute"),
    increaseSkill = nyi("increaseSkill"),
    increaseMinorSkill = nyi("increaseMinorSkill"),
    setSkill = nyi("setSkill"),
    setSkinColour = nyi("setSkinColour"),
    getSkinColour = nyi("getSkinColour"),
    setHairColour = nyi("setHairColour"),
    getHairColour = nyi("getHairColour"),
    setHair = nyi("setHair"),
    getHair = nyi("getHair"),
    setBeard = nyi("setBeard"),
    getBeard = nyi("getBeard"),
    learn = nyi("learn"),
    getSkillValue = nyi("getSkillValue"),
    teachMagic = nyi("teachMagic"),
    isInRange = nyi("isInRange"),
    isInRangeToPosition = nyi("isInRangeToPosition"),
    distanceMetric = nyi("distanceMetric"),
    distanceMetricToPosition = nyi("distanceMetricToPosition"),
    getMagicType = nyi("getMagicType"),
    setMagicType = nyi("setMagicType"),
    getMagicFlags = nyi("getMagicFlags"),
    warp = nyi("warp"),
    forceWarp = nyi("forceWarp"),
    startMusic = nyi("startMusic"),
    defaultMusic = nyi("defaultMusic"),
    callAttackScript = nyi("callAttackScript"),
    getItemList = nyi("getItemList"),
    getPlayerLanguage = nyi("getPlayerLanguage"),
    getBackPack = nyi("getBackPack"),
    getDepot = nyi("getDepot"),
    setQuestProgress = nyi("setQuestProgress"),
    getQuestProgress = nyi("getQuestProgress"),
    getOnRoute = nyi("getOnRoute"),
    setOnRoute = nyi("setOnRoute"),
    getMonsterType = nyi("getMonsterType"),
    logAdmin = nyi("logAdmin"),
    stopAttack = nyi("stopAttack"),
    getAttackTarget = nyi("getAttackTarget")
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

Character.SeleneGetters = CharacterGetters
Character.SeleneSetters = CharacterSetters
Character.SeleneMethods = CharacterMethods
