local HttpService = game:GetService('HttpService')
local Supported = false
local Script = nil

local GameList = game:HttpGet('https://raw.githubusercontent.com/MrSnailman/ArcherDevelopment/Luna/main/GameList.json')
function GetGame()
    local GameTable = HttpService:JSONDecode(GameList)
    if GameTable[tostring(game.PlaceId)] then 
        return GameTable[tostring(game.PlaceId)]
    else
        return false
    end    
end
local Game = GetGame()

if Game then
    Supported = true
    Script = game:HttpGet('https://raw.githubusercontent.com/MrSnailman/ArcherDevelopment/Luna/main/games/' .. Game.ScriptName)
end
