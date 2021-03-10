local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/ArcherDevelopment/MaterialLua/master/Module.lua"))()

local X = Material.Load({
    Title = "Luna Hub",
    Style = 2,
    SizeX = 500,
    SizeY = 400,
    Theme = "Aqua",
    ColorOverrides = {
        MainFrame = Color3.fromRGB(24,24,24),
        NavBarAccent  = Color3.fromRGB(24,24,24),
        
    }
})

local Page = X.New({
    Title = "Player"
})

local Page1 = X.New({
    Title = "World"
})

local Page2 = X.New({
    Title = "Teleports"
})

local Page3 = X.New({
    Title = "Land"
})

plr = game.Players.LocalPlayer
walkSpeed = 16
walkEnabled = nil
clipping = false
chr = plr.Character
hum = chr.Humanoid
hrp = chr.HumanoidRootPart
cfr = hrp.CFrame


-- WALKSPEED
Page.Slider({
    Text = "WalkSpeed",
    Callback = function(value)
        print(value)
        walkSpeed = value
        if walkSpeed > 16 then
            walkEnabled = game:GetService("RunService").RenderStepped:Connect(function()
                if plr.Character:FindFirstChildOfClass("Humanoid").WalkSpeed ~= 0 then
                    plr.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = walkSpeed
                end
            end)
        else
            if walkEnabled then
                walkEnabled:Disconnect()
            end
        end
        
    end,
    Min = 0,
    Max = 300,
    Def = 16
})


-- JUMP POWER
Page.Slider({
    Text = "JumpPower",
    Callback = function(value)
        plr.Character.Humanoid.JumpPower = value
    end,
    Min = 0,
    Def = 16,
    Max = 300,
})
Page.Toggle({
    Text = "NoClip",
    Callback = function(state) 
     clip = state

    
end,
    Enabled = false
})
 --NOCLIP FUNC
clipping = game:GetService("RunService").Stepped:Connect(function()
    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Torso") and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Head") then
        game:GetService("Players").LocalPlayer.Character:FindFirstChild("Torso").CanCollide = not clip
        game:GetService("Players").LocalPlayer.Character:FindFirstChild("Head").CanCollide = not clip
    end
end)


--NO SHADOWS
Page1.Toggle({
    Text = "No Shadows",
    Callback = function(state)
        Shadows = state
        
end,
    Enabled = false
})

Shadowss = game:GetService("RunService").Stepped:Connect(function()
    game:GetService("Lighting").GlobalShadows = not Shadows
end)

Page1.Toggle({
    Text = "NoFog",
    Callback = function(state)
        Nofog = state
        
end,
    Enabled = false
})
--NoFog
Nofog = game:GetService("RunService").Stepped:Connect(function()
    if Nofog == not state then
        fogDisable = game.Lighting.Changed:Connect(function()
            game.Lighting.FogEnd = 100000
        end)
    end
end)
--AlwaysDay
Page1.Toggle({
    Text = "AlwaysDay",
    Callback = function(state)
        alwaysdaywierdchamp = state

end,
    Enabled = false
})

dayConnect = nil
DayBrightness = 1
alwaysdaywierdchamp = game:GetService("RunService").Stepped:Connect(function() 
     if alwaysdaywierdchamp == not state then
        dayConnect = game.Lighting.Changed:Connect(function()
            game.Lighting.TimeOfDay = "12:00:00"
            game.Lighting.Brightness = 2
        end)
    end
end)

Page1.Button({
    Text = "Remove Snow Boulders",
    Callback = function(state)
        RemovethemBoulders = state

end,
    Enabled = false
})
--Remove Boulders 
RemovethemBoulders = game:GetService("RunService").Stepped:Connect(function() 
    if RemovethemBoulders == not state then
        for i, v in pairs(game.Workspace.Region_Snow:FindFirstChild("PartSpawner"):GetChildren()) do 
            if v ~= nil then
                v:Destroy()
            end
        end
    end
end)

Page1.Button({
    Text = "Remove Lava Boulders",
    Callback = function(state)
        RemoveThemLavaBoulders = state

end,
    Enabled = false
})

RemoveThemLavaBoulders = game:GetService("RunService").Stepped:Connect(function()
    if RemoveThemLavaBoulders == not state then
        for i, v in pairs(game.Workspace.Region_Valcano:FindFirstChild("PartSpawner"):GetChildren()) do
            v:Destroy()
        end
    end
end)
Page2.Button({
    Text = "Get CFrame Location",
    Callback = function(value)
        print(tostring(chr.HumanoidRootPart.CFrame.p))
    end,
})
Page2.Dropdown({
    Text = "Stores",
    Callback = function(value)
        if value == "Wood R' Us" then
            chr.HumanoidRootPart.CFrame = CFrame.new(249, 4, 58) end
        if value == "Land Store" then
            chr.HumanoidRootPart.CFrame = CFrame.new(241, 4, -99) end
        if value == "Fancy Furnishings" then
            chr.HumanoidRootPart.CFrame = CFrame.new(491, 13, -1720) end
        if value == "Links Logic" then
            chr.HumanoidRootPart.CFrame = CFrame.new(4607, 9, -798) end
        if value == "Boxed Cars" then
            chr.HumanoidRootPart.CFrame = CFrame.new(508.5, 4, -1462.7) end
        if value == "Fine Arts" then
            chr.HumanoidRootPart.CFrame = CFrame.new(5207, -156, 719) end
        if value == "Bob's Shack" then
            chr.HumanoidRootPart.CFrame = CFrame.new(260, 10, -2542) end
    end,
    Options = {"Wood R' Us", "Land Store", "Fancy Furnishings", "Links Logic", "Boxed Cars", "Fine Arts", "Bob's Shack"}
})

Page2.Dropdown({
    Text = "Points Of Interest",
    Callback = function(value)
        print(value)
    end,
    Options = {"", "", ""}
})

Page2.Dropdown({
    Text = "Tree Regions",
    Callback = function(value)
        print(value)
    end,
    Options = {"", "", ""}
})
Page3.Button({
    Text = "Free Land",
    Callback = function()
        for i, v in pairs(game.Workspace.Properties:GetChildren()) do
                if v:FindFirstChild("Owner") and v:FindFirstChild("OriginSquare") and v.Owner.Value == nil then
                    game:GetService("ReplicatedStorage").PropertyPurchasing.ClientPurchasedProperty:FireServer(v, v.OriginSquare.OriginCFrame.Value + Vector3.new(0, 3, 0))
                    wait(0.5)
                    Instance.new("RemoteEvent", game:GetService'ReplicatedStorage'.Interaction).Name = "Ban"
                    for a, b in pairs(game.Workspace.Properties:GetChildren()) do
                        if b:FindFirstChild("Owner") and b.Owner.Value == game.Players.LocalPlayer then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = b.OriginSquare.CFrame + Vector3.new(0, 3, 0)
                end
            end
            break
        end
        
    end
    end,
    Menu = {
        Information = function(self)
            X.Banner({
                Text = "Gives you free land!"
            })
        end
    }
})

Page3.Button({
    Text = "Max Land",
    Callback = function(value)
        local base
        for i, v in pairs(game.Workspace.Properties:GetChildren()) do
            if v:FindFirstChild("Owner") and v.Owner.Value == game.Players.LocalPlayer then
                base = v
                break
            end
        end
        function createBaseSpot(position)
            game:GetService("ReplicatedStorage").PropertyPurchasing.ClientExpandedProperty:FireServer(base, position)
    
            
        end
        local bPos = base.OriginSquare.Position
        createBaseSpot(CFrame.new(bPos.X + 40, bPos.Y, bPos.Z))
        createBaseSpot(CFrame.new(bPos.X - 40, bPos.Y, bPos.Z))
        createBaseSpot(CFrame.new(bPos.X, bPos.Y, bPos.Z + 40))
        createBaseSpot(CFrame.new(bPos.X, bPos.Y, bPos.Z - 40))
        createBaseSpot(CFrame.new(bPos.X + 40, bPos.Y, bPos.Z + 40))
        createBaseSpot(CFrame.new(bPos.X + 40, bPos.Y, bPos.Z - 40))
        createBaseSpot(CFrame.new(bPos.X - 40, bPos.Y, bPos.Z + 40))
        createBaseSpot(CFrame.new(bPos.X - 40, bPos.Y, bPos.Z - 40))
        createBaseSpot(CFrame.new(bPos.X + 80, bPos.Y, bPos.Z))
        createBaseSpot(CFrame.new(bPos.X - 80, bPos.Y, bPos.Z))
        createBaseSpot(CFrame.new(bPos.X, bPos.Y, bPos.Z + 80))
        createBaseSpot(CFrame.new(bPos.X, bPos.Y, bPos.Z - 80))

        createBaseSpot(CFrame.new(bPos.X + 80, bPos.Y, bPos.Z + 80))
        createBaseSpot(CFrame.new(bPos.X + 80, bPos.Y, bPos.Z - 80))
        createBaseSpot(CFrame.new(bPos.X - 80, bPos.Y, bPos.Z + 80))
        createBaseSpot(CFrame.new(bPos.X - 80, bPos.Y, bPos.Z - 80))

        createBaseSpot(CFrame.new(bPos.X + 40, bPos.Y, bPos.Z + 80))
        createBaseSpot(CFrame.new(bPos.X - 40, bPos.Y, bPos.Z + 80))
        createBaseSpot(CFrame.new(bPos.X + 80, bPos.Y, bPos.Z + 40))
        createBaseSpot(CFrame.new(bPos.X + 80, bPos.Y, bPos.Z - 40))
        createBaseSpot(CFrame.new(bPos.X - 80, bPos.Y, bPos.Z + 40))
        createBaseSpot(CFrame.new(bPos.X - 80, bPos.Y, bPos.Z - 40))
        createBaseSpot(CFrame.new(bPos.X + 40, bPos.Y, bPos.Z - 80))
        createBaseSpot(CFrame.new(bPos.X - 40, bPos.Y, bPos.Z - 80))

        end
})
