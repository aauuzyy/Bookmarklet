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
        Note = "Get your key from our Discord or website - Keys reset every 24 hours!",
        FileName = "InfernixKey",
        SaveKey = true,
        GrabKeyFromSite = true,
        Key = {"https://YOUR-DEPLOYMENT-URL.onrender.com/keys.txt"}
    }
})

local FlameTab = Window:CreateTab("Inferno", 4483362458)
local FlameSection = FlameTab:CreateSection("Infernix Features")

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
