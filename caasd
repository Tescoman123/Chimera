-- =====================================================
-- PROJECT CHIMERA - GUI ENHANCED EDITION
-- For Solara Executor - Tested 2025/2026
-- Features: Full GUI with toggles, sliders, color pickers
-- =====================================================

-- Wait for game to load
repeat wait() until game:IsLoaded() and game.Players.LocalPlayer

-- Load Fluent UI Library (Modern, sleek, executor-compatible)
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/saveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/InterfaceManager.lua"))()

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Window Creation
local Window = Fluent:CreateWindow({
    Title = "Project Chimera " .. "| Solara Edition",
    SubTitle = "by your fren | External Vision Suite",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Tabs
local AimbotTab = Window:AddTab({ Title = "Aimbot", Icon = "crosshair" })
local ESPTab = Window:AddTab({ Title = "ESP", Icon = "eye" })
local VisualsTab = Window:AddTab({ Title = "Visuals", Icon = "palette" })
local SettingsTab = Window:AddTab({ Title = "Settings", Icon = "settings" })

-- =====================================================
-- CONFIGURATION SYSTEM
-- =====================================================
local Config = {
    -- Aimbot Settings
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
    
    -- ESP Settings
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
    
    -- Visual Settings
    Visuals = {
        FOVCircle = true,
        CircleColor = Color3.fromRGB(255, 255, 255),
        CircleTransparency = 0.7,
        Crosshair = true,
    }
}

-- =====================================================
-- AIMBOT SECTION
-- =====================================================
local AimbotSection = AimbotTab:AddSection("Aimbot Controls")

-- Toggle Aimbot
AimbotSection:AddToggle("AimbotToggle", {
    Title = "Enable Aimbot",
    Description = "Master toggle for aim assistance",
    Default = Config.Aimbot.Enabled,
    Callback = function(value)
        Config.Aimbot.Enabled = value
    end
})

-- Keybind Picker
AimbotSection:AddKeypicker("AimbotKey", {
    Title = "Activation Key",
    Description = "Hold this key to aim",
    Default = Config.Aimbot.Key,
    Callback = function(value)
        Config.Aimbot.Key = value
    end
})

-- Smoothness Slider
AimbotSection:AddSlider("Smoothness", {
    Title = "Aim Smoothness",
    Description = "Lower = snappy | Higher = smooth",
    Default = Config.Aimbot.Smoothness,
    Min = 0.1,
    Max = 1.0,
    Rounding = 2,
    Callback = function(value)
        Config.Aimbot.Smoothness = value
    end
})

-- FOV Slider
AimbotSection:AddSlider("FOV", {
    Title = "Aim FOV",
    Description = "Detection radius (studs)",
    Default = Config.Aimbot.FOV,
    Min = 30,
    Max = 300,
    Rounding = 0,
    Callback = function(value)
        Config.Aimbot.FOV = value
    end
})

-- Hit Part Dropdown
AimbotSection:AddDropdown("HitPart", {
    Title = "Target Part",
    Description = "Which body part to aim at",
    Values = { "Head", "HumanoidRootPart", "Torso", "UpperTorso" },
    Default = Config.Aimbot.HitPart,
    Callback = function(value)
        Config.Aimbot.HitPart = value
    end
})

-- Toggles Row
AimbotSection:AddToggle("VisibleCheck", {
    Title = "Visibility Check",
    Description = "Only aim if target is visible",
    Default = Config.Aimbot.VisibleCheck,
    Callback = function(value)
        Config.Aimbot.VisibleCheck = value
    end
})

AimbotSection:AddToggle("TeamCheck", {
    Title = "Team Check",
    Description = "Ignore teammates",
    Default = Config.Aimbot.TeamCheck,
    Callback = function(value)
        Config.Aimbot.TeamCheck = value
    end
})

-- Prediction Slider
AimbotSection:AddSlider("Prediction", {
    Title = "Movement Prediction",
    Description = "Lead moving targets",
    Default = Config.Aimbot.Prediction,
    Min = 0,
    Max = 0.5,
    Rounding = 2,
    Callback = function(value)
        Config.Aimbot.Prediction = value
    end
})

-- =====================================================
-- ESP SECTION
-- =====================================================
local ESPSection = ESPTab:AddSection("ESP Configuration")

-- Master ESP Toggle
ESPSection:AddToggle("ESPToggle", {
    Title = "Enable ESP",
    Description = "Show player information",
    Default = Config.ESP.Enabled,
    Callback = function(value)
        Config.ESP.Enabled = value
    end
})

-- Box Toggle
ESPSection:AddToggle("BoxesToggle", {
    Title = "Box ESP",
    Description = "Draw boxes around players",
    Default = Config.ESP.Boxes,
    Callback = function(value)
        Config.ESP.Boxes = value
    end
})

-- Box Color Picker
ESPSection:AddColorpicker("BoxColor", {
    Title = "Box Color",
    Description = "Color of ESP boxes",
    Default = Config.ESP.BoxColor,
    Callback = function(value)
        Config.ESP.BoxColor = value
    end
})

-- Health Bars Toggle
ESPSection:AddToggle("HealthBars", {
    Title = "Health Bars",
    Description = "Show player health",
    Default = Config.ESP.HealthBars,
    Callback = function(value)
        Config.ESP.HealthBars = value
    end
})

-- Names Toggle
ESPSection:AddToggle("Names", {
    Title = "Player Names",
    Description = "Show names above players",
    Default = Config.ESP.Names,
    Callback = function(value)
        Config.ESP.Names = value
    end
})

-- Distance Toggle
ESPSection:AddToggle("Distance", {
    Title = "Distance",
    Description = "Show distance to players",
    Default = Config.ESP.Distance,
    Callback = function(value)
        Config.ESP.Distance = value
    end
})

-- Tracers Toggle
ESPSection:AddToggle("Tracers", {
    Title = "Tracers",
    Description = "Lines from bottom screen to players",
    Default = Config.ESP.Tracers,
    Callback = function(value)
        Config.ESP.Tracers = value
    end
})

-- Team Color Toggle
ESPSection:AddToggle("TeamColor", {
    Title = "Use Team Colors",
    Description = "Boxes match player team color",
    Default = Config.ESP.TeamColor,
    Callback = function(value)
        Config.ESP.TeamColor = value
    end
})

-- =====================================================
-- VISUALS SECTION
-- =====================================================
local VisualsSection = VisualsTab:AddSection("Visual Overlays")

-- FOV Circle Toggle
VisualsSection:AddToggle("FOVCircle", {
    Title = "Show FOV Circle",
    Description = "Display aimbot detection radius",
    Default = Config.Visuals.FOVCircle,
    Callback = function(value)
        Config.Visuals.FOVCircle = value
    end
})

-- Circle Color Picker
VisualsSection:AddColorpicker("CircleColor", {
    Title = "Circle Color",
    Description = "Color of FOV circle",
    Default = Config.Visuals.CircleColor,
    Callback = function(value)
        Config.Visuals.CircleColor = value
    end
})

-- Circle Transparency Slider
VisualsSection:AddSlider("CircleTransparency", {
    Title = "Circle Transparency",
    Description = "0 = solid, 1 = invisible",
    Default = Config.Visuals.CircleTransparency,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Callback = function(value)
        Config.Visuals.CircleTransparency = value
    end
})

-- Crosshair Toggle
VisualsSection:AddToggle("Crosshair", {
    Title = "Custom Crosshair",
    Description = "Replace game crosshair",
    Default = Config.Visuals.Crosshair,
    Callback = function(value)
        Config.Visuals.Crosshair = value
    end
})

-- =====================================================
-- SETTINGS SECTION
-- =====================================================
local SettingsSection = SettingsTab:AddSection("Interface Settings")

-- UI Theme Selector
SettingsSection:AddDropdown("Theme", {
    Title = "Theme",
    Description = "Change UI appearance",
    Values = { "Dark", "Light", "Darker", "Midnight", "Amethyst" },
    Default = "Dark",
    Callback = function(value)
        Window:SetTheme(value)
    end
})

-- UI Scale Slider
SettingsSection:AddSlider("UIScale", {
    Title = "UI Scale",
    Description = "Adjust window size",
    Default = 1,
    Min = 0.5,
    Max = 2,
    Rounding = 1,
    Callback = function(value)
        Window:SetScale(value)
    end
})

-- Toggle UI Keybind
SettingsSection:AddKeypicker("ToggleUI", {
    Title = "Toggle UI Key",
    Description = "Show/hide this window",
    Default = "RightControl",
    Callback = function(value)
        -- Handled by Fluent internally
    end
})

-- Save/Load Buttons
SettingsSection:AddButton({
    Title = "Save Configuration",
    Description = "Save current settings",
    Callback = function()
        SaveManager:Save()
        Fluent:Notify({
            Title = "Saved",
            Content = "Configuration saved successfully",
            Duration = 3
        })
    end
})

SettingsSection:AddButton({
    Title = "Load Configuration",
    Description = "Load saved settings",
    Callback = function()
        SaveManager:Load()
        Fluent:Notify({
            Title = "Loaded",
            Content = "Configuration loaded",
            Duration = 3
        })
    end
})

-- =====================================================
-- CORE ENGINE
-- =====================================================

-- Check executor compatibility
if not Drawing then
    Fluent:Notify({
        Title = "Error",
        Content = "Executor missing Drawing library. Switch to Solara or better executor.",
        Duration = 10
    })
    return
end

-- Utility functions
local function IsAlive(player)
    return player and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0
end

local function IsVisible(startPos, targetPart)
    if not Config.Aimbot.VisibleCheck then return true end
    
    local ray = Ray.new(startPos, (targetPart.Position - startPos).Unit * 1000)
    local hit, pos = workspace:FindPartOnRay(ray, LocalPlayer.Character)
    
    if hit then
        return hit:IsDescendantOf(targetPart.Parent)
    end
    return false
end

-- ESP Objects storage
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
            obj.OutlineColor = Color3.new(0, 0, 0)
            obj.Size = 16
        end
    end
    
    esp.Box.Thickness = 2
    esp.Name.Font = 2
    esp.Health.Font = 1
    esp.Distance.Font = 1
    
    espObjects[player] = esp
end

-- Initialize ESP for all players
Players.PlayerAdded:Connect(CreateESP)
for _, player in pairs(Players:GetPlayers()) do
    CreateESP(player)
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

-- Custom Crosshair
local CrosshairX = Drawing.new("Line")
local CrosshairY = Drawing.new("Line")
CrosshairX.Visible = Config.Visuals.Crosshair
CrosshairY.Visible = Config.Visuals.Crosshair
CrosshairX.Color = Color3.new(1, 1, 1)
CrosshairY.Color = Color3.new(1, 1, 1)
CrosshairX.Thickness = 2
CrosshairY.Thickness = 2
CrosshairX.Transparency = 1
CrosshairY.Transparency = 1

-- Key state tracking
local keys = {
    E = Enum.KeyCode.E,
    Q = Enum.KeyCode.Q,
    LeftShift = Enum.KeyCode.LeftShift,
    RightShift = Enum.KeyCode.RightShift,
    LeftControl = Enum.KeyCode.LeftControl,
    X = Enum.KeyCode.X,
    C = Enum.KeyCode.C,
    V = Enum.KeyCode.V,
    F = Enum.KeyCode.F,
    G = Enum.KeyCode.G,
}

-- Get current key from string
local function GetKeyCode(keyStr)
    if keys[keyStr] then return keys[keyStr] end
    -- Try to convert any string to Enum.KeyCode
    for _, enum in pairs(Enum.KeyCode:GetEnumItems()) do
        if enum.Name == keyStr then
            return enum
        end
    end
    return Enum.KeyCode.E -- Default
end

-- Aimbot target selection
local function GetClosestTarget()
    local closest = nil
    local shortestDistance = Config.Aimbot.FOV
    
    local localChar = LocalPlayer.Character
    if not localChar then return nil end
    
    local localRoot = localChar:FindFirstChild("HumanoidRootPart")
    if not localRoot then return nil end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and IsAlive(player) then
            -- Team check
            if Config.Aimbot.TeamCheck and player.Team == LocalPlayer.Team then
                continue
            end
            
            local character = player.Character
            local targetPart = character:FindFirstChild(Config.Aimbot.HitPart)
            if not targetPart then
                targetPart = character:FindFirstChild("HumanoidRootPart")
            end
            if not targetPart then continue end
            
            -- Distance check
            local distance = (targetPart.Position - localRoot.Position).Magnitude
            if distance > Config.Aimbot.FOV then continue end
            
            -- Visibility check
            if Config.Aimbot.VisibleCheck then
                local visible = IsVisible(localRoot.Position, targetPart)
                if not visible then continue end
            end
            
            -- Screen position check
            local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
            if onScreen then
                local screenDistance = (Vector2.new(screenPos.X, screenPos.Y) - (Camera.ViewportSize / 2)).Magnitude
                if screenDistance < shortestDistance then
                    shortestDistance = screenDistance
                    closest = player
                end
            end
        end
    end
    
    return closest
end

-- ESP Update function
local function UpdateESP()
    if not Config.ESP.Enabled then
        for _, esp in pairs(espObjects) do
            for _, obj in pairs(esp) do
                if obj then obj.Visible = false end
            end
        end
        return
    end
    
    for player, esp in pairs(espObjects) do
        if IsAlive(player) and player ~= LocalPlayer then
            local character = player.Character
            local root = character:FindFirstChild("HumanoidRootPart")
            local head = character:FindFirstChild("Head")
            local humanoid = character:FindFirstChild("Humanoid")
            
            if root and head and humanoid then
                local rootPos, onScreen = Camera:WorldToViewportPoint(root.Position)
                local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 1.5, 0))
                
                if onScreen then
                    local boxHeight = math.abs(headPos.Y - rootPos.Y) * 2
                    local boxWidth = boxHeight * 0.6
                    local boxY = headPos.Y - boxHeight / 2
                    local boxX = rootPos.X - boxWidth / 2
                    
                    -- Get color based on settings
                    local boxColor = Config.ESP.BoxColor
                    if Config.ESP.TeamColor then
                        boxColor = player.TeamColor.Color
                    end
                    
                    -- Box ESP
                    if Config.ESP.Boxes then
                        esp.Box.Visible = true
                        esp.Box.Position = Vector2.new(boxX, boxY)
                        esp.Box.Size = Vector2.new(boxWidth, boxHeight)
                        esp.Box.Color = boxColor
                    else
                        esp.Box.Visible = false
                    end
                    
                    -- Name ESP
                    if Config.ESP.Names then
                        esp.Name.Visible = true
                        esp.Name.Position = Vector2.new(rootPos.X, boxY - 20)
                        esp.Name.Text = player.Name
                        esp.Name.Color = boxColor
                    else
                        esp.Name.Visible = false
                    end
                    
                    -- Health ESP
                    if Config.ESP.HealthBars and humanoid then
                        esp.Health.Visible = true
                        esp.Health.Position = Vector2.new(rootPos.X, boxY + boxHeight + 5)
                        esp.Health.Text = string.format("❤️ %d/%d", math.floor(humanoid.Health), math.floor(humanoid.MaxHealth))
                        esp.Health.Color = Color3.fromRGB(0, 255, 0)
                    else
                        esp.Health.Visible = false
                    end
                    
                    -- Distance ESP
                    if Config.ESP.Distance and root and LocalPlayer.Character then
                        local localRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if localRoot then
                            local dist = (root.Position - localRoot.Position).Magnitude
                            esp.Distance.Visible = true
                            esp.Distance.Position = Vector2.new(rootPos.X, boxY - 40)
                            esp.Distance.Text = string.format("📏 %d studs", math.floor(dist))
                            esp.Distance.Color = boxColor
                        end
                    else
                        esp.Distance.Visible = false
                    end
                    
                    -- Tracers
                    if Config.ESP.Tracers then
                        esp.Tracer.Visible = true
                        esp.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                        esp.Tracer.To = Vector2.new(rootPos.X, rootPos.Y)
                        esp.Tracer.Color = boxColor
                    else
                        esp.Tracer.Visible = false
                    end
                else
                    for _, obj in pairs(esp) do
                        if obj then obj.Visible = false end
                    end
                end
            else
                for _, obj in pairs(esp) do
                    if obj then obj.Visible = false end
                end
            end
        else
            for _, obj in pairs(esp) do
                if obj then obj.Visible = false end
            end
        end
    end
end

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
    
    -- Update ESP
    UpdateESP()
    
    -- Aimbot logic
    if Config.Aimbot.Enabled and UserInputService:IsKeyDown(GetKeyCode(Config.Aimbot.Key)) then
        local target = GetClosestTarget()
        if target then
            local character = target.Character
            local targetPart = character:FindFirstChild(Config.Aimbot.HitPart) or character:FindFirstChild("HumanoidRootPart")
            
            if targetPart then
                -- Simple prediction
                local velocity = Vector3.new(0, 0, 0)
                if targetPart:FindFirstChild("Velocity") then
                    velocity = targetPart.Velocity.Value * Config.Aimbot.Prediction
                end
                
                local targetPos = targetPart.Position + velocity
                local screenPos = Camera:WorldToViewportPoint(targetPos)
                
                -- Move mouse
                local currentPos = Vector2.new(Mouse.X, Mouse.Y)
                local targetScreen = Vector2.new(screenPos.X, screenPos.Y)
                local delta = targetScreen - currentPos
                local moveDelta = delta * (1 - Config.Aimbot.Smoothness)
                
                -- Executor mouse movement
                if mousemoverel then
                    mousemoverel(moveDelta.X, moveDelta.Y)
                elseif inputmove then
                    inputmove(moveDelta.X, moveDelta.Y)
                end
            end
        end
    end
end)

-- Initialize Save Manager
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("ProjectChimera")
SaveManager:SetFolder("ProjectChimera/specific")
InterfaceManager:BuildInterfaceSection(SettingsTab)
SaveManager:BuildConfigSection(SettingsTab)

-- Welcome notification
Fluent:Notify({
    Title = "Project Chimera Loaded",
    Content = "GUI initialized. Configure your settings in the tabs.",
    Duration = 5
})

print("[+] Project Chimera GUI Edition loaded successfully on Solara")
