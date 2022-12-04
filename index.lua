-- Wolf has: game:GetService("Workspace").Melvin.WolfTag in him...
-- Sheriff has: game:GetService("Workspace").Melvin.HunterTag

-- Wolf also stored = game:GetService("ReplicatedStorage").Wolves
-- Sheriff also stored = game:GetService("ReplicatedStorage").Hunters


-- The collactable item aka. more money thing: game:GetService("Workspace").EffectsBin.CollectableItem

--Fire Remote : game:GetService("Players").LocalPlayer.Backpack.DefaultCrossbow.WeaponEvent
--[[
    local args = {
    [1] = "Fire",
    [2] = Vector3.new(-0.29962921142578125, 1.0731163024902344, -0.8499984741210938),
    [3] = workspace.Model.Model.Part
}

game:GetService("Players").LocalPlayer.Character.DefaultCrossbow.WeaponEvent:FireServer(unpack(args))

]]

-- Weapon in EffectsBin.Handle

-- Doors are stored in game:GetService("Workspace").MapHolder.Map."MAP".Door

assert(Drawing, "Exploit not supported!")


if getgenv().UnloadWX then
    getgenv().UnloadWX()
end



local plrs = {}
local MyUtil = {}
local LibUtil = {}
local connections = {}


getgenv().UnloadWX = function()
    plrs = {}
    MyUtil = {}
    LibUtil = {}
    game:GetService("CoreGui").ScreenGui:Destroy()
    for index, connection in pairs(connections) do 
        if typeof(connection) == "RBXScriptConnection" then 
            connection:disconnect()
        elseif typeof(connection) == "string" then 
            pcall(function()
                game:service("RunService"):UnbindFromRenderStep(connection)
            end)
        end
    end
end

local workspace, repstorage, players = game:GetService("Workspace"), game:GetService("ReplicatedStorage"), game:GetService("Players")
local player, camera = players.LocalPlayer, workspace.CurrentCamera

local Lib = loadstring(game:HttpGet("https://pastebin.com/raw/JsdM2jiP", true))()
Lib.options.underlinecolor = "rainbow"


local Main, Misc, Visuals, Settings, Credits = Lib:CreateWindow("Main"), Lib:CreateWindow("Misc"), Lib:CreateWindow("Visuals"), Lib:CreateWindow("Settings"), Lib:CreateWindow("Credits")


-- [[   Credits    ]] --
Credits:Section("- Credits -")
Credits:Label("Made by: Sino#4162")
Credits:Label("UI Lib: pastebin.com/raw/JsdM2jiP")
Credits:Button("Copy UI Lib", function()
    setclipboard("https://pastebin.com/raw/JsdM2jiP")
end)



-- [[   Settings    ]] --
Settings:Section("- KeyBinds -")
Settings:Bind('Toggle UI', {kbonly = true, location = LibUtil, flag = 'ToggleUI', default = Enum.KeyCode.RightControl}, function()
    local ui = game:GetService("CoreGui").ScreenGui
    if ui then
        ui.Enabled = not ui.Enabled
    end
end)
Settings:Section('- Close UI -')
Settings:Button('Destroy UI', function()
    game:GetService("CoreGui").ScreenGui:Destroy()
end)
Settings:Button('Destroy Script', function()
    getgenv().UnloadWX()
end)
Settings:Section('- Default -')
Settings:Button('Reset Script', function()
    getgenv().UnloadWX()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Sino1507/WolfX/main/index.lua", true))()
end)



-- [[   Misc    ]] --
MyUtil["WalkSpeed"] = 16
MyUtil["JumpPower"] = 50
Misc:Section("- Character Adjustments -")
Misc:Slider("Walkspeed", {location = LibUtil, flag = 'WSSpeed', default = 16, precise = false, min = 1, max = 250}, function(value)
    print("[WX] WalkSpeed set to: " .. value)
    MyUtil["WalkSpeed"] = value
end)
Misc:Box("Custom WS", {location = LibUtil, flag = 'CustomWalkspeed', default = 16, min = 1}, function(value)
    print("[WX] WalkSpeed set to: " .. value)
    MyUtil["WalkSpeed"] = value
end)
Misc:Slider("JumpPower", {location = LibUtil, flag = 'JPower', default = 50, precise = false, min = 1, max = 250}, function(value)
    print("[WX] JumpPower set to: " .. value)
    MyUtil["JumpPower"] = value
end)
Misc:Box("Custom JP", {location = LibUtil, flag = 'CustomJumpPower', default = 50, min = 1}, function(value)
    print("[WX] JumpPower set to: " .. value)
    MyUtil["JumpPower"] = value
end)



-- [[   Visuals    ]] --
Visuals:Section("- Human ESP -")
Visuals:Toggle("Wolf ESP", {location = LibUtil, default = false, flag = "WolfESP"}, function(s)
    local x = s and "On" or "Off"
    print("[WX] Wolf ESP: " .. x)

    MyUtil["WolfESP"] = s
end)
Visuals:Toggle("Sheriff ESP", {location = LibUtil, default = false, flag = "SheriffESP"}, function(s)
    local x = s and "On" or "Off"
    print("[WX] Sheriff ESP: " .. x)

    MyUtil["SheriffESP"] = s
end)
Visuals:Toggle("Players ESP", {location = LibUtil, default = false, flag = "PlayersESP"}, function(s)
    local x = s and "On" or "Off"
    print("[WX] Players ESP: " .. x)

    MyUtil["PlayersESP"] = s
end)
Visuals:Section("- Item ESP -")
Visuals:Toggle("Dropped Gun ESP", {location = LibUtil, default = false, flag = "DroppedGunESP"}, function(s)
    local x = s and "On" or "Off"
    print("[WX] Dropped Gun ESP: " .. x)

    MyUtil["DroppedGunESP"] = s
end)
Visuals:Toggle("Golden Bag ESP", {location = LibUtil, default = false, flag = "GoldenBagESP"}, function(s)
    local x = s and "On" or "Off"
    print("[WX] Golden Bag ESP: " .. x)

    MyUtil["GoldenBagESP"] = s
end)



-- [[   Loop Connections    ]] --
function esp(toDisplay, color, opacity)
    -- Loop the toDisplay table and create a 'BoxHandleAdornment' for each item
    -- The 'BoxHandleAdornment' will be named 'ChamWX' and the color will be 'color' and the transparency will be 'opacity'
    -- Before creating the 'BoxHandleAdornment', we will check if the item has a 'ChamWX' already. If it does, we will destroy it and create a new one.
    -- If the item doesn't have a 'ChamWX', we will create a new one.
    -- We will also check if the item is a 'Player' and if it is, we will check if the item is a 'LocalPlayer'. If it is, we will not create a 'BoxHandleAdornment' for it.
    if #toDisplay == #players:GetPlayers() then
        for i,v in pairs(toDisplay) do
            if v and v.Parent then
                if v:IsA("Player") then
                    if v ~= player and v ~= MyUtil["Wolf"] and v ~= MyUtil["Hunter"] then
                        if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                            if v.Character:FindFirstChild("ChamWX") then
                                v.Character.ChamWX:Destroy()
                            end

                            local cham = Instance.new("BoxHandleAdornment")
                            cham.Parent = v.Character.HumanoidRootPart
                            cham.ZIndex = 10
                            cham.Adornee = v.Character.HumanoidRootPart
                            cham.AlwaysOnTop = true
                            cham.Size = v.Character.HumanoidRootPart.Size
                            cham.Transparency = opacity
                            cham.Color3 = color
                            cham.Name = 'ChamWX'
                        end
                    end
                end
            end
        end
    else
        for i,v in pairs(toDisplay) do
            if v and v.Parent then
                if v:IsA("Player") then
                    if v ~= player then
                        if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                            if v.Character:FindFirstChild("ChamWX") then
                                v.Character.ChamWX:Destroy()
                            end

                            local cham = Instance.new("BoxHandleAdornment")
                            cham.Parent = v.Character.HumanoidRootPart
                            cham.ZIndex = 10
                            cham.Adornee = v.Character.HumanoidRootPart
                            cham.AlwaysOnTop = true
                            cham.Size = v.Character.HumanoidRootPart.Size
                            cham.Transparency = opacity
                            cham.Color3 = color
                            cham.Name = 'ChamWX'
                        end
                    end
                else

                    if v:FindFirstChild("ChamWX") then
                        v.ChamWX:Destroy()
                    end

                    local cham = Instance.new("BoxHandleAdornment")
                    cham.Parent = v
                    cham.ZIndex = 10
                    cham.Adornee = v
                    cham.AlwaysOnTop = true
                    cham.Size = v.Size
                    cham.Transparency = opacity
                    cham.Color3 = color
                    cham.Name = 'ChamWX'
                end
            end
        end
    end
end

table.insert(connections, game:GetService("RunService").RenderStepped:Connect(function()
    if game.Players.LocalPlayer:FindFirstChild("Character") then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = MyUtil["WalkSpeed"]
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = MyUtil["JumpPower"]
    end

    MyUtil["Hunter"] = ""
    MyUtil["Wolf"] = ""

    for i, v in pairs(game:GetService("ReplicatedStorage").Wolves:GetChildren()) do
        if v and v.Name ~= player.Name then
            MyUtil["Wolf"] = players:FindFirstChild(v.Name)
        end
    end
    for i, v in pairs(game:GetService("ReplicatedStorage").Hunters:GetChildren()) do
        if v and v.Name ~= player.Name then
            MyUtil["Hunter"] = players:FindFirstChild(v.Name)
        end
    end

    if MyUtil["Hunter"] == "" then
        for i, v in pairs(game.Players:GetPlayers()) do
            if v and v.Name ~= player.Name and v.Character:FindFirstChildOfClass("Tool") or v and v.Name ~= player.Name and #v.Backpack:GetChildren() > 0 then
                MyUtil["Hunter"] = players:FindFirstChild(v.Name)
            end
        end
    end

    
    if MyUtil["WolfESP"] and MyUtil["Wolf"] ~= "" and MyUtil["Wolf"].Character and not MyUtil["Wolf"].Character.HumanoidRootPart:FindFirstChild("ChamWX") then
        local wolf = {MyUtil["Wolf"]}
        esp(wolf, Color3.fromRGB(255, 0, 0), 0.5)
    end

    if MyUtil["SheriffESP"] and MyUtil["Hunter"] ~= "" and MyUtil["Hunter"].Character and not MyUtil["Hunter"].Character.HumanoidRootPart:FindFirstChild("ChamWX") then
        local sheriff = {MyUtil["Hunter"]}
        esp(sheriff, Color3.fromRGB(0, 0, 255), 0.5)
    end

    if MyUtil["PlayersESP"] then
        local players = players:GetPlayers()
        esp(players, Color3.fromRGB(0, 255, 0), 0.5)
    end

    if MyUtil["DroppedGunESP"] and workspace.EffectsBin:FindFirstChild("Handle") and not workspace.EffectsBin.Handle:FindFirstChild("ChamWX") then
        local droppedguns = {workspace.EffectsBin.Handle} 
        esp(droppedguns, Color3.fromRGB(255, 255, 0), 0.5)
    end

    if MyUtil["GoldenBagESP"] and workspace.EffectsBin:FindFirstChild("CollectableItem") and not workspace.EffectsBin.CollectableItem:FindFirstChild("ChamWX") then
        local goldenbags = {workspace.EffectsBin.CollectableItem}
        esp(goldenbags, Color3.fromRGB(255, 255, 255), 0.5)
    end
end))

