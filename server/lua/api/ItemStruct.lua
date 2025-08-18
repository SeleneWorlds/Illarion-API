ItemStruct = {}

function ItemStruct.fromSeleneTileDef(tileDef)
   return {
       AgeingSpeed = tonumber(tileDef:GetMetadata("agingSpeed")),
       Brightness = tonumber(tileDef:GetMetadata("brightness")),
       BuyStack = tonumber(tileDef:GetMetadata("buyStack")),
       English = tileDef:GetMetadata("nameEnglish"),
       EnglishDescription = tileDef:GetMetadata("descriptionEnglish"),
       German = tileDef:GetMetadata("nameGerman"),
       GermanDescription = tileDef:GetMetadata("descriptionGerman"),
       id = tonumber(tileDef:GetMetadata("id")),
       Level = tonumber(tileDef:GetMetadata("level")),
       MaxStack = tonumber(tileDef:GetMetadata("maxStack")),
       ObjectAfterRot = tonumber(tileDef:GetMetadata("objectAfterRot")),
       Rareness = tonumber(tileDef:GetMetadata("rareness")),
       rotsInInventory = toboolean(tileDef:GetMetadata("rotsInInventory")),
       Weight = tonumber(tileDef:GetMetadata("weight")),
       Worth = tonumber(tileDef:GetMetadata("worth"))
   }
end
