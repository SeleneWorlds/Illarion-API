local m = {}

local SoundMappings = {
    [1] = "illarion:scream",
    [2] = "illarion:sheep",
    [3] = "illarion:hit",
    [4] = "illarion:thunder",
    [5] = "illarion:bang",
    [6] = "illarion:chopping",
    [7] = "illarion:fire",
    [8] = "illarion:anvil",
    [9] = "illarion:water_splash",
    [10] = "illarion:water_pour",
    [11] = "illarion:saw",
    [12] = "illarion:drink",
    [13] = "illarion:snaring",
    [14] = "illarion:carving",
    [15] = "illarion:cooking",
    [16] = "illarion:rasp",
    [17] = "illarion:goldsmithing",
    [18] = "illarion:mining",
    [19] = "illarion:lock",
    [20] = "illarion:unlock",
    [21] = "illarion:door",
    [22] = "illarion:click",
    [23] = "illarion:burp",
    [24] = "illarion:coins",
    [25] = "illarion:evil_laugh",
    [26] = "illarion:roar",
    [27] = "illarion:wind",
    [28] = "illarion:wind2",
    [30] = "illarion:bow",
    [31] = "illarion:hit_arrow",
    [32] = "illarion:hit_staff_plate",
    [33] = "illarion:hit_sword_plate",
    [40] = "illarion:parry_axe_shield",
    [41] = "illarion:parry_staff",
    [42] = "illarion:parry_sword",
    [43] = "illarion:parry_sword_shield",
    [44] = "illarion:parry_sword_staff",
}

function m.GetSoundById(soundId)
    return SoundMappings[soundId]
end

return m