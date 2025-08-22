local m = {}

m.Chat = {
    Talk = function(user, mode, message, messageEnglish) end,
    GetLastSpokenText = function(user) return "" end,
    SetLanguage = function(user, language) end,
    GetLanguage = function(user) return 0 end
}

m.Dialog = {
    RequestInput = function(user, dialog) end,
    ShowMessage = function(user, dialog) end,
    RequestSelection = function(user, dialog) end,
    ShowMerchant = function(user, dialog) end,
    ShowCrafting = function(user, dialog) end,
    ShowBook = function(user, bookId) end,
    ShowCharDescription = function(user, charID, message) end
}

m.Movement = {
    GetMovePoints = function(user) return 0 end,
    GetSpeed = function(user) return 0 end,
    SetMovePoints = function(user, value) end,
    SetSpeed = function(user, value) end
}

m.Combat = {
    IsInCombat = function(user) return false end,
    StopCombat = function(user) end,
    GetTarget = function(user) return nil end,
    GetFightPoints = function(user) return 0 end,
    SetFightPoints = function(user, value) end,
    CallAttackScript = function(attacker, defender) end
}

m.Inventory = {
    ChangeQualityAt = function(user, bodyPosition, amount) end,
    CountItem = function(user, itemId) return 0 end,
    CountItemAt = function(user, slots, itemId, data) return 0 end,
    EraseItem = function(user, itemId, count, data) end,
    IncreaseAtPos = function(user, bodyPosition, count) end,
    SwapAtPos = function(user, bodyPosition, itemId, quality) end,
    CreateItem = function(user, itemId, count, quality, data) return 0 end,
    CreateAtPos = function(user, bodyPosition, itemId, count) end,
    GetItemAt = function(user, bodyPosition) return Item.fromSeleneEmpty() end,
    GetItem = function(user, itemId, data) return Item.fromSeleneEmpty() end,
    GetBackpack = function(user) return SeleneContainer() end,
    GetDepot = function(user, depotId) return SeleneContainer() end
}

m.Attributes = {
    GetAttributeOffset = function(user, attribute) return 0 end,
    SetAttributeOffset = function(user, attribute, value) end,
    GetBaseAttribute = function(user, attribute) return 0 end,
    SetBaseAttribute = function(user, attribute, value) end,
    GetTransientBaseAttribute = function(user, attribute) return 0 end,
    SetTransientBaseAttribute = function(user, attribute, value) end,
    GetPoisonValue = function(user) return 0 end,
    SetPoisonValue = function(user, value) end,
    GetMentalCapacity = function(user) return 0 end,
    SetMentalCapacity = function(user, value) end,
    HandleAttributeChange = function(user, attribute) end,
    ClampAttribute = function(user, attribute, value) return value end,
    IsBaseAttributeValid = function(user, attribute, value) return true end,
    GetMaxAttributePoints = function(user) return 0 end,
    GetSex = function(user) return 0 end
}

m.Character = {
    GetType = function(user) return Character.player end,
    SetRace = function(user, raceId) end,
    GetRace = function(user) return 0 end,
    GetSkinColor = function(user) return colour(255, 255, 255) end,
    SetSkinColor = function(user, skinColor) end,
    GetHairColor = function(user) return colour(255, 255, 255) end,
    SetHairColor = function(user, hairColor) end,
    GetHair = function(user) return 0 end,
    SetHair = function(user, hairId) end,
    GetBeard = function(user) return 0 end,
    SetBeard = function(user, beardId) end
}

m.Magic = {
    GetMagicType = function(user) return 0 end,
    SetMagicType = function(user, magicType) end,
    GetMagicFlags = function(user, magicType) return 0 end,
    SetMagicFlags = function(user, magicType, flags) end
}

m.Skills = {
    GetSkillName = function(skillId) return "" end,
    GetSkill = function(user, skillId) return 0 end,
    GetMinorSkill = function(user, skillId) return 0 end,
    SetSkill = function(user, skillId, major) end,
    SetSkillMinor = function(user, skillId, minor) end,
    Learn = function(user, skillId, actionPoints, learnLimit) end
}

m.Quests = {
    GetQuestProgress = function(user, questId) return 0 end,
    SetQuestProgress = function(user, questId, progress) end
}

m.Player = {
    Inform = function(user, message) end,
    PageGM = function(user, message) end,
    IsAdmin = function(user) return false end,
    GetLanguage = function(user) return 0 end,
    GetTotalOnlineTime = function(user) return 0 end,
    GetID = function(user) return 0 end
}

m.LTE = {
    Create = function(id, nextCalled) end,
    AddEffect = function(user, effect) end,
    FindEffect = function(user, idOrName) return false, nil end,
    RemoveEffect = function(user, effect) return false end,
    AddValue = function(effect, key, value) end,
    FindValue = function(effect, key) return false, 0 end,
    RemoveValue = function(effect, key) end,
    SetNextCalled = function(effect, value) end,
    GetNextCalled = function(effect) return 0 end,
    GetNumberCalled = function(effect) return 0 end
}

m.Logger = {
    Log = function(message) end,
    LogDebug = function(message) end,
    LogError = function(message) end,
    LogAdmin = function(user, message) end
}

m.Actions = {
    IsActionRunning = function(user) return false end,
    StartAction = function(user, duration, gfxId, gfxInterval, sfxId, sfxInterval) end,
    AbortAction = function(user) end,
    SuccessAction = function(user) end,
    DisturbAction = function(user, disturber) end,
    ChangeSource = function(user, item) end
}

m.World = {
    ShowGFX = function(gfxId, pos) end,
    PlaySound = function(soundId, pos) end
}

return m