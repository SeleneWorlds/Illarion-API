ItemStruct = {}

function ItemStruct.fromSeleneTileDef(tileDef)
   return {
       AgeingSpeed = tonumber(tileDef:GetMetadata("agingSpeed") or 0),
       Brightness = tonumber(tileDef:GetMetadata("brightness") or 0),
       BuyStack = tonumber(tileDef:GetMetadata("buyStack") or 0),
       English = tileDef:GetMetadata("nameEnglish"),
       EnglishDescription = tileDef:GetMetadata("descriptionEnglish"),
       German = tileDef:GetMetadata("nameGerman"),
       GermanDescription = tileDef:GetMetadata("descriptionGerman"),
       id = tonumber(tileDef:GetMetadata("itemId") or 0),
       Level = tonumber(tileDef:GetMetadata("level") or 0),
       MaxStack = tonumber(tileDef:GetMetadata("maxStack") or 0),
       ObjectAfterRot = tonumber(tileDef:GetMetadata("objectAfterRot") or 0),
       Rareness = tonumber(tileDef:GetMetadata("rareness") or 0),
       rotsInInventory = tileDef:GetMetadata("rotsInInventory") == "true",
       Weight = tonumber(tileDef:GetMetadata("weight") or 0),
       Worth = tonumber(tileDef:GetMetadata("worth") or 0)
   }
end

function ItemStruct.fromSeleneEmpty()
   return {
       AgeingSpeed = 0,
       Brightness = 0,
       BuyStack = 0,
       English = "",
       EnglishDescription = "",
       German = "",
       GermanDescription = "",
       id = 0,
       Level = 0,
       MaxStack = 0,
       ObjectAfterRot = 0,
       Rareness = 0,
       rotsInInventory = false,
       Weight = 0,
       Worth = 0
   }
end