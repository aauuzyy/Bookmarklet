local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()


local Window = Rayfield:CreateWindow({
    Name = "🔥 Infernix Hub",
    LoadingTitle = "Igniting Infernix...",
    LoadingSubtitle = "by Rai_GA",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "InfernixHub",
        FileName = "InfernixConfig"
    },
    Discord = {
        Enabled = false,
        Invite = "noinvitelink",
        RememberJoins = true
    },
    KeySystem = true,
    KeySettings = {
        Title = "Infernix Hub",
        Subtitle = "Key System",
        Note = "Get your key from infernix-keys.vercel.app/keys.txt - Keys reset every 24 hours!",
        FileName = "InfernixKey",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {
            "INF-2B4CC1722B33F890",
            "INF-69A446EB882A0BDA",
            "INF-D3E49B1C432A6E39",
            "INF-5A7B6F02E8C1687C",
            "INF-E7E40E52A4D40DB6",
            "INF-EF37B3DD373DE513",
            "INF-1F4C189935BB4185",
            "INF-C62FC80CCB8A7FA5",
            "INF-C714C6267E04D9F7",
            "INF-5BDAAE6E26EF4218"
        }
    }
})

local FlameTab = Window:CreateTab("Inferno", 4483362458)
local FlameSection = FlameTab:CreateSection("Infernix Features")

FlameTab:CreateParagraph({Title = "About Infernix Hub", Content = "Infernix Hub is a powerful exploit script designed for advanced gameplay mechanics. This tab contains core features and information about the script capabilities."})

FlameTab:CreateLabel("Version: 1.0.0")
FlameTab:CreateLabel("Created by: Rai_GA")
FlameTab:CreateLabel("Last Updated: January 2026")

local InfoSection = FlameTab:CreateSection("Script Information")

FlameTab:CreateParagraph({Title = "Key System", Content = "Keys reset every 24 hours automatically. Get your keys from infernix-keys.vercel.app/keys.txt. All 10 keys are valid until the next reset cycle."})

FlameTab:CreateParagraph({Title = "Features Overview", Content = "This script includes aim assistance, visual enhancements, attack modifiers, and strength boosters. Navigate through the tabs to access different feature categories."})

local StatusSection = FlameTab:CreateSection("Status")

FlameTab:CreateLabel("Script Status: Active")
FlameTab:CreateLabel("Performance: Optimized")
FlameTab:CreateLabel("Compatibility: Universal")

local WarningSection = FlameTab:CreateSection("Important Notes")

FlameTab:CreateParagraph({Title = "Usage Warning", Content = "Use responsibly. Excessive or obvious use of exploit features may result in detection. Features are designed to mimic natural gameplay as closely as possible."})

FlameTab:CreateParagraph({Title = "Configuration", Content = "All settings are automatically saved in your InfernixHub folder. Your configurations persist between sessions and the key system remembers valid keys."})

local VisualTab = Window:CreateTab("Visual", "eye")
local LightingSection = VisualTab:CreateSection("Lighting")

local TimeSlider = VisualTab:CreateSlider({
    Name = "Time of Day",
    Range = {0, 24},
    Increment = 0.5,
    Suffix = ":00",
    CurrentValue = 14,
    Flag = "TimeOfDay",
    Callback = function(Value)
        game.Lighting.ClockTime = Value
    end,
})

local FullbrightToggle = VisualTab:CreateToggle({
    Name = "Fullbright",
    CurrentValue = false,
    Flag = "Fullbright",
    Callback = function(Value)
        if Value then
            game.Lighting.Ambient = Color3.new(1, 1, 1)
            game.Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
        else
            game.Lighting.Ambient = Color3.new(0, 0, 0)
            game.Lighting.OutdoorAmbient = Color3.new(0.5, 0.5, 0.5)
        end
    end,
})

local CameraSection = VisualTab:CreateSection("Camera")

local FOVSlider = VisualTab:CreateSlider({
    Name = "Field of View",
    Range = {70, 120},
    Increment = 1,
    CurrentValue = workspace.CurrentCamera.FieldOfView,
    Flag = "FOV",
    Callback = function(Value)
        workspace.CurrentCamera.FieldOfView = Value
    end,
})

local EffectsSection = VisualTab:CreateSection("Effects")

local RemoveBlurToggle = VisualTab:CreateToggle({
    Name = "Remove Blur",
    CurrentValue = false,
    Flag = "RemoveBlur",
    Callback = function(Value)
        for _, effect in pairs(game.Lighting:GetChildren()) do
            if effect:IsA("BlurEffect") then
                effect.Enabled = not Value
            end
        end
    end,
})

local FogToggle = VisualTab:CreateToggle({
    Name = "Remove Fog",
    CurrentValue = false,
    Flag = "RemoveFog",
    Callback = function(Value)
        if Value then
            game.Lighting.FogEnd = 100000
        else
            game.Lighting.FogEnd = 1000
        end
    end,
})

local BrightnessSlider = VisualTab:CreateSlider({
    Name = "Brightness",
    Range = {0, 5},
    Increment = 0.1,
    CurrentValue = 2,
    Flag = "Brightness",
    Callback = function(Value)
        game.Lighting.Brightness = Value
    end,
})

local ExposureSlider = VisualTab:CreateSlider({
    Name = "Exposure",
    Range = {-3, 3},
    Increment = 0.1,
    CurrentValue = 0,
    Flag = "Exposure",
    Callback = function(Value)
        game.Lighting.ExposureCompensation = Value
    end,
})

local ShadowToggle = VisualTab:CreateToggle({
    Name = "Remove Shadows",
    CurrentValue = false,
    Flag = "RemoveShadows",
    Callback = function(Value)
        if Value then
            game.Lighting.GlobalShadows = false
        else
            game.Lighting.GlobalShadows = true
        end
    end,
})

local ESPSection = VisualTab:CreateSection("Player ESP")

local espEnabled = false
local espConnections = {}
local espObjects = {}

local function createESP(player)
    if player == game.Players.LocalPlayer then return end
    
    local function addESP(character)
        if not character then return end
        
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 5)
        if not humanoidRootPart then return end
        
        local billboardGui = Instance.new("BillboardGui")
        billboardGui.Name = "ESP"
        billboardGui.Adornee = humanoidRootPart
        billboardGui.Size = UDim2.new(0, 200, 0, 50)
        billboardGui.StudsOffset = Vector3.new(0, 3, 0)
        billboardGui.AlwaysOnTop = true
        billboardGui.Parent = humanoidRootPart
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Name = "NameLabel"
        nameLabel.BackgroundTransparency = 1
        nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
        nameLabel.Font = Enum.Font.SourceSansBold
        nameLabel.Text = player.Name
        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameLabel.TextSize = 16
        nameLabel.TextStrokeTransparency = 0.5
        nameLabel.Parent = billboardGui
        
        local distanceLabel = Instance.new("TextLabel")
        distanceLabel.Name = "DistanceLabel"
        distanceLabel.BackgroundTransparency = 1
        distanceLabel.Position = UDim2.new(0, 0, 0.5, 0)
        distanceLabel.Size = UDim2.new(1, 0, 0.5, 0)
        distanceLabel.Font = Enum.Font.SourceSans
        distanceLabel.Text = "0 studs"
        distanceLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        distanceLabel.TextSize = 14
        distanceLabel.TextStrokeTransparency = 0.5
        distanceLabel.Parent = billboardGui
        
        local highlight = Instance.new("Highlight")
        highlight.Name = "ESP_Highlight"
        highlight.Adornee = character
        highlight.FillColor = Color3.fromRGB(255, 85, 0)
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        highlight.Parent = character
        
        if not espObjects[player.Name] then
            espObjects[player.Name] = {}
        end
        espObjects[player.Name].Billboard = billboardGui
        espObjects[player.Name].Highlight = highlight
        
        local updateConnection = game:GetService("RunService").RenderStepped:Connect(function()
            if espEnabled and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and humanoidRootPart then
                local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - humanoidRootPart.Position).Magnitude
                distanceLabel.Text = math.floor(distance) .. " studs"
            end
        end)
        
        table.insert(espConnections, updateConnection)
    end
    
    if player.Character then
        addESP(player.Character)
    end
    
    player.CharacterAdded:Connect(addESP)
end

local function removeESP()
    for _, connection in pairs(espConnections) do
        connection:Disconnect()
    end
    espConnections = {}
    
    for _, objects in pairs(espObjects) do
        if objects.Billboard then objects.Billboard:Destroy() end
        if objects.Highlight then objects.Highlight:Destroy() end
    end
    espObjects = {}
end

local ESPToggle = VisualTab:CreateToggle({
    Name = "Player ESP",
    CurrentValue = false,
    Flag = "PlayerESP",
    Callback = function(Value)
        espEnabled = Value
        
        if Value then
            for _, player in pairs(game.Players:GetPlayers()) do
                createESP(player)
            end
            
            game.Players.PlayerAdded:Connect(function(player)
                if espEnabled then
                    createESP(player)
                end
            end)
        else
            removeESP()
        end
    end,
})

local tracersEnabled = false
local tracerConnections = {}
local tracerObjects = {}

local TracersToggle = VisualTab:CreateToggle({
    Name = "Tracer Lines",
    CurrentValue = false,
    Flag = "Tracers",
    Callback = function(Value)
        tracersEnabled = Value
        
        if Value then
            local RunService = game:GetService("RunService")
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            local Camera = workspace.CurrentCamera
            
            local connection = RunService.RenderStepped:Connect(function()
                if not tracersEnabled then return end
                
                for _, obj in pairs(tracerObjects) do
                    if obj then obj:Remove() end
                end
                tracerObjects = {}
                
                if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    return
                end
                
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local line = Drawing.new("Line")
                        line.Visible = true
                        line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                        
                        local hrpPosition, onScreen = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
                        if onScreen then
                            line.To = Vector2.new(hrpPosition.X, hrpPosition.Y)
                            line.Color = Color3.fromRGB(255, 85, 0)
                            line.Thickness = 1
                            line.Transparency = 1
                            table.insert(tracerObjects, line)
                        else
                            line:Remove()
                        end
                    end
                end
            end)
            
            table.insert(tracerConnections, connection)
        else
            for _, connection in pairs(tracerConnections) do
                connection:Disconnect()
            end
            tracerConnections = {}
            
            for _, obj in pairs(tracerObjects) do
                if obj then obj:Remove() end
            end
            tracerObjects = {}
        end
    end,
})

local HealthBarsToggle = VisualTab:CreateToggle({
    Name = "Health Bars",
    CurrentValue = false,
    Flag = "HealthBars",
    Callback = function(Value)
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer and player.Character then
                local humanoid = player.Character:FindFirstChild("Humanoid")
                if humanoid then
                    local healthBar = player.Character:FindFirstChild("HealthBar")
                    
                    if Value and not healthBar then
                        local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            local billboard = Instance.new("BillboardGui")
                            billboard.Name = "HealthBar"
                            billboard.Adornee = hrp
                            billboard.Size = UDim2.new(4, 0, 0.5, 0)
                            billboard.StudsOffset = Vector3.new(0, 4, 0)
                            billboard.AlwaysOnTop = true
                            billboard.Parent = player.Character
                            
                            local frame = Instance.new("Frame")
                            frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                            frame.BorderSizePixel = 2
                            frame.Size = UDim2.new(1, 0, 1, 0)
                            frame.Parent = billboard
                            
                            local healthFill = Instance.new("Frame")
                            healthFill.Name = "Fill"
                            healthFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                            healthFill.BorderSizePixel = 0
                            healthFill.Size = UDim2.new(humanoid.Health / humanoid.MaxHealth, 0, 1, 0)
                            healthFill.Parent = frame
                            
                            humanoid.HealthChanged:Connect(function(health)
                                if healthFill then
                                    healthFill.Size = UDim2.new(health / humanoid.MaxHealth, 0, 1, 0)
                                    
                                    if health / humanoid.MaxHealth > 0.5 then
                                        healthFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                                    elseif health / humanoid.MaxHealth > 0.25 then
                                        healthFill.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
                                    else
                                        healthFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                                    end
                                end
                            end)
                        end
                    elseif not Value and healthBar then
                        healthBar:Destroy()
                    end
                end
            end
        end
    end,
})

local ItemESPSection = VisualTab:CreateSection("Item ESP")

local itemESPEnabled = false
local itemESPObjects = {}
local itemESPConnections = {}
local selectedItemName = ""
local itemESPColor = Color3.fromRGB(255, 255, 0)
local itemESPDistance = 1000

local ftapItems = {
    "Cursed Alarm Clock", "Edgy Desk", "Short Daycare Box Thing", "Cracked Stool", "Chair (Metal)", 
    "Bench", "Lamp", "Banner", "Gas Lantern Light", "Spooky Chair", "Daycare Table", 
    "Desk (Traditional)", "Chair (Traditional)", "Nightstand", "Long Daycare Box Thing", "Basic Bench",
    "Glass Door Cabinet", "Basic Desk", "Basic Shelf", "Spooky Bench", "Spooky Cabinet", "Lab Table",
    "Daycare Chair", "Daycare Bench", "Daycare Desk", "Heart Arm Chair", "Arm Chair", "Microwave Oven",
    "Table (Metal)", "Tree", "Couch (Metal)", "Bench (Traditional)", "Recliner", "Desk (Metal)",
    "Shelf (Traditional)", "Paper Lantern", "Dresser (Traditional)", "Couch (Traditional)", "Daycare Shelf",
    "Futon Bed", "Shelf (Metal)", "Arm Chair (Spiked)", "Cabinet (Metal)", "Spooky Desk", "Spooky Shelf",
    "Spooky Table", "Cactus", "Table (Darkwood)", "Couch", "Couch (Spiked)", "Table (Lightwood)",
    "Very Wide Recliner", "School Lunch Table", "Ladder (Lightwood)", "Paper Fan", "Bonsai",
    "Table (Traditional)", "Blue Bed", "Orange Bed", "Heart Couch", "Coffin Couch", "Corner Counter",
    "Counter", "Toilet", "Refridgerator", "Oven", "Cathode Ray Television", "Oven (Burnt)", "Desk Fan",
    "Gong", "Washing Machine", "Flatscreen Television", "Bathroom Shower", "Bathroom Sink", "Laptop",
    "Kitchen Sink", "Golden Toilet", "Jukebox (Yellow)", "Jukebox (Cyan)", "Christmas Tree",
    "Desk Lamp", "Light Ball", "Candlestick", "Crystal", "Spotlight (Red)", "Spotlight (Green)",
    "Spotlight (Blue)", "Spotlight (White)", "Sparkler", "Campfire", "Three Candle Candelabra",
    "Five Candle Candelabra", "Disco Cube", "Plate", "Broccoli", "Mug (Brown Fluid)", "Mug (White Fluid)",
    "Donut", "Hotdog", "Pepperoni Pizza", "Cheeze Pizza", "Soda", "Meat", "Sunny-side Up Egg",
    "Slice of Bread", "Slice of Cake", "Coconut", "French Fries", "Banana", "Mysterious Mushroom",
    "Hamburger", "Poop!", "Hot Sauce", "Sparkling Poop!", "Mayonnaise", "Katana", "Cleaver", "Pencil",
    "Digging Fork", "Pickaxe", "Shuriken", "Kunai", "Missile", "Blobman", "Smoke Bomb", "Unstable Substance",
    "Jukebox", "Rhythm Maker", "Microphone", "Saxophone", "Bugle", "Trumpet", "Bongos", "Snare Drum",
    "Acoustic Guitar", "Lyre", "Ukulele", "Violin", "Ocarina", "Keyboard", "Melodica", "Vuvuzela",
    "Banjo", "Midi Keyboard", "Little Helicopter", "Little Plane", "Little UFO", "Figurine You",
    "Snowman", "Toy Frog", "Toy Tiger", "Toy Duck", "Toy Unicorn", "Toy Bear", "Glider", "Balloon",
    "Basketball", "Bubble Blower", "Santa's Sleigh", "Tractor", "Robot"
}

table.sort(ftapItems)

local ItemPresetDropdown = VisualTab:CreateDropdown({
    Name = "FTAP Items",
    Options = ftapItems,
    CurrentOption = {"Plate"},
    MultipleOptions = false,
    Flag = "ItemPreset",
    Callback = function(Option)
        selectedItemName = Option[1]
    end,
})

local ItemDistanceSlider = VisualTab:CreateSlider({
    Name = "ESP Max Distance",
    Range = {100, 5000},
    Increment = 100,
    Suffix = " studs",
    CurrentValue = 1000,
    Flag = "ItemESPDistance",
    Callback = function(Value)
        itemESPDistance = Value
    end,
})

local ItemColorPicker = VisualTab:CreateColorPicker({
    Name = "Item ESP Color",
    Color = Color3.fromRGB(255, 255, 0),
    Flag = "ItemESPColor",
    Callback = function(Value)
        itemESPColor = Value
        
        for _, espData in pairs(itemESPObjects) do
            if espData.Highlight then
                espData.Highlight.FillColor = Value
            end
            if espData.Billboard then
                local nameLabel = espData.Billboard:FindFirstChild("NameLabel")
                if nameLabel then
                    nameLabel.TextColor3 = Value
                end
            end
        end
    end,
})

local function createItemESP(item)
    if not item:IsA("BasePart") and not item:IsA("Model") then return end
    
    local primaryPart = item:IsA("Model") and item.PrimaryPart or item
    if not primaryPart then return end
    
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Name = "ItemESP"
    billboardGui.Adornee = primaryPart
    billboardGui.Size = UDim2.new(0, 200, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 2, 0)
    billboardGui.AlwaysOnTop = true
    billboardGui.Parent = primaryPart
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "NameLabel"
    nameLabel.BackgroundTransparency = 1
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.Text = item.Name
    nameLabel.TextColor3 = itemESPColor
    nameLabel.TextSize = 16
    nameLabel.TextStrokeTransparency = 0.5
    nameLabel.Parent = billboardGui
    
    local distanceLabel = Instance.new("TextLabel")
    distanceLabel.Name = "DistanceLabel"
    distanceLabel.BackgroundTransparency = 1
    distanceLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distanceLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distanceLabel.Font = Enum.Font.SourceSans
    distanceLabel.Text = "0 studs"
    distanceLabel.TextColor3 = itemESPColor
    distanceLabel.TextSize = 14
    distanceLabel.TextStrokeTransparency = 0.5
    distanceLabel.Parent = billboardGui
    
    local highlight = Instance.new("Highlight")
    highlight.Name = "ItemESP_Highlight"
    highlight.Adornee = item
    highlight.FillColor = itemESPColor
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Parent = item
    
    local uniqueId = tostring(item) .. "_" .. tick()
    itemESPObjects[uniqueId] = {
        Billboard = billboardGui,
        Highlight = highlight,
        Item = item,
        PrimaryPart = primaryPart
    }
    
    local updateConnection = game:GetService("RunService").RenderStepped:Connect(function()
        if itemESPEnabled and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and primaryPart then
            local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - primaryPart.Position).Magnitude
            
            if distance <= itemESPDistance then
                distanceLabel.Text = math.floor(distance) .. " studs"
                billboardGui.Enabled = true
                highlight.Enabled = true
            else
                billboardGui.Enabled = false
                highlight.Enabled = false
            end
        end
    end)
    
    table.insert(itemESPConnections, updateConnection)
end

local function removeItemESP()
    for _, connection in pairs(itemESPConnections) do
        connection:Disconnect()
    end
    itemESPConnections = {}
    
    for _, espData in pairs(itemESPObjects) do
        if espData.Billboard then espData.Billboard:Destroy() end
        if espData.Highlight then espData.Highlight:Destroy() end
    end
    itemESPObjects = {}
end

local function scanForItems()
    if selectedItemName == "" then return end
    
    removeItemESP()
    
    local function searchDescendants(parent)
        for _, obj in pairs(parent:GetDescendants()) do
            if itemESPEnabled and obj.Name:lower():find(selectedItemName:lower()) then
                if obj:IsA("BasePart") or obj:IsA("Model") then
                    local isPlayerPart = false
                    
                    for _, player in pairs(game.Players:GetPlayers()) do
                        if player.Character and obj:IsDescendantOf(player.Character) then
                            isPlayerPart = true
                            break
                        end
                    end
                    
                    if not isPlayerPart then
                        createItemESP(obj)
                    end
                end
            end
        end
    end
    
    searchDescendants(workspace)
end

local itemESPRefreshLoop = nil

local ItemESPToggle = VisualTab:CreateToggle({
    Name = "Enable Item ESP",
    CurrentValue = false,
    Flag = "ItemESP",
    Callback = function(Value)
        itemESPEnabled = Value
        
        if Value then
            if selectedItemName == "" then
                Rayfield:Notify({
                    Title = "Item ESP",
                    Content = "Please select an item first!",
                    Duration = 3,
                })
                return
            end
            
            scanForItems()
            
            workspace.DescendantAdded:Connect(function(obj)
                if itemESPEnabled and obj.Name:lower():find(selectedItemName:lower()) then
                    wait(0.1)
                    if obj:IsA("BasePart") or obj:IsA("Model") then
                        createItemESP(obj)
                    end
                end
            end)
            
            -- Auto-refresh every 10 seconds
            itemESPRefreshLoop = game:GetService("RunService").Heartbeat:Connect(function()
                wait(10)
                if itemESPEnabled then
                    scanForItems()
                end
            end)
            
            Rayfield:Notify({
                Title = "Item ESP",
                Content = "Now tracking: " .. selectedItemName,
                Duration = 2,
            })
        else
            if itemESPRefreshLoop then
                itemESPRefreshLoop:Disconnect()
                itemESPRefreshLoop = nil
            end
            removeItemESP()
        end
    end,
})

local RefreshItemsButton = VisualTab:CreateButton({
    Name = "Refresh Item ESP",
    Callback = function()
        if itemESPEnabled then
            scanForItems()
            Rayfield:Notify({
                Title = "Item ESP",
                Content = "Refreshed ESP for: " .. selectedItemName,
                Duration = 2,
            })
        else
            Rayfield:Notify({
                Title = "Item ESP",
                Content = "Enable Item ESP first!",
                Duration = 2,
            })
        end
    end,
})

local SkySection = VisualTab:CreateSection("Sky & Atmosphere")

local skyboxes = {
    ["Default"] = "Default",
    ["Purple Nebula"] = "rbxassetid://159454299",
    ["Pink Daybreak"] = "rbxassetid://271042516",
    ["Dark Space"] = "rbxassetid://149397692",
    ["Cloudy Sky"] = "rbxassetid://570557620",
    ["Sunset"] = "rbxassetid://600886090"
}

local SkyboxDropdown = VisualTab:CreateDropdown({
    Name = "Skybox Theme",
    Options = {"Default", "Purple Nebula", "Pink Daybreak", "Dark Space", "Cloudy Sky", "Sunset"},
    CurrentOption = {"Default"},
    MultipleOptions = false,
    Flag = "Skybox",
    Callback = function(Option)
        if Option[1] == "Default" then
            local sky = game.Lighting:FindFirstChildOfClass("Sky")
            if sky then
                sky:Destroy()
            end
        else
            local sky = game.Lighting:FindFirstChildOfClass("Sky")
            if not sky then
                sky = Instance.new("Sky")
                sky.Parent = game.Lighting
            end
            local id = skyboxes[Option[1]]
            sky.SkyboxBk = id
            sky.SkyboxDn = id
            sky.SkyboxFt = id
            sky.SkyboxLf = id
            sky.SkyboxRt = id
            sky.SkyboxUp = id
        end
    end,
})

local AmbientColorPicker = VisualTab:CreateColorPicker({
    Name = "Ambient Color",
    Color = Color3.fromRGB(138, 138, 138),
    Flag = "AmbientColor",
    Callback = function(Value)
        game.Lighting.Ambient = Value
    end,
})

local OutdoorAmbientColorPicker = VisualTab:CreateColorPicker({
    Name = "Outdoor Ambient Color",
    Color = Color3.fromRGB(138, 138, 138),
    Flag = "OutdoorAmbientColor",
    Callback = function(Value)
        game.Lighting.OutdoorAmbient = Value
    end,
})

local ColorShiftTopColorPicker = VisualTab:CreateColorPicker({
    Name = "Color Shift Top",
    Color = Color3.fromRGB(0, 0, 0),
    Flag = "ColorShiftTop",
    Callback = function(Value)
        game.Lighting.ColorShift_Top = Value
    end,
})

local ColorShiftBottomColorPicker = VisualTab:CreateColorPicker({
    Name = "Color Shift Bottom",
    Color = Color3.fromRGB(0, 0, 0),
    Flag = "ColorShiftBottom",
    Callback = function(Value)
        game.Lighting.ColorShift_Bottom = Value
    end,
})

local ShadersSection = VisualTab:CreateSection("Shaders & Effects")

local shaderPresets = {
    ["Default"] = function()
        game.Lighting.ClockTime = 14
        game.Lighting.Ambient = Color3.fromRGB(138, 138, 138)
        game.Lighting.OutdoorAmbient = Color3.fromRGB(138, 138, 138)
        game.Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0)
        game.Lighting.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
        
        for _, effect in pairs(game.Lighting:GetChildren()) do
            if effect:IsA("BloomEffect") or effect:IsA("SunRaysEffect") or effect:IsA("ColorCorrectionEffect") or effect:IsA("BlurEffect") then
                effect:Destroy()
            end
        end
    end,
    ["Sunset"] = function()
        game.Lighting.ClockTime = 18
        game.Lighting.Ambient = Color3.fromRGB(255, 140, 70)
        game.Lighting.OutdoorAmbient = Color3.fromRGB(255, 120, 50)
        game.Lighting.ColorShift_Top = Color3.fromRGB(255, 100, 50)
        game.Lighting.ColorShift_Bottom = Color3.fromRGB(255, 150, 100)
        
        local bloom = Instance.new("BloomEffect")
        bloom.Intensity = 0.4
        bloom.Size = 24
        bloom.Threshold = 0.8
        bloom.Parent = game.Lighting
        
        local sunrays = Instance.new("SunRaysEffect")
        sunrays.Intensity = 0.15
        sunrays.Spread = 0.8
        sunrays.Parent = game.Lighting
        
        local cc = Instance.new("ColorCorrectionEffect")
        cc.Brightness = 0.05
        cc.Contrast = 0.1
        cc.Saturation = 0.2
        cc.TintColor = Color3.fromRGB(255, 200, 150)
        cc.Parent = game.Lighting
    end,
    ["Night Vision"] = function()
        game.Lighting.ClockTime = 0
        game.Lighting.Ambient = Color3.fromRGB(0, 255, 100)
        game.Lighting.OutdoorAmbient = Color3.fromRGB(0, 255, 100)
        game.Lighting.ColorShift_Top = Color3.fromRGB(0, 150, 50)
        game.Lighting.ColorShift_Bottom = Color3.fromRGB(0, 100, 50)
        game.Lighting.Brightness = 3
        
        local cc = Instance.new("ColorCorrectionEffect")
        cc.Brightness = 0.3
        cc.Contrast = 0.3
        cc.Saturation = -0.5
        cc.TintColor = Color3.fromRGB(100, 255, 100)
        cc.Parent = game.Lighting
        
        local bloom = Instance.new("BloomEffect")
        bloom.Intensity = 0.8
        bloom.Size = 24
        bloom.Threshold = 0.2
        bloom.Parent = game.Lighting
    end,
    ["Glossy"] = function()
        local bloom = Instance.new("BloomEffect")
        bloom.Intensity = 1
        bloom.Size = 24
        bloom.Threshold = 0.5
        bloom.Parent = game.Lighting
        
        local cc = Instance.new("ColorCorrectionEffect")
        cc.Brightness = 0.15
        cc.Contrast = 0.3
        cc.Saturation = 0.3
        cc.Parent = game.Lighting
        
        game.Lighting.GlobalShadows = true
        game.Lighting.Technology = Enum.Technology.Future
    end,
    ["Retro"] = function()
        local cc = Instance.new("ColorCorrectionEffect")
        cc.Brightness = -0.05
        cc.Contrast = 0.2
        cc.Saturation = -0.3
        cc.TintColor = Color3.fromRGB(255, 230, 200)
        cc.Parent = game.Lighting
        
        local blur = Instance.new("BlurEffect")
        blur.Size = 2
        blur.Parent = game.Lighting
    end,
    ["Vibrant"] = function()
        local bloom = Instance.new("BloomEffect")
        bloom.Intensity = 0.6
        bloom.Size = 24
        bloom.Threshold = 0.7
        bloom.Parent = game.Lighting
        
        local cc = Instance.new("ColorCorrectionEffect")
        cc.Brightness = 0.1
        cc.Contrast = 0.2
        cc.Saturation = 0.5
        cc.Parent = game.Lighting
        
        game.Lighting.Ambient = Color3.fromRGB(180, 180, 180)
        game.Lighting.OutdoorAmbient = Color3.fromRGB(180, 180, 180)
    end
}

local ShaderPresetDropdown = VisualTab:CreateDropdown({
    Name = "Shader Presets",
    Options = {"Default", "Sunset", "Night Vision", "Glossy", "Retro", "Vibrant"},
    CurrentOption = {"Default"},
    MultipleOptions = false,
    Flag = "ShaderPreset",
    Callback = function(Option)
        -- Remove existing effects
        for _, effect in pairs(game.Lighting:GetChildren()) do
            if effect:IsA("BloomEffect") or effect:IsA("SunRaysEffect") or effect:IsA("ColorCorrectionEffect") or effect:IsA("BlurEffect") then
                effect:Destroy()
            end
        end
        
        -- Apply new shader
        if shaderPresets[Option[1]] then
            shaderPresets[Option[1]]()
        end
    end,
})

local SunRaysToggle = VisualTab:CreateToggle({
    Name = "Sun Rays",
    CurrentValue = false,
    Flag = "SunRays",
    Callback = function(Value)
        local existing = game.Lighting:FindFirstChildOfClass("SunRaysEffect")
        if Value and not existing then
            local sunrays = Instance.new("SunRaysEffect")
            sunrays.Intensity = 0.15
            sunrays.Spread = 0.8
            sunrays.Parent = game.Lighting
        elseif not Value and existing then
            existing:Destroy()
        end
    end,
})

local BloomToggle = VisualTab:CreateToggle({
    Name = "Bloom Effect",
    CurrentValue = false,
    Flag = "Bloom",
    Callback = function(Value)
        local existing = game.Lighting:FindFirstChildOfClass("BloomEffect")
        if Value and not existing then
            local bloom = Instance.new("BloomEffect")
            bloom.Intensity = 0.4
            bloom.Size = 24
            bloom.Threshold = 0.8
            bloom.Parent = game.Lighting
        elseif not Value and existing then
            existing:Destroy()
        end
    end,
})

local ColorCorrectionToggle = VisualTab:CreateToggle({
    Name = "Color Correction",
    CurrentValue = false,
    Flag = "ColorCorrection",
    Callback = function(Value)
        local existing = game.Lighting:FindFirstChildOfClass("ColorCorrectionEffect")
        if Value and not existing then
            local cc = Instance.new("ColorCorrectionEffect")
            cc.Brightness = 0.05
            cc.Contrast = 0.15
            cc.Saturation = 0.2
            cc.Parent = game.Lighting
        elseif not Value and existing then
            existing:Destroy()
        end
    end,
})

local AdvancedSection = VisualTab:CreateSection("Advanced Visuals")

local XRayToggle = VisualTab:CreateToggle({
    Name = "X-Ray (See Through Walls)",
    CurrentValue = false,
    Flag = "XRay",
    Callback = function(Value)
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer and player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        if Value then
                            part.LocalTransparencyModifier = 0.5
                        else
                            part.LocalTransparencyModifier = 0
                        end
                    end
                end
            end
        end
    end,
})

local ChamsToggle = VisualTab:CreateToggle({
    Name = "Chams (Player Highlights)",
    CurrentValue = false,
    Flag = "Chams",
    Callback = function(Value)
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer and player.Character then
                local existing = player.Character:FindFirstChild("ChamsHighlight")
                
                if Value and not existing then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "ChamsHighlight"
                    highlight.Adornee = player.Character
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.FillTransparency = 0.3
                    highlight.OutlineTransparency = 0
                    highlight.Parent = player.Character
                elseif not Value and existing then
                    existing:Destroy()
                end
            end
        end
    end,
})

local NoClipToggle = VisualTab:CreateToggle({
    Name = "Noclip (Walk Through Walls)",
    CurrentValue = false,
    Flag = "Noclip",
    Callback = function(Value)
        local RunService = game:GetService("RunService")
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        
        if Value then
            _G.NoclipConnection = RunService.Stepped:Connect(function()
                if LocalPlayer.Character then
                    for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        else
            if _G.NoclipConnection then
                _G.NoclipConnection:Disconnect()
                _G.NoclipConnection = nil
            end
            
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end
    end,
})

local CrosshairSection = VisualTab:CreateSection("Crosshair")

local crosshairEnabled = false
local crosshairLines = {}

local CrosshairToggle = VisualTab:CreateToggle({
    Name = "Custom Crosshair",
    CurrentValue = false,
    Flag = "Crosshair",
    Callback = function(Value)
        crosshairEnabled = Value
        
        if Value then
            local size = 8
            local thickness = 2
            local gap = 4
            local outlineThickness = 1
            
            -- Create main crosshair lines (white)
            for i = 1, 4 do
                local line = Drawing.new("Line")
                line.Visible = true
                line.Color = Color3.fromRGB(255, 255, 255)
                line.Thickness = thickness
                line.Transparency = 1
                table.insert(crosshairLines, line)
            end
            
            -- Create outline lines (black for contrast)
            for i = 1, 4 do
                local outline = Drawing.new("Line")
                outline.Visible = true
                outline.Color = Color3.fromRGB(0, 0, 0)
                outline.Thickness = thickness + (outlineThickness * 2)
                outline.Transparency = 0.8
                table.insert(crosshairLines, outline)
            end
            
            -- Create center dot
            local centerDot = Drawing.new("Circle")
            centerDot.Visible = true
            centerDot.Color = Color3.fromRGB(255, 255, 255)
            centerDot.Thickness = 1
            centerDot.NumSides = 12
            centerDot.Radius = 2
            centerDot.Filled = true
            centerDot.Transparency = 1
            table.insert(crosshairLines, centerDot)
            
            game:GetService("RunService").RenderStepped:Connect(function()
                if not crosshairEnabled then
                    for _, element in pairs(crosshairLines) do
                        element.Visible = false
                    end
                    return
                end
                
                local centerX = workspace.CurrentCamera.ViewportSize.X / 2
                local centerY = workspace.CurrentCamera.ViewportSize.Y / 2
                
                -- Update outline lines (black)
                crosshairLines[5].From = Vector2.new(centerX - size - gap, centerY)
                crosshairLines[5].To = Vector2.new(centerX - gap, centerY)
                
                crosshairLines[6].From = Vector2.new(centerX + gap, centerY)
                crosshairLines[6].To = Vector2.new(centerX + size + gap, centerY)
                
                crosshairLines[7].From = Vector2.new(centerX, centerY - size - gap)
                crosshairLines[7].To = Vector2.new(centerX, centerY - gap)
                
                crosshairLines[8].From = Vector2.new(centerX, centerY + gap)
                crosshairLines[8].To = Vector2.new(centerX, centerY + size + gap)
                
                -- Update main lines (white)
                crosshairLines[1].From = Vector2.new(centerX - size - gap, centerY)
                crosshairLines[1].To = Vector2.new(centerX - gap, centerY)
                
                crosshairLines[2].From = Vector2.new(centerX + gap, centerY)
                crosshairLines[2].To = Vector2.new(centerX + size + gap, centerY)
                
                crosshairLines[3].From = Vector2.new(centerX, centerY - size - gap)
                crosshairLines[3].To = Vector2.new(centerX, centerY - gap)
                
                crosshairLines[4].From = Vector2.new(centerX, centerY + gap)
                crosshairLines[4].To = Vector2.new(centerX, centerY + size + gap)
                
                -- Update center dot
                crosshairLines[9].Position = Vector2.new(centerX, centerY)
                
                for _, element in pairs(crosshairLines) do
                    element.Visible = true
                end
            end)
        else
            for _, element in pairs(crosshairLines) do
                if element then
                    element:Remove()
                end
            end
            crosshairLines = {}
        end
    end,
})

local AimTab = Window:CreateTab("Aim", "crosshair")
local AimSection = AimTab:CreateSection("Aim Assists")

local AttackTab = Window:CreateTab("Attack", "zap")
local StrengthSection = AttackTab:CreateSection("Strength Modifier")

local targetBone = "Head"
local randomizeAim = false
local hitChance = 85

local BoneDropdown = AimTab:CreateDropdown({
    Name = "Target Body Part",
    Options = {"Head", "Torso", "LeftArm", "RightArm", "LeftLeg", "RightLeg"},
    CurrentOption = {"Head"},
    MultipleOptions = false,
    Flag = "TargetBone",
    Callback = function(Option)
        targetBone = Option[1]
    end,
})

local RandomizeToggle = AimTab:CreateToggle({
    Name = "Randomize Aim (Silent Aim Only)",
    CurrentValue = false,
    Flag = "RandomizeAim",
    Callback = function(Value)
        randomizeAim = Value
    end,
})

local HitChanceSlider = AimTab:CreateSlider({
    Name = "Hit Chance %",
    Range = {1, 100},
    Increment = 1,
    Suffix = "%",
    CurrentValue = 85,
    Flag = "HitChance",
    Callback = function(Value)
        hitChance = Value
    end,
})

local silentAimEnabled = false
local silentAimConnection = nil

local SilentAimToggle = AimTab:CreateToggle({
    Name = "Silent Aim (Press Q)",
    CurrentValue = false,
    Flag = "SilentAim",
    Callback = function(Value)
        silentAimEnabled = Value
        
        if Value then
            local UserInputService = game:GetService("UserInputService")
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            local Camera = workspace.CurrentCamera
            
            local isClicking = false
            local bodyParts = {"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"}
            
            local function getClosestPlayer()
                local closestPlayer = nil
                local shortestDistance = math.huge
                
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local distance = (player.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).magnitude
                        if distance < shortestDistance then
                            closestPlayer = player
                            shortestDistance = distance
                        end
                    end
                end
                
                return closestPlayer
            end
            
            local function getTargetPart(character)
                if randomizeAim then
                    local randomChance = math.random(1, 100)
                    if randomChance <= hitChance then
                        local randomPart = bodyParts[math.random(1, #bodyParts)]
                        return character:FindFirstChild(randomPart) or character:FindFirstChild("HumanoidRootPart")
                    else
                        return nil
                    end
                else
                    return character:FindFirstChild(targetBone) or character:FindFirstChild("HumanoidRootPart")
                end
            end
            
            local function aimAt(target)
                if target and target.Character then
                    local targetPart = getTargetPart(target.Character)
                    if targetPart then
                        local targetPosition = targetPart.Position
                        Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPosition)
                        
                        if not isClicking then
                            isClicking = true
                            mouse1click()
                            isClicking = false
                        end
                    end
                end
            end
            
            silentAimConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if input.KeyCode == Enum.KeyCode.Q and not gameProcessed and silentAimEnabled then
                    local closestPlayer = getClosestPlayer()
                    aimAt(closestPlayer)
                end
            end)
            
            Rayfield:Notify({
                Title = "Silent Aim",
                Content = "Silent Aim enabled - Press Q to use",
                Duration = 3,
            })
        else
            if silentAimConnection then
                silentAimConnection:Disconnect()
                silentAimConnection = nil
            end
        end
    end,
})

local aimbotEnabled = false
local aimbotActive = false
local aimbotTarget = nil
local aimbotConnection = nil
local aimbotLoop = nil

local AimbotToggle = AimTab:CreateToggle({
    Name = "Aimbot (Press R)",
    CurrentValue = false,
    Flag = "Aimbot",
    Callback = function(Value)
        aimbotEnabled = Value
        
        if Value then
            local UserInputService = game:GetService("UserInputService")
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            local Camera = workspace.CurrentCamera
            local RunService = game:GetService("RunService")
            
            local function getPlayerAtCursor()
                local mousePos = UserInputService:GetMouseLocation()
                
                local closestPlayer = nil
                local closestDistance = math.huge
                
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local screenPoint, onScreen = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
                        if onScreen then
                            local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - mousePos).Magnitude
                            if distance < closestDistance and distance < 200 then
                                closestPlayer = player
                                closestDistance = distance
                            end
                        end
                    end
                end
                
                return closestPlayer
            end
            
            aimbotConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if input.KeyCode == Enum.KeyCode.R and not gameProcessed and aimbotEnabled then
                    if not aimbotActive then
                        aimbotTarget = getPlayerAtCursor()
                        if aimbotTarget then
                            aimbotActive = true
                            
                            aimbotLoop = RunService.RenderStepped:Connect(function()
                                if aimbotActive and aimbotTarget and aimbotTarget.Character then
                                    local targetPart = aimbotTarget.Character:FindFirstChild(targetBone) or aimbotTarget.Character:FindFirstChild("HumanoidRootPart")
                                    if targetPart then
                                        local targetPosition = targetPart.Position
                                        Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPosition)
                                    else
                                        aimbotActive = false
                                        if aimbotLoop then
                                            aimbotLoop:Disconnect()
                                        end
                                    end
                                else
                                    aimbotActive = false
                                    if aimbotLoop then
                                        aimbotLoop:Disconnect()
                                    end
                                end
                            end)
                            
                            Rayfield:Notify({
                                Title = "Aimbot",
                                Content = "Locked onto " .. aimbotTarget.Name,
                                Duration = 2,
                            })
                        end
                    else
                        aimbotActive = false
                        aimbotTarget = nil
                        if aimbotLoop then
                            aimbotLoop:Disconnect()
                            aimbotLoop = nil
                        end
                        Rayfield:Notify({
                            Title = "Aimbot",
                            Content = "Lock released",
                            Duration = 2,
                        })
                    end
                end
            end)
            
            Rayfield:Notify({
                Title = "Aimbot",
                Content = "Aimbot enabled - Press R to lock/unlock",
                Duration = 3,
            })
        else
            aimbotActive = false
            aimbotTarget = nil
            if aimbotConnection then
                aimbotConnection:Disconnect()
                aimbotConnection = nil
            end
            if aimbotLoop then
                aimbotLoop:Disconnect()
                aimbotLoop = nil
            end
        end
    end,
})

local smoothAimbotEnabled = false
local smoothAimbotActive = false
local smoothAimbotTarget = nil
local smoothAimbotConnection = nil
local smoothAimbotLoop = nil
local smoothnessValue = 0.08

local SmoothnessSlider = AimTab:CreateSlider({
    Name = "Smooth Lock Speed",
    Range = {0.01, 0.2},
    Increment = 0.01,
    CurrentValue = 0.08,
    Flag = "SmoothnessValue",
    Callback = function(Value)
        smoothnessValue = Value
    end,
})

local fovAimEnabled = false
local fovAimRadius = 150
local fovAimConnection = nil
local fovCircle = nil
local fovUpdateLoop = nil
local fovCircleColor = Color3.fromRGB(255, 85, 0)

local StrengthMultiplier = 450
local strengthModifierConnection = nil

local FOVRadiusSlider = AimTab:CreateSlider({
    Name = "FOV Circle Size",
    Range = {50, 300},
    Increment = 10,
    Suffix = " px",
    CurrentValue = 150,
    Flag = "FOVRadius",
    Callback = function(Value)
        fovAimRadius = Value
        if fovCircle then
            fovCircle.Radius = Value
        end
    end,
})

local FOVCircleColor = AimTab:CreateColorPicker({
    Name = "FOV Circle Color",
    Color = Color3.fromRGB(255, 85, 0),
    Flag = "FOVCircleColor",
    Callback = function(Value)
        fovCircleColor = Value
        if fovCircle then
            fovCircle.Color = Value
        end
    end,
})

local FOVAimToggle = AimTab:CreateToggle({
    Name = "FOV Aim (Press F)",
    CurrentValue = false,
    Flag = "FOVAim",
    Callback = function(Value)
        fovAimEnabled = Value
        
        if Value then
            local UserInputService = game:GetService("UserInputService")
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            local RunService = game:GetService("RunService")
            
            -- Create FOV circle
            fovCircle = Drawing.new("Circle")
            fovCircle.Thickness = 1
            fovCircle.NumSides = 64
            fovCircle.Radius = 150
            fovCircle.Filled = false
            fovCircle.Color = fovCircleColor
            fovCircle.Transparency = 1
            fovCircle.Visible = true
            
            -- Update circle position every frame
            fovUpdateLoop = RunService.RenderStepped:Connect(function()
                if fovCircle then
                    local mousePos = UserInputService:GetMouseLocation()
                    fovCircle.Position = mousePos
                end
            end)
            
            local function getClosestPlayerInFOV()
                if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    return nil
                end
                
                local Camera = workspace.CurrentCamera
                local localHRP = LocalPlayer.Character.HumanoidRootPart
                local mousePos = UserInputService:GetMouseLocation()
                local closestPlayer = nil
                local closestDistance = math.huge
                
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        -- Check 3D distance first
                        local distance3D = (player.Character.HumanoidRootPart.Position - localHRP.Position).Magnitude
                        
                        if distance3D >= 20 and distance3D <= 30 then
                            -- Check all body parts
                            for _, part in pairs(player.Character:GetChildren()) do
                                if part:IsA("BasePart") then
                                    local screenPoint, onScreen = Camera:WorldToViewportPoint(part.Position)
                                    
                                    if onScreen then
                                        local screenDistance = (Vector2.new(screenPoint.X, screenPoint.Y) - mousePos).Magnitude
                                        
                                        -- If any part is within the circle and this player is closer in 3D space
                                        if screenDistance <= fovAimRadius and distance3D < closestDistance then
                                            closestPlayer = player
                                            closestDistance = distance3D
                                            break -- Found a part in circle, move to next player
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                
                return closestPlayer
            end
            
            fovAimConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if input.KeyCode == Enum.KeyCode.F and not gameProcessed and fovAimEnabled then
                    local targetPlayer = getClosestPlayerInFOV()
                    if targetPlayer and targetPlayer.Character then
                        local targetPart = targetPlayer.Character:FindFirstChild(targetBone) or targetPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if targetPart then
                            -- Aim at the target and click immediately
                            workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, targetPart.Position)
                            mouse1click()
                            Rayfield:Notify({
                                Title = "FOV Aim",
                                Content = "Grabbed " .. targetPlayer.Name,
                                Duration = 1.5,
                            })
                        end
                    end
                end
            end)
            
            Rayfield:Notify({
                Title = "FOV Aim",
                Content = "FOV Aim enabled - Press F to grab nearest player",
                Duration = 3,
            })
        else
            if fovAimConnection then
                fovAimConnection:Disconnect()
                fovAimConnection = nil
            end
            if fovUpdateLoop then
                fovUpdateLoop:Disconnect()
                fovUpdateLoop = nil
            end
            if fovCircle then
                fovCircle:Remove()
                fovCircle = nil
            end
        end
    end,
})

local SmoothAimbotToggle = AimTab:CreateToggle({
    Name = "Smooth Lock (Press T)",
    CurrentValue = false,
    Flag = "SmoothAimbot",
    Callback = function(Value)
        smoothAimbotEnabled = Value
        
        if Value then
            local UserInputService = game:GetService("UserInputService")
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            local Camera = workspace.CurrentCamera
            local RunService = game:GetService("RunService")
            
            local maxDistance = 30
            local predictionStrength = 0.15
            local fovRestriction = 90
            
            local function isInFOV(targetPos)
                local cameraCFrame = Camera.CFrame
                local cameraDirection = cameraCFrame.LookVector
                local toTarget = (targetPos - cameraCFrame.Position).Unit
                local angle = math.deg(math.acos(cameraDirection:Dot(toTarget)))
                return angle <= fovRestriction
            end
            
            local function getPlayerAtCursor()
                local mousePos = UserInputService:GetMouseLocation()
                local closestPlayer = nil
                local closestDistance = math.huge
                
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local hrp = player.Character.HumanoidRootPart
                        local distance = (hrp.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                        
                        if distance <= maxDistance and isInFOV(hrp.Position) then
                            local screenPoint, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                            if onScreen then
                                local screenDist = (Vector2.new(screenPoint.X, screenPoint.Y) - mousePos).Magnitude
                                if screenDist < closestDistance and screenDist < 200 then
                                    closestPlayer = player
                                    closestDistance = screenDist
                                end
                            end
                        end
                    end
                end
                
                return closestPlayer
            end
            
            local function predictPosition(character)
                local hrp = character:FindFirstChild("HumanoidRootPart")
                if not hrp then return nil end
                
                local velocity = hrp.AssemblyLinearVelocity
                local currentPos = hrp.Position
                local predictedPos = currentPos + (velocity * predictionStrength)
                
                return predictedPos
            end
            
            smoothAimbotConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if input.KeyCode == Enum.KeyCode.T and not gameProcessed and smoothAimbotEnabled then
                    if not smoothAimbotActive then
                        smoothAimbotTarget = getPlayerAtCursor()
                        if smoothAimbotTarget then
                            smoothAimbotActive = true
                            
                            local aimAcceleration = 0
                            local lastAimTime = tick()
                            local driftOffset = Vector3.new(0, 0, 0)
                            local driftTime = 0
                            local microAdjustTimer = 0
                            local isOvershooting = false
                            local overshootTarget = nil
                            local speedVariation = 1
                            local nextSpeedChange = 0
                            local choppyDelayTimer = 0
                            local lastUpdateTime = 0
                            
                            smoothAimbotLoop = RunService.RenderStepped:Connect(function()
                                if smoothAimbotActive and smoothAimbotTarget and smoothAimbotTarget.Character and LocalPlayer.Character then
                                    local targetHRP = smoothAimbotTarget.Character:FindFirstChild("HumanoidRootPart")
                                    local localHRP = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                    
                                    if targetHRP and localHRP then
                                        local distance = (targetHRP.Position - localHRP.Position).Magnitude
                                        
                                        if distance > maxDistance or not isInFOV(targetHRP.Position) then
                                            smoothAimbotActive = false
                                            if smoothAimbotLoop then
                                                smoothAimbotLoop:Disconnect()
                                                smoothAimbotLoop = nil
                                            end
                                            Rayfield:Notify({
                                                Title = "Smooth Lock",
                                                Content = "Target out of range",
                                                Duration = 1,
                                            })
                                            return
                                        end
                                        
                                        -- Choppy movement - skip frames randomly
                                        choppyDelayTimer = choppyDelayTimer + 0.016
                                        local skipChance = math.random(1, 100)
                                        if skipChance <= 35 and choppyDelayTimer < 0.1 then
                                            return
                                        end
                                        choppyDelayTimer = 0
                                        
                                        local targetPart = smoothAimbotTarget.Character:FindFirstChild(targetBone) or targetHRP
                                        if targetPart then
                                            local predictedPos = predictPosition(smoothAimbotTarget.Character)
                                            if not predictedPos then predictedPos = targetPart.Position end
                                            
                                            local targetPartPos = targetPart.Position
                                            local finalTarget = targetPartPos:Lerp(predictedPos, 0.5)
                                            
                                            -- 20% chance to overshoot
                                            if not isOvershooting and math.random(1, 100) <= 20 then
                                                isOvershooting = true
                                                local overshootAmount = math.random(8, 25) / 100
                                                local direction = (finalTarget - Camera.CFrame.Position).Unit
                                                overshootTarget = finalTarget + (direction * (overshootAmount * distance))
                                            end
                                            
                                            if isOvershooting and overshootTarget then
                                                finalTarget = overshootTarget
                                                -- Come back from overshoot
                                                if math.random(1, 100) <= 40 then
                                                    isOvershooting = false
                                                    overshootTarget = nil
                                                end
                                            end
                                            
                                            -- More realistic up/down drift with greater amplitude
                                            driftTime = driftTime + (math.random(10, 30) / 1000)
                                            driftOffset = Vector3.new(
                                                math.sin(driftTime * math.random(15, 35) / 10) * (math.random(3, 8) / 100),
                                                math.cos(driftTime * math.random(20, 40) / 10) * (math.random(4, 10) / 100),
                                                math.sin(driftTime * math.random(10, 25) / 10) * (math.random(2, 6) / 100)
                                            )
                                            
                                            -- More chaotic random offset
                                            local randomOffset = Vector3.new(
                                                (math.random(-250, 250) / 1000),
                                                (math.random(-300, 300) / 1000),
                                                (math.random(-200, 200) / 1000)
                                            )
                                            
                                            -- Micro-adjustments like human correction
                                            microAdjustTimer = microAdjustTimer + 0.016
                                            if microAdjustTimer > math.random(5, 15) / 100 then
                                                microAdjustTimer = 0
                                                local microCorrection = Vector3.new(
                                                    (math.random(-150, 150) / 1000),
                                                    (math.random(-180, 180) / 1000),
                                                    (math.random(-100, 100) / 1000)
                                                )
                                                randomOffset = randomOffset + microCorrection
                                            end
                                            
                                            finalTarget = finalTarget + randomOffset + driftOffset
                                            
                                            local currentTime = tick()
                                            local deltaTime = currentTime - lastAimTime
                                            lastAimTime = currentTime
                                            
                                            -- Variable speed - sometimes fast, sometimes slow
                                            if currentTime >= nextSpeedChange then
                                                speedVariation = math.random(30, 200) / 100  -- 0.3x to 2x speed
                                                nextSpeedChange = currentTime + (math.random(10, 40) / 100)
                                            end
                                            
                                            aimAcceleration = math.min(aimAcceleration + (deltaTime * 0.5), 1)
                                            
                                            local distanceMultiplier = 1 - (distance / maxDistance)
                                            local distanceBasedSpeed = smoothnessValue + (smoothnessValue * distanceMultiplier * 0.5)
                                            
                                            -- Apply choppy speed variation
                                            local dynamicSmoothness = distanceBasedSpeed * aimAcceleration * speedVariation
                                            
                                            -- Add sudden speed bursts randomly
                                            if math.random(1, 100) <= 15 then
                                                dynamicSmoothness = dynamicSmoothness * math.random(15, 30) / 10
                                            end
                                            
                                            -- Occasionally move very slow (human hesitation)
                                            if math.random(1, 100) <= 12 then
                                                dynamicSmoothness = dynamicSmoothness * 0.2
                                            end
                                            
                                            local currentCFrame = Camera.CFrame
                                            local targetCFrame = CFrame.new(currentCFrame.Position, finalTarget)
                                            Camera.CFrame = currentCFrame:Lerp(targetCFrame, dynamicSmoothness)
                                        else
                                            smoothAimbotActive = false
                                            if smoothAimbotLoop then
                                                smoothAimbotLoop:Disconnect()
                                            end
                                        end
                                    else
                                        smoothAimbotActive = false
                                        if smoothAimbotLoop then
                                            smoothAimbotLoop:Disconnect()
                                        end
                                    end
                                else
                                    smoothAimbotActive = false
                                    if smoothAimbotLoop then
                                        smoothAimbotLoop:Disconnect()
                                    end
                                end
                            end)
                            
                            Rayfield:Notify({
                                Title = "Smooth Lock",
                                Content = "Locked onto " .. smoothAimbotTarget.Name,
                                Duration = 2,
                            })
                        end
                    else
                        smoothAimbotActive = false
                        smoothAimbotTarget = nil
                        if smoothAimbotLoop then
                            smoothAimbotLoop:Disconnect()
                            smoothAimbotLoop = nil
                        end
                        Rayfield:Notify({
                            Title = "Smooth Lock",
                            Content = "Lock released",
                            Duration = 2,
                        })
                    end
                end
            end)
            
            Rayfield:Notify({
                Title = "Smooth Lock",
                Content = "Smooth Lock enabled - Press T (Max 30 studs)",
                Duration = 3,
            })
        else
            smoothAimbotActive = false
            smoothAimbotTarget = nil
            if smoothAimbotConnection then
                smoothAimbotConnection:Disconnect()
                smoothAimbotConnection = nil
            end
            if smoothAimbotLoop then
                smoothAimbotLoop:Disconnect()
                smoothAimbotLoop = nil
            end
        end
    end,
})

local StrengthSlider = AttackTab:CreateSlider({
    Name = "Fling Strength",
    Range = {1, 10000},
    Increment = 50,
    CurrentValue = 450,
    Flag = "FlingStrength",
    Callback = function(Value)
        StrengthMultiplier = Value
    end,
})

local StrengthToggle = AttackTab:CreateToggle({
    Name = "Enable Strength Modifier",
    CurrentValue = false,
    Flag = "StrengthModifier",
    Callback = function(Value)
        if Value then
            local UserInputService = game:GetService("UserInputService")
            local Workspace = game:GetService("Workspace")
            local Debris = game:GetService("Debris")
            
            strengthModifierConnection = Workspace.ChildAdded:Connect(function(NewModel)
                if NewModel.Name == "GrabParts" then
                    local PartToImpulse = NewModel["GrabPart"]["WeldConstraint"].Part1
                    if PartToImpulse then
                        local VelocityObject = Instance.new("BodyVelocity", PartToImpulse)
                        NewModel:GetPropertyChangedSignal("Parent"):Connect(function()
                            if not NewModel.Parent then
                                if UserInputService:GetLastInputType() == Enum.UserInputType.MouseButton2 then
                                    VelocityObject.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                                    VelocityObject.Velocity = workspace.CurrentCamera.CFrame.lookVector * StrengthMultiplier
                                    Debris:AddItem(VelocityObject, 1)
                                elseif UserInputService:GetLastInputType() == Enum.UserInputType.MouseButton1 then
                                    VelocityObject:Destroy()
                                else
                                    VelocityObject:Destroy()
                                end
                            end
                        end)
                    end
                end
            end)
            
            Rayfield:Notify({
                Title = "Strength Modifier",
                Content = "Enabled - Right-click to fling with " .. StrengthMultiplier .. " strength",
                Duration = 3,
            })
        else
            if strengthModifierConnection then
                strengthModifierConnection:Disconnect()
                strengthModifierConnection = nil
            end
            Rayfield:Notify({
                Title = "Strength Modifier",
                Content = "Disabled",
                Duration = 2,
            })
        end
    end,
})

Rayfield:Notify({
    Title = "Welcome to Infernix",
    Content = "Executor initialized successfully!",
    Duration = 5,
    Image = 4483362458,
})
