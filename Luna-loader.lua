  
local games = loadstring(game:HttpGet("https://raw.githubusercontent.com/ArcherDevelopment/Luna/main/luna-games.lua"))()
local ingame = false
for i,gam in pairs(games) do
  if game.PlaceId == gam.ID then
     ingame = true
     loadstring(game:HttpGet("https://raw.githubusercontent.com/ArcherDevelopment/Luna/main/games/"..gam.Script))()
 else
     ingame = false
  end
end

