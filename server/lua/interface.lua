local m = {}

m.Chat = {
    Talk = function(Entity, Message) end,
    GetLastSpokenText = function(Entity) return "" end,
    SetLanguage = function(Entity, Language) end,
    GetLanguage = function(Entity) return 0 end
}

m.Dialog = {
    RequestInput = function(Player, Dialog) end,
    ShowMessage = function(Player, Dialog) end,
    RequestSelection = function(Player, Dialog) end,
    ShowMerchant = function(Player, Dialog) end,
    ShowCrafting = function(Player, Dialog) end,
    ShowBook = function(Player, BookID) end,
    ShowCharDescription = function(Player, CharID, Text) end
}

m.Movement = {
    GetMovePoints = function(Entity) return 0 end,
    GetSpeed = function(Entity) return 0 end,
    SetMovePoints = function(Entity, Value) end,
    SetSpeed = function(Entity, Value) end
}

m.Combat = {
    IsInCombat = function(Entity) return false end,
    StopCombat = function(Entity) end,
    GetTarget = function(Entity) return nil end,
    GetFightPoints = function(Entity) return 0 end,
    SetFightPoints = function(Entity, Value) end,
    CallAttackScript = function(Entity) end
}

m.Inventory = {
    ChangeQualityAt = function(Entity, BodyPosition, Amount) end,
    CountItem = function(Entity, ItemID) return 0 end,
    CountItemAt = function(Entity, Slots, ItemID, Data) return 0 end,
    EraseItem = function(Entity, ItemID, Count, Data) end,
    IncreaseAtPos = function(Entity, BodyPosition, Count) end,
    SwapAtPos = function(Entity, BodyPosition, ItemID, Quality) end,
    CreateItem = function(Entity, ItemID, Count, Quality, Data) return 0 end,
    CreateAtPos = function(Entity, BodyPosition, ItemID, Count) end,
    GetItemAt = function(Entity, BodyPosition) return Item.fromSeleneEmpty() end,
    GetItem = function(Entity, ItemID, Data) return Item.fromSeleneEmpty() end,
    GetBackpack = function(Entity) return SeleneContainer() end,
    GetDepot = function(Entity, DepotID) return SeleneContainer() end
}

m.Attributes = {
    GetAttribute = function(Entity, AttributeID) return 0 end,
    SetAttribute = function(Entity, AttributeID, Value) end,
    GetPoisonValue = function(Entity) return 0 end,
    SetPoisonValue = function(Entity, Value) end,
    GetMentalCapacity = function(Entity) return 0 end,
    SetMentalCapacity = function(Entity, Value) end,
}

m.Character = {
    SetRace = function(Entity, RaceID) end,
    GetRace = function(Entity) return 0 end,
    GetSkinColour = function(Entity) return colour(255, 255, 255) end,
    SetSkinColour = function(Entity, Colour) end,
    GetHairColour = function(Entity) return colour(255, 255, 255) end,
    SetHairColour = function(Entity, Colour) end,
    GetHair = function(Entity) return 0 end,
    SetHair = function(Entity, HairID) end,
    GetBeard = function(Entity) return 0 end,
    SetBeard = function(Entity, BeardID) end
}

m.Magic = {
    GetMagicType = function(Entity) return 0 end,
    SetMagicType = function(Entity, MagicType) end,
    GetMagicFlags = function(Entity, MagicType) return 0 end,
    SetMagicFlags = function(Entity, MagicType, Flags) end
}

m.Skills = {
    GetSkillName = function(SkillID) return "" end,
    GetSkill = function(Entity, SkillID) return 0 end,
    GetMinorSkill = function(Entity, SkillID) return 0 end,
}

m.Quests = {
    GetQuestProgress = function(Entity, QuestID) return 0 end,
    SetQuestProgress = function(Entity, QuestID, Progress) end
}

m.Player = {
    Inform = function(Player, Message) end,
    PageGM = function(Player, Text) end,
    IsAdmin = function(Player) return false end,
    GetLanguage = function(Player) return 0 end,
    GetTotalOnlineTime = function(Player) return 0 end,
    GetID = function(Player) return 0 end
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
    LogAdmin = function(Player, Message)
        print("[Admin] " .. Message)
    end
}

return m