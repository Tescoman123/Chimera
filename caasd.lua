-- =====================================================
-- PROJECT CHIMERA - FULLY FIXED EDITION
-- For Solara Executor - Fixed DataModel/Ugc Error
-- =====================================================

-- CRITICAL FIX: Properly wait for game to load ALL services
repeat task.wait() until game:IsLoaded() and game:GetService("Players") and game.Players.LocalPlayer

-- BYPASS: Use raw.githubusercontent.com instead of github.com
local function loadFluent()
    local success, fluent = pcall(function()
        -- Using raw.githubusercontent.com (more reliable for executors)
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/example/main.lua"))()
    end)

    if success and fluent then
        return fluent
    end

    -- Fallback to a different mirror
    success, fluent = pcall(function()
        return loadstring(game:HttpGet("https://cdn.jsdelivr.net/gh/dawid-scripts/Fluent@master/example/main.lua"))()
    end)

    if success and fluent then
        return fluent
    end

    return nil
end

-- Load Fluent
local Fluent = loadFluent()
if not Fluent then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Error",
        Text = "Could not load Fluent UI. Check your connection.",
        Duration = 5
    })
    return
end

-- Load managers from the same source
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/example/saveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/example/InterfaceManager.lua"))()

-- Services - NOW SAFE to access
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Create Window
local Window = Fluent:CreateWindow({
    Title = "Project Chimera | Solara Edition",
    SubTitle = "GitHub Bypass Version",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- =====================================================
-- CONFIGURATION
-- =====================================================
local Config = {
    Aimbot = {
        Enabled = false,
        Key = "E",
        Smoothness = 0.3,
        FOV = 150,
        VisibleCheck = true,
        TeamCheck = true,
        HitPart = "Head",
        Prediction = 0.15,
    },
    ESP = {
        Enabled = true,
        Boxes = true,
        BoxColor = Color3.fromRGB(255, 70, 70),
        HealthBars = true,
        Names = true,
        Distance = true,
        Tracers = false,
        TeamColor = true,
    },
    Visuals = {
        FOVCircle = true,
        CircleColor = Color3.fromRGB(255, 255, 255),
        CircleTransparency = 0.7,
        Crosshair = true,
    }
}

-- =====================================================
-- CREATE TABS AND UI ELEMENTS
-- =====================================================
local AimbotTab = Window:AddTab({ Title = "Aimbot", Icon = "crosshair" })
local ESPTab = Window:AddTab({ Title = "ESP", Icon = "eye" })
local VisualsTab = Window:AddTab({ Title = "Visuals", Icon = "palette" })
local SettingsTab = Window:AddTab({ Title = "Settings", Icon = "settings" })

-- Aimbot Tab
local AimbotSection = AimbotTab:AddSection("Aimbot Controls")
AimbotSection:AddToggle("AimbotToggle", { Title = "Enable Aimbot", Default = Config.Aimbot.Enabled, Callback = function(v) Config.Aimbot.Enabled = v end })
AimbotSection:AddKeypicker("AimbotKey", { Title = "Activation Key", Default = Config.Aimbot.Key, Callback = function(v) Config.Aimbot.Key = v end })
AimbotSection:AddSlider("Smoothness", { Title = "Smoothness", Default = Config.Aimbot.Smoothness, Min = 0.1, Max = 1.0, Callback = function(v) Config.Aimbot.Smoothness = v end })
AimbotSection:AddSlider("FOV", { Title = "FOV", Default = Config.Aimbot.FOV, Min = 30, Max = 300, Callback = function(v) Config.Aimbot.FOV = v end })
AimbotSection:AddDropdown("HitPart", { Title = "Target Part", Values = { "Head", "HumanoidRootPart", "Torso" }, Default = Config.Aimbot.HitPart, Callback = function(v) Config.Aimbot.HitPart = v end })
AimbotSection:AddToggle("VisibleCheck", { Title = "Visibility Check", Default = Config.Aimbot.VisibleCheck, Callback = function(v) Config.Aimbot.VisibleCheck = v end })
AimbotSection:AddToggle("TeamCheck", { Title = "Team Check", Default = Config.Aimbot.TeamCheck, Callback = function(v) Config.Aimbot.TeamCheck = v end })
AimbotSection:AddSlider("Prediction", { Title = "Prediction", Default = Config.Aimbot.Prediction, Min = 0, Max = 0.5, Callback = function(v) Config.Aimbot.Prediction = v end })

-- ESP Tab
local ESPSection = ESPTab:AddSection("ESP Configuration")
ESPSection:AddToggle("ESPToggle", { Title = "Enable ESP", Default = Config.ESP.Enabled, Callback = function(v) Config.ESP.Enabled = v end })
ESPSection:AddToggle("BoxesToggle", { Title = "Box ESP", Default = Config.ESP.Boxes, Callback = function(v) Config.ESP.Boxes = v end })
ESPSection:AddColorpicker("BoxColor", { Title = "Box Color", Default = Config.ESP.BoxColor, Callback = function(v) Config.ESP.BoxColor = v end })
ESPSection:AddToggle("HealthBars", { Title = "Health Bars", Default = Config.ESP.HealthBars, Callback = function(v) Config.ESP.HealthBars = v end })
ESPSection:AddToggle("Names", { Title = "Player Names", Default = Config.ESP.Names, Callback = function(v) Config.ESP.Names = v end })
ESPSection:AddToggle("Distance", { Title = "Distance", Default = Config.ESP.Distance, Callback = function(v) Config.ESP.Distance = v end })
ESPSection:AddToggle("Tracers", { Title = "Tracers", Default = Config.ESP.Tracers, Callback = function(v) Config.ESP.Tracers = v end })
ESPSection:AddToggle("TeamColor", { Title = "Team Colors", Default = Config.ESP.TeamColor, Callback = function(v) Config.ESP.TeamColor = v end })

-- Visuals Tab
local VisualsSection = VisualsTab:AddSection("Visual Overlays")
VisualsSection:AddToggle("FOVCircle", { Title = "Show FOV Circle", Default = Config.Visuals.FOVCircle, Callback = function(v) Config.Visuals.FOVCircle = v end })
VisualsSection:AddColorpicker("CircleColor", { Title = "Circle Color", Default = Config.Visuals.CircleColor, Callback = function(v) Config.Visuals.CircleColor = v end })
VisualsSection:AddSlider("CircleTransparency", { Title = "Circle Transparency", Default = Config.Visuals.CircleTransparency, Min = 0, Max = 1, Callback = function(v) Config.Visuals.CircleTransparency = v end })
VisualsSection:AddToggle("Crosshair", { Title = "Custom Crosshair", Default = Config.Visuals.Crosshair, Callback = function(v) Config.Visuals.Crosshair = v end })

-- Settings Tab
local SettingsSection = SettingsTab:AddSection("Settings")
SettingsSection:AddDropdown("Theme", { Title = "Theme", Values = { "Dark", "Light", "Darker" }, Default = "Dark", Callback = function(v) Window:SetTheme(v) end })
SettingsSection:AddKeypicker("ToggleUI", { Title = "Toggle UI Key", Default = "RightControl" })
SettingsSection:AddButton({ Title = "Save Config", Callback = function() SaveManager:Save() end })
SettingsSection:AddButton({ Title = "Load Config", Callback = function() SaveManager:Load() end })

-- =====================================================
-- CORE ENGINE
-- =====================================================

-- Check Drawing support
if not Drawing then
    Fluent:Notify({ Title = "Error", Content = "Drawing library missing", Duration = 5 })
    return
end

-- ESP Objects
local espObjects = {}

local function CreateESP(player)
    if espObjects[player] then return end

    local esp = {
        Box = Drawing.new("Square"),
        Name = Drawing.new("Text"),
        Health = Drawing.new("Text"),
        Distance = Drawing.new("Text"),
        Tracer = Drawing.new("Line"),
    }

    for _, obj in pairs(esp) do
        if obj then
            obj.Visible = false
            obj.Center = true
            obj.Outline = true
            obj.OutlineColor = Color3.new(0,0,0)
            obj.Size = 16
        end
    end

    esp.Box.Thickness = 2
    esp.Name.Font = 2
    esp.Health.Font = 1
    esp.Distance.Font = 1
    esp.Tracer.Thickness = 1

    espObjects[player] = esp
end

-- Initialize ESP
Players.PlayerAdded:Connect(CreateESP)
for _, player in pairs(Players:GetPlayers()) do
    CreateESP(player)
end

-- Utility functions
local function IsAlive(player)
    return player and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0
end

local function IsVisible(startPos, targetPart)
    if not Config.Aimbot.VisibleCheck then return true end
    local ray = Ray.new(startPos, (targetPart.Position - startPos).Unit * 1000)
    local hit = workspace:FindPartOnRay(ray, LocalPlayer.Character)
    return hit and hit:IsDescendantOf(targetPart.Parent) or false
end

local function GetClosestTarget()
    local closest, closestDist = nil, Config.Aimbot.FOV
    local localChar = LocalPlayer.Character
    if not localChar then return nil end

    local localRoot = localChar:FindFirstChild("HumanoidRootPart")
    if not localRoot then return nil end

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and IsAlive(player) then
            if Config.Aimbot.TeamCheck and player.Team == LocalPlayer.Team then
                continue
            end

            local targetPart = player.Character:FindFirstChild(Config.Aimbot.HitPart) or player.Character:FindFirstChild("HumanoidRootPart")
            if targetPart then
                local dist = (targetPart.Position - localRoot.Position).Magnitude
                if dist < Config.Aimbot.FOV then
                    if Config.Aimbot.VisibleCheck then
                        if not IsVisible(localRoot.Position, targetPart) then
                            continue
                        end
                    end
                    
                    local screenPos = Camera:WorldToViewportPoint(targetPart.Position)
                    local screenDist = (Vector2.new(screenPos.X, screenPos.Y) - (Camera.ViewportSize/2)).Magnitude
                    
                    if screenDist < closestDist then
                        closestDist = screenDist
                        closest = player
                    end
                end
            end
        end
    end

    return closest
end

-- FOV Circle
local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = Config.Visuals.FOVCircle
FOVCircle.Thickness = 1
FOVCircle.NumSides = 64
FOVCircle.Radius = Config.Aimbot.FOV
FOVCircle.Filled = false
FOVCircle.Transparency = Config.Visuals.CircleTransparency
FOVCircle.Color = Config.Visuals.CircleColor

-- Crosshair
local CrosshairX = Drawing.new("Line")
local CrosshairY = Drawing.new("Line")
CrosshairX.Color = Color3.new(1,1,1)
CrosshairY.Color = Color3.new(1,1,1)
CrosshairX.Thickness = 2
CrosshairY.Thickness = 2

-- Main loop
RunService.RenderStepped:Connect(function()
    -- Update FOV Circle
    FOVCircle.Position = Camera.ViewportSize / 2
    FOVCircle.Radius = Config.Aimbot.FOV
    FOVCircle.Visible = Config.Visuals.FOVCircle
    FOVCircle.Transparency = Config.Visuals.CircleTransparency
    FOVCircle.Color = Config.Visuals.CircleColor

    -- Update Crosshair
    if Config.Visuals.Crosshair then
        local center = Camera.ViewportSize / 2
        CrosshairX.From = Vector2.new(center.X - 10, center.Y)
        CrosshairX.To = Vector2.new(center.X + 10, center.Y)
        CrosshairY.From = Vector2.new(center.X, center.Y - 10)
        CrosshairY.To = Vector2.new(center.X, center.Y + 10)
        CrosshairX.Visible = true
        CrosshairY.Visible = true
    else
        CrosshairX.Visible = false
        CrosshairY.Visible = false
    end

    -- ESP Update
    if Config.ESP.Enabled then
        for player, esp in pairs(espObjects) do
            if IsAlive(player) and player ~= LocalPlayer then
                local root = player.Character:FindFirstChild("HumanoidRootPart")
                local head = player.Character:FindFirstChild("Head")

                if root and head then
                    local pos, onScreen = Camera:WorldToViewportPoint(root.Position)
                    if onScreen then
                        local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0,1.5,0))
                        local height = math.abs(headPos.Y - pos.Y) * 2
                        local width = height * 0.6
                        
                        -- Box
                        if Config.ESP.Boxes then
                            esp.Box.Visible = true
                            esp.Box.Position = Vector2.new(pos.X - width/2, headPos.Y - height/2)
                            esp.Box.Size = Vector2.new(width, height)
                            esp.Box.Color = Config.ESP.TeamColor and player.TeamColor.Color or Config.ESP.BoxColor
                        else
                            esp.Box.Visible = false
                        end
                        
                        -- Name
                        if Config.ESP.Names then
                            esp.Name.Visible = true
                            esp.Name.Position = Vector2.new(pos.X, headPos.Y - height/2 - 20)
                            esp.Name.Text = player.Name
                            esp.Name.Color = Config.ESP.TeamColor and player.TeamColor.Color or Config.ESP.BoxColor
                        else
                            esp.Name.Visible = false
                        end
                        
                        -- Tracer
                        if Config.ESP.Tracers then
                            esp.Tracer.Visible = true
                            esp.Tracer.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                            esp.Tracer.To = Vector2.new(pos.X, pos.Y)
                            esp.Tracer.Color = Config.ESP.TeamColor and player.TeamColor.Color or Config.ESP.BoxColor
                        else
                            esp.Tracer.Visible = false
                        end
                    else
                        esp.Box.Visible = false
                        esp.Name.Visible = false
                        esp.Tracer.Visible = false
                    end
                else
                    esp.Box.Visible = false
                    esp.Name.Visible = false
                    esp.Tracer.Visible = false
                end
            else
                esp.Box.Visible = false
                esp.Name.Visible = false
                esp.Tracer.Visible = false
            end
        end
    else
        for _, esp in pairs(espObjects) do
            esp.Box.Visible = false
            esp.Name.Visible = false
            esp.Tracer.Visible = false
        end
    end

    -- Aimbot
    if Config.Aimbot.Enabled and UserInputService:IsKeyDown(Enum.KeyCode[Config.Aimbot.Key]) then
        local target = GetClosestTarget()
        if target and target.Character then
            local targetPart = target.Character:FindFirstChild(Config.Aimbot.HitPart) or target.Character:FindFirstChild("HumanoidRootPart")
            if targetPart then
                -- Prediction
                local velocity = Vector3.new(0,0,0)
                if targetPart:FindFirstChild("Velocity") then
                    velocity = targetPart.Velocity.Value * Config.Aimbot.Prediction
                end
                
                local targetPos = targetPart.Position + velocity
                local screenPos = Camera:WorldToViewportPoint(targetPos)
                local currentPos = Vector2.new(Mouse.X, Mouse.Y)
                local delta = Vector2.new(screenPos.X, screenPos.Y) - currentPos
                local moveDelta = delta * (1 - Config.Aimbot.Smoothness)

                if mousemoverel then
                    mousemoverel(moveDelta.X, moveDelta.Y)
                end
            end
        end
    end
end)

-- Initialize managers
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
InterfaceManager:SetFolder("ProjectChimera")
SaveManager:SetFolder("ProjectChimera")

-- Success notification
Fluent:Notify({
    Title = "Project Chimera",
    Content = "Loaded successfully - DataModel fix applied",
    Duration = 3
})

print("[+] Project Chimera loaded on Solara with DataModel fix")
