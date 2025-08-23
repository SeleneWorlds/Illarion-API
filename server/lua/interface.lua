local m = {}

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