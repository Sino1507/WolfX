assert(Drawing, "Exploit not supported!")


if getgenv().IsInjectedWX == true then
    getgenv().UnloadWX()
else
    getgenv().IsInjectedWX = true
end



local plrs = {}
local MyUtil = {}
local LibUtil = {}
local connections = {}


local workspace, repstorage, players = game:GetService("Workspace"), game:GetService("ReplicatedStorage"), game:GetService("Players")
local player, camera = players.LocalPlayer, workspace.CurrentCamera

local Lib = loadstring(game:HttpGet("https://pastebin.com/raw/JsdM2jiP", true))()
Lib.options.underlinecolor = "rainbow"


local Main, Misc, Visuals, Settings, Credits = Lib:CreateWindow("Main"), Lib:CreateWindow("Misc"), Lib:CreateWindow("Visuals"), Lib:CreateWindow("Settings"), Lib:CreateWindow("Credits")


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

    getgenv().IsInjectedWX = false
end


-- [[   Credits    ]] --
Credits:Section("- Credits -")
Credits:Label("Made by: Sino#4162")
Credits:Label("UI Lib: pastebin.com/raw/JsdM2jiP")
Credits:Button("Copy UI Lib", function()
    setclipboard("https://pastebin.com/raw/JsdM2jiP")
end)


function unloadESP(module)
    if module:IsA("Player") then
        if module.Character and module.Character:FindFirstChild("HumanoidRootPart") then
            if module.Character.HumanoidRootPart:FindFirstChild("ChamWX") then
                module.Character.HumanoidRootPart.ChamWX:Destroy()
            end
        end
    else
        if module and module:FindFirstChild("ChamWX") then
            module.ChamWX:Destroy()
        end
    end
end

function unloadAllESP()
    for i, p in pairs(players:GetPlayers()) do
        if p ~= player then
            unloadESP(p)
        end
    end

    if workspace.EffectsBin:FindFirstChild("CollectableItem") then
        unloadESP(workspace.EffectsBin.CollectableItem)
    end
    if workspace.EffectsBin:FindFirstChild("Handle") then
        unloadESP(workspace.EffectsBin.Handle)
    end
end

function unloadAllPlayersESP()
    for i, p in pairs(players:GetPlayers()) do
        if p ~= player and p ~= MyUtil["Wolf"] and p ~= MyUtil["Hunter"] then
            unloadESP(p)
        end
    end
end

function unloadWolfESP()
    unloadESP(MyUtil["Wolf"])
end

function unloadSheriffESP()
    unloadESP(MyUtil["Hunter"])
end

function unloadCollectableESP()
    if workspace.EffectsBin:FindFirstChild("CollectableItem") then
        unloadESP(workspace.EffectsBin.CollectableItem)
    end
end

function unloadWeaponESP()
    if workspace.EffectsBin:FindFirstChild("Handle") then
        unloadESP(workspace.EffectsBin.Handle)
    end
end

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
    unloadAllESP()
end)
Settings:Section('- Default -')
Settings:Button('Reset Script', function()
    getgenv().UnloadWX()
    unloadAllESP()
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

    if s == false then
        unloadWolfESP()
    end
end)
Visuals:Toggle("Sheriff ESP", {location = LibUtil, default = false, flag = "SheriffESP"}, function(s)
    local x = s and "On" or "Off"
    print("[WX] Sheriff ESP: " .. x)

    MyUtil["SheriffESP"] = s

    if s == false then
        unloadSheriffESP()
    end
end)
Visuals:Toggle("Players ESP", {location = LibUtil, default = false, flag = "PlayersESP"}, function(s)
    local x = s and "On" or "Off"
    print("[WX] Players ESP: " .. x)

    MyUtil["PlayersESP"] = s

    if s == false then
        unloadAllPlayersESP()
    end
end)
Visuals:Section("- Item ESP -")
Visuals:Toggle("Dropped Gun ESP", {location = LibUtil, default = false, flag = "DroppedGunESP"}, function(s)
    local x = s and "On" or "Off"
    print("[WX] Dropped Gun ESP: " .. x)

    MyUtil["DroppedGunESP"] = s

    if s == false then
        unloadWeaponESP()
    end
end)
Visuals:Toggle("Golden Bag ESP", {location = LibUtil, default = false, flag = "GoldenBagESP"}, function(s)
    local x = s and "On" or "Off"
    print("[WX] Golden Bag ESP: " .. x)

    MyUtil["GoldenBagESP"] = s

    if s == false then
        unloadCollectableESP()
    end
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
            if v then
                if v:IsA("Player") then
                    if v ~= player and v ~= MyUtil["Wolf"] and v ~= MyUtil["Hunter"] then
                        if (v.Character) and v.Character:FindFirstChild("HumanoidRootPart") then
                            if v.Character.HumanoidRootPart:FindFirstChild("ChamWX") then
                                v.Character.HumanoidRootPart.ChamWX:Destroy()
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
                        if (v.Character) and v.Character:FindFirstChild("HumanoidRootPart") then
                            if v.Character.HumanoidRootPart:FindFirstChild("ChamWX") then
                                v.Character.HumanoidRootPart.ChamWX:Destroy()
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

                            --print("[WX] Created cham for: " .. v.Name)
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
    if (game.Players.LocalPlayer.Character) and (game.Players.LocalPlayer.Character.Humanoid) then
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

    if not MyUtil["Hunter"].Character then
        for i, v in pairs(game.Players:GetPlayers()) do
            if v and v.Name ~= player.Name and v.Character then
                for i, obj in pairs(v.Character:GetChildren()) do
                    if obj:IsA("Tool") and obj:FindFirstChild("WeaponEvent") then
                        MyUtil["Hunter"] = v
                    end
                end
            end
            if not (MyUtil["Hunter"].Character) then
                if #v.Backpack:GetChildren() > 0 then
                    for i, obj in pairs(v.Backpack:GetChildren()) do
                        if obj:IsA("Tool") and obj:FindFirstChild("WeaponEvent") then
                            MyUtil["Hunter"] = v
                        end
                    end
                end
            end
        end
    end

    
    if MyUtil["WolfESP"] and MyUtil["Wolf"] ~= "" and (MyUtil["Wolf"].Character) and MyUtil["Wolf"].Character:FindFirstChild("HumanoidRootPart") and not MyUtil["Wolf"].Character.HumanoidRootPart:FindFirstChild("ChamWX") then
        local wolf = {MyUtil["Wolf"]}
        esp(wolf, Color3.fromRGB(255, 0, 0), 0.5)
    end

    if MyUtil["SheriffESP"] and MyUtil["Hunter"] ~= "" and (MyUtil["Hunter"].Character) and MyUtil["Hunter"].Character:FindFirstChild("HumanoidRootPart") and not MyUtil["Hunter"].Character.HumanoidRootPart:FindFirstChild("ChamWX") then
        local sheriff = {MyUtil["Hunter"]}
        esp(sheriff, Color3.fromRGB(0, 0, 255), 0.5)
    end

    if MyUtil["PlayersESP"] then
        local all = players:GetChildren()
        esp(all, Color3.fromRGB(0, 255, 0), 0.5)
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

