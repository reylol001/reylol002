-- ============================================================================
-- ZENTRA HUB with REY HUB GUI
-- ============================================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ===================== REY HUB GUI SETUP =====================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ARCANE HUB"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainContainer"
MainFrame.Size = UDim2.new(0, 700, 0, 500)
MainFrame.Position = UDim2.new(0.5, -350, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local GlassGradient = Instance.new("UIGradient")
GlassGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 25))
}
GlassGradient.Rotation = 45
GlassGradient.Parent = MainFrame

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 18)

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(80, 100, 200)
MainStroke.Thickness = 1.5
MainStroke.Transparency = 0.4
MainStroke.Parent = MainFrame

-- Animated background gradient
local AnimGradient = Instance.new("Frame")
AnimGradient.Size = UDim2.new(1, 0, 1, 0)
AnimGradient.BackgroundTransparency = 0.92
AnimGradient.BorderSizePixel = 0
AnimGradient.ZIndex = 1
AnimGradient.Parent = MainFrame

local AGGradient = Instance.new("UIGradient")
AGGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 80, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(80, 150, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 200, 255))
}
AGGradient.Rotation = 0
AGGradient.Parent = AnimGradient

RunService.Heartbeat:Connect(function(dt)
    AGGradient.Rotation = (AGGradient.Rotation + dt * 40) % 360
end)

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 55)
TitleBar.BackgroundTransparency = 1
TitleBar.BorderSizePixel = 0
TitleBar.ZIndex = 5
TitleBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 250, 0, 35)
Title.Position = UDim2.new(0, 20, 0, 10)
Title.BackgroundTransparency = 1
Title.Text = "ARCANE HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 24
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 6
Title.Parent = TitleBar

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(0, 300, 0, 18)
Subtitle.Position = UDim2.new(0, 22, 0, 38)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Guts & Blackpowder • ARCANE HUB"
Subtitle.TextColor3 = Color3.fromRGB(150, 150, 200)
Subtitle.TextSize = 11
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.TextTransparency = 0.3
Subtitle.ZIndex = 6
Subtitle.Parent = TitleBar

-- Window Buttons
local function makeWindowBtn(pos, color, label)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 36, 0, 36)
    btn.Position = UDim2.new(1, pos, 0, 10)
    btn.BackgroundColor3 = color
    btn.BackgroundTransparency = 0.2
    btn.Text = label
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.TextSize = 18
    btn.Font = Enum.Font.GothamBold
    btn.ZIndex = 6
    btn.Parent = TitleBar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1,0)
    return btn
end

local CloseBtn = makeWindowBtn(-50, Color3.fromRGB(255,60,60), "✕")
local MinBtn   = makeWindowBtn(-95, Color3.fromRGB(255,180,60), "−")

CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)
MinBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)

-- Divider under title
local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(1, -30, 0, 1)
Divider.Position = UDim2.new(0, 15, 0, 55)
Divider.BackgroundColor3 = Color3.fromRGB(80, 100, 200)
Divider.BackgroundTransparency = 0.6
Divider.BorderSizePixel = 0
Divider.ZIndex = 5
Divider.Parent = MainFrame

-- ===================== TAB SYSTEM =====================

local tabNames = {"Combat", "Auto", "ESP", "Player", "Visual", "Event", "Misc"}
local tabColors = {
    Combat = Color3.fromRGB(220, 80, 80),
    Auto   = Color3.fromRGB(80, 180, 220),
    ESP    = Color3.fromRGB(120, 220, 120),
    Player = Color3.fromRGB(220, 180, 80),
    Visual = Color3.fromRGB(180, 100, 220),
    Event  = Color3.fromRGB(255, 140, 60),
    Misc   = Color3.fromRGB(160, 160, 160),
}

-- Tab bar (left sidebar)
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(0, 140, 1, -60)
TabBar.Position = UDim2.new(0, 0, 0, 60)
TabBar.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
TabBar.BackgroundTransparency = 0.3
TabBar.BorderSizePixel = 0
TabBar.ZIndex = 5
TabBar.Parent = MainFrame

local TabList = Instance.new("UIListLayout")
TabList.Padding = UDim.new(0, 4)
TabList.FillDirection = Enum.FillDirection.Vertical
TabList.Parent = TabBar

Instance.new("UIPadding", TabBar).PaddingTop = UDim.new(0, 10)

-- Content area
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -148, 1, -65)
ContentArea.Position = UDim2.new(0, 146, 0, 62)
ContentArea.BackgroundTransparency = 1
ContentArea.BorderSizePixel = 0
ContentArea.ZIndex = 4
ContentArea.Parent = MainFrame

-- Helper: create scrolling content frame
local function makeContentFrame()
    local sf = Instance.new("ScrollingFrame")
    sf.Size = UDim2.new(1, 0, 1, 0)
    sf.BackgroundTransparency = 1
    sf.BorderSizePixel = 0
    sf.ScrollBarThickness = 3
    sf.ScrollBarImageColor3 = Color3.fromRGB(100, 150, 255)
    sf.CanvasSize = UDim2.new(0, 0, 0, 0)
    sf.AutomaticCanvasSize = Enum.AutomaticSize.Y
    sf.Visible = false
    sf.ZIndex = 4
    sf.Parent = ContentArea
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = sf
    local pad = Instance.new("UIPadding")
    pad.PaddingTop = UDim.new(0, 8)
    pad.PaddingLeft = UDim.new(0, 8)
    pad.PaddingRight = UDim.new(0, 14)
    pad.Parent = sf
    return sf
end

-- Create all tab frames
local TabFrames = {}
for _, name in ipairs(tabNames) do
    TabFrames[name] = makeContentFrame()
end

-- Tab buttons
local TabButtons = {}
local currentTab = nil

local function selectTab(name)
    if currentTab then
        TabFrames[currentTab].Visible = false
        if TabButtons[currentTab] then
            TabButtons[currentTab].BackgroundTransparency = 0.7
            TabButtons[currentTab].TextTransparency = 0.3
        end
    end
    currentTab = name
    TabFrames[name].Visible = true
    TabButtons[name].BackgroundTransparency = 0.1
    TabButtons[name].TextTransparency = 0
end

for _, name in ipairs(tabNames) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -16, 0, 38)
    btn.BackgroundColor3 = tabColors[name] or Color3.fromRGB(100,150,255)
    btn.BackgroundTransparency = 0.7
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamSemibold
    btn.TextTransparency = 0.3
    btn.ZIndex = 6
    btn.Parent = TabBar
    local c = Instance.new("UICorner", btn)
    c.CornerRadius = UDim.new(0, 10)
    local pad = Instance.new("UIPadding")
    pad.PaddingLeft = UDim.new(0, 8)
    pad.PaddingRight = UDim.new(0, 8)
    pad.Parent = TabBar
    TabButtons[name] = btn
    btn.MouseButton1Click:Connect(function() selectTab(name) end)
end

-- ===================== UI ELEMENT HELPERS =====================

local function makeSection(parent, title, order)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, 28)
    f.BackgroundTransparency = 1
    f.BorderSizePixel = 0
    f.LayoutOrder = order or 0
    f.Parent = parent
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -10, 1, 0)
    lbl.Position = UDim2.new(0, 5, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = "── " .. title .. " ──"
    lbl.TextColor3 = Color3.fromRGB(160, 160, 220)
    lbl.TextSize = 13
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 5
    lbl.Parent = f
    return f
end

local function makeToggle(parent, labelText, default, callback, order)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 40)
    row.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    row.BackgroundTransparency = 0.4
    row.BorderSizePixel = 0
    row.LayoutOrder = order or 0
    row.Parent = parent
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 10)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -70, 1, 0)
    lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = labelText
    lbl.TextColor3 = Color3.fromRGB(220, 220, 240)
    lbl.TextSize = 14
    lbl.Font = Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 6
    lbl.Parent = row

    local togBg = Instance.new("Frame")
    togBg.Size = UDim2.new(0, 46, 0, 24)
    togBg.Position = UDim2.new(1, -58, 0.5, -12)
    togBg.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    togBg.BorderSizePixel = 0
    togBg.ZIndex = 7
    togBg.Parent = row
    Instance.new("UICorner", togBg).CornerRadius = UDim.new(1, 0)

    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 18, 0, 18)
    circle.Position = UDim2.new(0, 3, 0.5, -9)
    circle.BackgroundColor3 = Color3.fromRGB(180, 180, 200)
    circle.BorderSizePixel = 0
    circle.ZIndex = 8
    circle.Parent = togBg
    Instance.new("UICorner", circle).CornerRadius = UDim.new(1, 0)

    local enabled = default or false

    local function updateVisual()
        TweenService:Create(togBg, TweenInfo.new(0.15), {
            BackgroundColor3 = enabled and Color3.fromRGB(80, 180, 120) or Color3.fromRGB(60,60,80)
        }):Play()
        TweenService:Create(circle, TweenInfo.new(0.15), {
            Position = enabled and UDim2.new(1,-21,0.5,-9) or UDim2.new(0,3,0.5,-9),
            BackgroundColor3 = enabled and Color3.fromRGB(255,255,255) or Color3.fromRGB(180,180,200)
        }):Play()
    end

    updateVisual()

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,0,1,0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.ZIndex = 9
    btn.Parent = row

    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        updateVisual()
        if callback then callback(enabled) end
    end)

    return row
end

local function makeSlider(parent, labelText, min, max, default, callback, order)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 56)
    row.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    row.BackgroundTransparency = 0.4
    row.BorderSizePixel = 0
    row.LayoutOrder = order or 0
    row.Parent = parent
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 10)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -80, 0, 22)
    lbl.Position = UDim2.new(0, 12, 0, 6)
    lbl.BackgroundTransparency = 1
    lbl.Text = labelText
    lbl.TextColor3 = Color3.fromRGB(220, 220, 240)
    lbl.TextSize = 13
    lbl.Font = Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 6
    lbl.Parent = row

    local valLbl = Instance.new("TextLabel")
    valLbl.Size = UDim2.new(0, 70, 0, 22)
    valLbl.Position = UDim2.new(1, -80, 0, 6)
    valLbl.BackgroundTransparency = 1
    valLbl.Text = tostring(default)
    valLbl.TextColor3 = Color3.fromRGB(120, 180, 255)
    valLbl.TextSize = 13
    valLbl.Font = Enum.Font.GothamBold
    valLbl.TextXAlignment = Enum.TextXAlignment.Right
    valLbl.ZIndex = 6
    valLbl.Parent = row

    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, -20, 0, 6)
    track.Position = UDim2.new(0, 10, 0, 38)
    track.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    track.BorderSizePixel = 0
    track.ZIndex = 6
    track.Parent = row
    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(100, 160, 255)
    fill.BorderSizePixel = 0
    fill.ZIndex = 7
    fill.Parent = track
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

    local value = default
    local dragging = false

    local function updateSlider(x)
        local relX = math.clamp((x - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
        value = math.floor(min + relX * (max - min) + 0.5)
        fill.Size = UDim2.new(relX, 0, 1, 0)
        valLbl.Text = tostring(value)
        if callback then callback(value) end
    end

    track.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            updateSlider(inp.Position.X)
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if dragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(inp.Position.X)
        end
    end)
    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    return row
end

local function makeDropdown(parent, labelText, values, default, callback, order)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 44)
    row.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    row.BackgroundTransparency = 0.4
    row.BorderSizePixel = 0
    row.LayoutOrder = order or 0
    row.ClipsDescendants = false
    row.Parent = parent
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 10)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0, 180, 0, 44)
    lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = labelText
    lbl.TextColor3 = Color3.fromRGB(220, 220, 240)
    lbl.TextSize = 13
    lbl.Font = Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 6
    lbl.Parent = row

    local selected = default or values[1]
    local isOpen = false

    local dropBtn = Instance.new("TextButton")
    dropBtn.Size = UDim2.new(0, 200, 0, 30)
    dropBtn.Position = UDim2.new(1, -210, 0.5, -15)
    dropBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    dropBtn.BorderSizePixel = 0
    dropBtn.Text = selected .. " ▾"
    dropBtn.TextColor3 = Color3.fromRGB(200, 200, 255)
    dropBtn.TextSize = 12
    dropBtn.Font = Enum.Font.Gotham
    dropBtn.ZIndex = 7
    dropBtn.Parent = row
    Instance.new("UICorner", dropBtn).CornerRadius = UDim.new(0, 8)

    local dropList = Instance.new("Frame")
    dropList.Size = UDim2.new(0, 200, 0, #values * 30)
    dropList.Position = UDim2.new(1, -210, 1, 2)
    dropList.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    dropList.BorderSizePixel = 0
    dropList.Visible = false
    dropList.ZIndex = 20
    dropList.Parent = row
    Instance.new("UICorner", dropList).CornerRadius = UDim.new(0, 8)

    local listLayout = Instance.new("UIListLayout")
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Parent = dropList

    for i, v in ipairs(values) do
        local opt = Instance.new("TextButton")
        opt.Size = UDim2.new(1, 0, 0, 30)
        opt.BackgroundTransparency = 1
        opt.Text = "  " .. v
        opt.TextColor3 = Color3.fromRGB(200, 200, 240)
        opt.TextSize = 12
        opt.Font = Enum.Font.Gotham
        opt.TextXAlignment = Enum.TextXAlignment.Left
        opt.ZIndex = 21
        opt.LayoutOrder = i
        opt.Parent = dropList

        opt.MouseEnter:Connect(function()
            opt.BackgroundTransparency = 0.7
            opt.BackgroundColor3 = Color3.fromRGB(80, 100, 200)
        end)
        opt.MouseLeave:Connect(function()
            opt.BackgroundTransparency = 1
        end)
        opt.MouseButton1Click:Connect(function()
            selected = v
            dropBtn.Text = v .. " ▾"
            dropList.Visible = false
            isOpen = false
            if callback then callback(v) end
        end)
    end

    dropBtn.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        dropList.Visible = isOpen
    end)

    return row
end

local function makeButton(parent, labelText, callback, order)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(60, 100, 200)
    btn.BackgroundTransparency = 0.3
    btn.BorderSizePixel = 0
    btn.Text = labelText
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamSemibold
    btn.LayoutOrder = order or 0
    btn.ZIndex = 6
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundTransparency = 0.1}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundTransparency = 0.3}):Play()
    end)
    btn.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)

    return btn
end

-- ===================== ZENTRA FEATURE VARIABLES =====================

local shoveRadius = 8
local maxShovePerCycle = 30
local maxKillPerCycle = 1
local killDelayMultiplier = 1.0
local hitboxSize = 10
local bayonetKillAuraRadius = 13
local bayonetAttackCooldown = 0.05
local autoFireRange = 50
local autoFireHeadlessRange = 100
local basePrediction = 0.15
local killAuraToggled = false
local shoveAuraToggled = false
local bayonetKillAuraToggled = false
local observerOnline = false
local killAuraConnection = nil
local isDead = false

-- ===================== FEATURE CODE =====================

local success, errorMsg = pcall(function()

local zombiesToIgnore = {}
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Stats = game:GetService("Stats")
local LocalPlayer = Players.LocalPlayer

espRToggled = false; espBToggled = false; espIToggled = false
espCuToggled = false; espBossToggled = false; espZToggled = false
autoFaceToggled = false; autoFaceConnection = nil
autoFireToggled = false; autoFireConnection = nil; isFiring = false
isReloading = false; isFireAnimPlaying = false; currentTarget = nil; isHoldingAim = false
autoFireHeadlessToggled = false; autoFireHeadlessConnection = nil
isFireHeadless = false; isFireHeadlessAnimPlaying = false; headlessBoss = nil
local FLYING = false; local NO_FALL_DAMAGE = false; local FLY_SPEED = 35
local flyControl = {forward=0,backward=0,left=0,right=0,up=0,down=0}
local flyMobileMovement = {x=0,y=0}
local QEfly=true; local iyflyspeed=1; local vehicleflyspeed=1
local flyKeyDown, flyKeyUp, mfly1, mfly2
local velocityHandlerName="IYFlyVelocity_"..math.random(1000000,9999999)
local gyroHandlerName="IYFlyGyro_"..math.random(1000000,9999999)
local IsOnMobile=table.find({Enum.Platform.Android,Enum.Platform.IOS},UIS:GetPlatform()) or (UIS.TouchEnabled and not UIS.KeyboardEnabled)
local NOCLIPPING=false; local noclipConnection=nil; local antiPullbackConnection=nil
local lastPosition=nil; local positionHistory={}; local maxHistorySize=30
local pullbackThreshold=1.5; local stuckCounter=0; local lastSafePosition=nil
local CAMERA=workspace.CurrentCamera
wallbangEnabled=false

local autoPredictionEnabled=true
if type(basePrediction)~="number" then basePrediction=0.15 end
local currentPrediction=basePrediction

local AUTO_FIRE_TARGETS={BARREL=1,IGNITER=2}
local smoothRotationSpeed=8

local function smoothLookAtWithVelocity(hrp,targetPosition,deltaTime)
    if not hrp then return end
    local targetDirection=Vector3.new(targetPosition.X-hrp.Position.X,0,targetPosition.Z-hrp.Position.Z)
    if targetDirection.Magnitude>0 then
        local targetCFrame=CFrame.lookAt(hrp.Position,hrp.Position+targetDirection.Unit)
        local alpha=1-math.exp(-smoothRotationSpeed*deltaTime)
        hrp.CFrame=hrp.CFrame:Lerp(targetCFrame,alpha)
    end
end

local function getRoot(char)
    return char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
end

local function playWeaponAnimation(weapon,animationName)
    if not weapon then return nil end
    local animTrack=nil
    pcall(function()
        local humanoid=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
        if not humanoid then return end
        local animator=humanoid:FindFirstChild("Animator"); if not animator then return end
        local animFolder=weapon:FindFirstChild("Animations")
        if animFolder then
            local anim=animFolder:FindFirstChild(animationName)
            if anim and anim:IsA("Animation") then
                animTrack=animator:LoadAnimation(anim)
                animTrack.Looped=false; animTrack:Play()
            end
        end
    end)
    return animTrack
end

local function stopWeaponAnimation(animTrack)
    if animTrack then pcall(function() animTrack:Stop(); animTrack:Destroy() end) end
end

local function getWeaponAnimationLength(weapon,animationType)
    local animationTimes={Fire=0.5,Reload=3.5,Aim=0.3,Aiming=999}
    if weapon then
        local n=weapon.Name:lower()
        if n:find("musket") or n:find("charleville") then animationTimes.Reload=4.0
        elseif n:find("pistol") then animationTimes.Reload=3.0; animationTimes.Fire=0.4
        elseif n:find("blunderbuss") then animationTimes.Reload=3.5; animationTimes.Fire=0.6
        elseif n:find("carbine") then animationTimes.Reload=3.2 end
    end
    return animationTimes[animationType] or 1.0
end

local function getEquippedFlintlock()
    if not LocalPlayer.Character then return nil end
    for _,tool in pairs(LocalPlayer.Character:GetChildren()) do
        if tool:IsA("Tool") then
            local config=tool:FindFirstChild("Configuration")
            if config and (tool:FindFirstChild("RemoteEvent") or tool:FindFirstChild("Remote")) then return tool end
        end
    end
    return nil
end

local function isTargetVisible(startPos,targetPos,targetModel)
    if wallbangEnabled then return true end
    local rayParams=RaycastParams.new()
    local ignoreList={LocalPlayer.Character}
    rayParams.FilterType=Enum.RaycastFilterType.Exclude; rayParams.IgnoreWater=true
    pcall(function() for _,zombie in pairs(workspace.Zombies:GetChildren()) do if zombie~=targetModel then table.insert(ignoreList,zombie) end end end)
    pcall(function()
        for _,child in pairs(workspace.Camera:GetChildren()) do
            if child.Name=="m_Zombie" then
                local Origin=child:FindFirstChild("Orig")
                if Origin and Origin.Value and Origin.Value~=targetModel then
                    table.insert(ignoreList,child); table.insert(ignoreList,Origin.Value)
                end
            end
        end
    end)
    rayParams.FilterDescendantsInstances=ignoreList
    local direction=targetPos-startPos
    local rayResult=workspace:Raycast(startPos,direction,rayParams)
    if rayResult then
        local hitPart=rayResult.Instance
        if hitPart:IsDescendantOf(targetModel) then return true end
        if hitPart.Parent.Name=="m_Zombie" then
            local Origin=hitPart.Parent:FindFirstChild("Orig")
            if Origin and Origin.Value==targetModel then return true end
        end
        if hitPart.CanCollide==false then
            local newRayParams=RaycastParams.new()
            newRayParams.FilterDescendantsInstances={LocalPlayer.Character,hitPart,unpack(zombiesToIgnore)}
            newRayParams.FilterType=Enum.RaycastFilterType.Exclude; newRayParams.IgnoreWater=true
            local newRayResult=workspace:Raycast(startPos,direction,newRayParams)
            if newRayResult then
                if newRayResult.Instance:IsDescendantOf(targetModel) then return true end
                if newRayResult.Instance.Parent.Name=="m_Zombie" then
                    local Origin=newRayResult.Instance.Parent:FindFirstChild("Orig")
                    if Origin and Origin.Value==targetModel then return true end
                end
                return false
            else return false end
        end
        return false
    end
    return true
end

local function isHeadlessVisible(startPos,targetPos,headlessBoss)
    if wallbangEnabled then return true end
    local zIgnore={}
    pcall(function() for _,zombie in pairs(workspace.Zombies:GetChildren()) do table.insert(zIgnore,zombie) end end)
    pcall(function()
        for _,child in pairs(workspace.Camera:GetChildren()) do
            if child.Name=="m_Zombie" then
                table.insert(zIgnore,child)
                local Origin=child:FindFirstChild("Orig")
                if Origin and Origin.Value then table.insert(zIgnore,Origin.Value) end
            end
        end
    end)
    local rayParams=RaycastParams.new()
    rayParams.FilterDescendantsInstances={LocalPlayer.Character,unpack(zIgnore)}
    rayParams.FilterType=Enum.RaycastFilterType.Exclude; rayParams.IgnoreWater=true
    local direction=targetPos-startPos
    local rayResult=workspace:Raycast(startPos,direction,rayParams)
    if rayResult then
        local hitPart=rayResult.Instance
        if headlessBoss and hitPart:IsDescendantOf(headlessBoss) then return true end
        if hitPart.CanCollide==false then
            local newRayParams=RaycastParams.new()
            newRayParams.FilterDescendantsInstances={LocalPlayer.Character,hitPart,unpack(zIgnore)}
            newRayParams.FilterType=Enum.RaycastFilterType.Exclude; newRayParams.IgnoreWater=true
            local newRayResult=workspace:Raycast(startPos,direction,newRayParams)
            if newRayResult then
                if headlessBoss and newRayResult.Instance:IsDescendantOf(headlessBoss) then return true end
                return false
            else return false end
        end
        return false
    end
    return true
end

local function findHeadlessBoss()
    local success,result=pcall(function()
        local sh=workspace:FindFirstChild("Sleepy Hollow"); if not sh then return nil end
        local modes=sh:FindFirstChild("Modes"); if not modes then return nil end
        local boss=modes:FindFirstChild("Boss"); if not boss then return nil end
        local hb=boss:FindFirstChild("HeadlessHorsemanBoss"); if not hb then return nil end
        return hb:FindFirstChild("HeadlessHorseman")
    end)
    return success and result or nil
end

local function calculateAutoPrediction()
    if not autoPredictionEnabled or not headlessBoss then return basePrediction end
    local torso=headlessBoss:FindFirstChild("Torso"); if not torso then return basePrediction end
    local velocity=torso.AssemblyLinearVelocity or Vector3.new(0,0,0)
    local speed=velocity.Magnitude
    local prediction=basePrediction
    if speed<5 then prediction=0.05
    elseif speed<15 then prediction=0.1
    elseif speed<25 then prediction=0.15
    elseif speed<35 then prediction=0.25
    else prediction=0.35 end
    local hrp=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp and torso then
        local direction=(torso.Position-hrp.Position).Unit
        local moveDirection=velocity.Unit
        local dotProduct=direction:Dot(moveDirection)
        if math.abs(dotProduct)<0.5 then prediction=prediction*1.3 end
    end
    return prediction
end

task.spawn(function()
    while true do
        task.wait(0.1)
        if autoPredictionEnabled and autoFireHeadlessToggled then
            currentPrediction=calculateAutoPrediction()
        end
    end
end)

local function getPredictedHeadlessPosition()
    if not headlessBoss or not headlessBoss.Parent then return nil end
    local torso=headlessBoss:FindFirstChild("Torso"); if not torso then return nil end
    local velocity=torso.AssemblyLinearVelocity or Vector3.new(0,0,0)
    return torso.Position+(velocity*currentPrediction)
end

local function findNearestTarget()
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return nil,nil,nil end
    local hrp=LocalPlayer.Character.HumanoidRootPart
    local head=LocalPlayer.Character:FindFirstChild("Head"); if not head then return nil,nil,nil end
    local candidates={}
    pcall(function()
        for _,zombie in pairs(workspace.Zombies:GetChildren()) do
            local zombieHRP=zombie:FindFirstChild("HumanoidRootPart")
            local zombieHead=zombie:FindFirstChild("Head")
            local hasBarrel=zombie:FindFirstChild("Barrel")~=nil
            if zombieHRP and zombieHead and hasBarrel then
                local distance=(zombieHRP.Position-hrp.Position).Magnitude
                if distance<autoFireRange then
                    table.insert(candidates,{zombie=zombie,head=zombieHead,distance=distance,priority=AUTO_FIRE_TARGETS.BARREL,targetType="Barrel"})
                end
            end
        end
    end)
    pcall(function()
        for _,child in pairs(workspace.Camera:GetChildren()) do
            if child.Name=="m_Zombie" then
                local Origin=child:FindFirstChild("Orig")
                if Origin and Origin.Value then
                    local zombie=Origin.Value
                    local zombieHRP=zombie:FindFirstChild("HumanoidRootPart")
                    local zombieHead=zombie:FindFirstChild("Head")
                    local hasBarrel=child:FindFirstChild("Barrel")~=nil
                    if zombieHRP and zombieHead and hasBarrel then
                        local distance=(zombieHRP.Position-hrp.Position).Magnitude
                        if distance<autoFireRange then
                            table.insert(candidates,{zombie=zombie,head=zombieHead,distance=distance,priority=AUTO_FIRE_TARGETS.BARREL,targetType="Barrel"})
                        end
                    end
                end
                local lantern=child:FindFirstChild("Whale Oil Lantern")
                if lantern then
                    local Origin=child:FindFirstChild("Orig")
                    if Origin and Origin.Value then
                        local zombie=Origin.Value
                        local zombieHRP=zombie:FindFirstChild("HumanoidRootPart")
                        local zombieHead=zombie:FindFirstChild("Head")
                        if zombieHRP and zombieHead then
                            local distance=(zombieHRP.Position-hrp.Position).Magnitude
                            if distance<autoFireRange then
                                table.insert(candidates,{zombie=zombie,head=zombieHead,distance=distance,priority=AUTO_FIRE_TARGETS.IGNITER,targetType="Igniter"})
                            end
                        end
                    end
                end
            end
        end
    end)
    table.sort(candidates,function(a,b)
        if a.priority~=b.priority then return a.priority<b.priority end
        return a.distance<b.distance
    end)
    if wallbangEnabled and #candidates>0 then
        local target=candidates[1]; return target.zombie,target.head,target.targetType
    end
    for _,candidate in ipairs(candidates) do
        if isTargetVisible(head.Position,candidate.head.Position,candidate.zombie) then
            return candidate.zombie,candidate.head,candidate.targetType
        end
    end
    return nil,nil,nil
end

local currentAimTrack,currentFireTrack,currentHeadlessAimTrack,currentHeadlessFireTrack
local aimingForShot,rotatingToTarget,targetRotation

local function autoFireAtTarget()
    if not autoFireToggled or not LocalPlayer.Character then return end
    if isFiring or isReloading or isFireAnimPlaying then return end
    local weapon=getEquippedFlintlock(); if not weapon then return end
    local ammo=weapon:FindFirstChild("Ammo") or weapon:FindFirstChild("ShotsLoaded")
    if not ammo or ammo.Value<=0 then
        if isHoldingAim then stopWeaponAnimation(currentAimTrack); currentAimTrack=nil; isHoldingAim=false end
        currentTarget=nil; return
    end
    local targetZombie,targetHead,targetType=findNearestTarget()
    if not targetZombie or not targetHead then
        if isHoldingAim then stopWeaponAnimation(currentAimTrack); currentAimTrack=nil; isHoldingAim=false end
        currentTarget=nil; return
    end
    local remoteEvent=weapon:FindFirstChild("RemoteEvent") or weapon:FindFirstChild("Remote"); if not remoteEvent then return end
    local model=weapon:FindFirstChild("ModelReference"); if model then model=model.Value end; if not model then return end
    isFiring=true; isFireAnimPlaying=true; aimingForShot=true; currentTarget=targetZombie
    local hrp=LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not isHoldingAim then
        currentAimTrack=playWeaponAnimation(weapon,"Aim")
        if currentAimTrack then currentAimTrack.Looped=false end
        task.wait(getWeaponAnimationLength(weapon,"Aim"))
        stopWeaponAnimation(currentAimTrack)
        currentAimTrack=playWeaponAnimation(weapon,"Aiming")
        if currentAimTrack then currentAimTrack.Looped=true end
        isHoldingAim=true
    end
    if hrp then
        rotatingToTarget=true; targetRotation=targetHead.Position
        local rotationTime=0; local maxRotationTime=1.0
        local rotateConnection
        rotateConnection=RunService.RenderStepped:Connect(function(deltaTime)
            if not rotatingToTarget or not targetRotation then if rotateConnection then rotateConnection:Disconnect() end return end
            if currentTarget and currentTarget:FindFirstChild("Head") then targetRotation=currentTarget.Head.Position end
            smoothLookAtWithVelocity(hrp,targetRotation,deltaTime)
            rotationTime=rotationTime+deltaTime
            local currentDirection=hrp.CFrame.LookVector
            local targetDirection=(targetRotation-hrp.Position).Unit
            local dotProduct=currentDirection:Dot(Vector3.new(targetDirection.X,0,targetDirection.Z).Unit)
            if dotProduct>0.98 or rotationTime>=maxRotationTime then
                rotatingToTarget=false; if rotateConnection then rotateConnection:Disconnect() end
            end
        end)
        while rotatingToTarget do task.wait() end
    end
    stopWeaponAnimation(currentAimTrack); currentAimTrack=nil; aimingForShot=false; isHoldingAim=false
    local fireOk=pcall(function()
        local targetPosition=targetHead.Position
        local serverTime=workspace:GetServerTimeNow()
        currentFireTrack=playWeaponAnimation(weapon,"Fire")
        remoteEvent:FireServer("Fire",model,targetPosition,serverTime)
    end)
    local fireTime=getWeaponAnimationLength(weapon,"Fire")
    if fireOk then task.wait(fireTime) end
    stopWeaponAnimation(currentFireTrack); currentFireTrack=nil
    isFireAnimPlaying=false; isFiring=false; aimingForShot=false; isHoldingAim=false; currentTarget=nil
    if fireOk then _G.AutoReloadV2.ReloadWeapon(weapon) end
end

local function autoFireAtHeadless()
    if not autoFireHeadlessToggled or not LocalPlayer.Character then return end
    if isFireHeadless or isReloading or isFireHeadlessAnimPlaying then return end
    headlessBoss=findHeadlessBoss()
    if not headlessBoss or not headlessBoss.Parent then
        if isHoldingAim then stopWeaponAnimation(currentHeadlessAimTrack); currentHeadlessAimTrack=nil; isHoldingAim=false end
        return
    end
    local torso=headlessBoss:FindFirstChild("Torso"); if not torso then return end
    local hrp=LocalPlayer.Character.HumanoidRootPart
    local head=LocalPlayer.Character:FindFirstChild("Head"); if not hrp or not head then return end
    local distance=(torso.Position-hrp.Position).Magnitude
    if distance>autoFireHeadlessRange then
        if isHoldingAim then stopWeaponAnimation(currentHeadlessAimTrack); currentHeadlessAimTrack=nil; isHoldingAim=false end
        return
    end
    local predictedPos=getPredictedHeadlessPosition(); if not predictedPos then return end
    if not isHeadlessVisible(head.Position,predictedPos,headlessBoss) then
        if isHoldingAim then stopWeaponAnimation(currentHeadlessAimTrack); currentHeadlessAimTrack=nil; isHoldingAim=false end
        return
    end
    local weapon=getEquippedFlintlock(); if not weapon then return end
    local ammo=weapon:FindFirstChild("Ammo") or weapon:FindFirstChild("ShotsLoaded")
    if not ammo or ammo.Value<=0 then
        if isHoldingAim then stopWeaponAnimation(currentHeadlessAimTrack); currentHeadlessAimTrack=nil; isHoldingAim=false end
        return
    end
    local remoteEvent=weapon:FindFirstChild("RemoteEvent") or weapon:FindFirstChild("Remote"); if not remoteEvent then return end
    local model=weapon:FindFirstChild("ModelReference"); if model then model=model.Value end; if not model then return end
    isFireHeadless=true; isFireHeadlessAnimPlaying=true
    if not isHoldingAim then
        currentHeadlessAimTrack=playWeaponAnimation(weapon,"Aim")
        if currentHeadlessAimTrack then currentHeadlessAimTrack.Looped=false end
        task.wait(getWeaponAnimationLength(weapon,"Aim"))
        stopWeaponAnimation(currentHeadlessAimTrack)
        currentHeadlessAimTrack=playWeaponAnimation(weapon,"Aiming")
        if currentHeadlessAimTrack then currentHeadlessAimTrack.Looped=true end
        isHoldingAim=true
    end
    local rotatingToHeadless=true; local targetHeadlessRotation=predictedPos
    local rotationTime=0; local maxRotationTime=1.0
    local rotateConnection
    rotateConnection=RunService.RenderStepped:Connect(function(deltaTime)
        if not rotatingToHeadless or not targetHeadlessRotation then if rotateConnection then rotateConnection:Disconnect() end return end
        local newPredicted=getPredictedHeadlessPosition()
        if newPredicted then targetHeadlessRotation=newPredicted end
        smoothLookAtWithVelocity(hrp,targetHeadlessRotation,deltaTime)
        rotationTime=rotationTime+deltaTime
        local currentDirection=hrp.CFrame.LookVector
        local targetDirection=(targetHeadlessRotation-hrp.Position).Unit
        local dotProduct=currentDirection:Dot(Vector3.new(targetDirection.X,0,targetDirection.Z).Unit)
        if dotProduct>0.98 or rotationTime>=maxRotationTime then
            rotatingToHeadless=false; if rotateConnection then rotateConnection:Disconnect() end
        end
    end)
    while rotatingToHeadless do task.wait() end
    stopWeaponAnimation(currentHeadlessAimTrack); currentHeadlessAimTrack=nil; isHoldingAim=false
    local fireOk=pcall(function()
        local serverTime=workspace:GetServerTimeNow()
        currentHeadlessFireTrack=playWeaponAnimation(weapon,"Fire")
        remoteEvent:FireServer("Fire",model,predictedPos,serverTime)
    end)
    local fireTime=getWeaponAnimationLength(weapon,"Fire")
    if fireOk then task.wait(fireTime) end
    stopWeaponAnimation(currentHeadlessFireTrack); currentHeadlessFireTrack=nil
    isFireHeadlessAnimPlaying=false; isFireHeadless=false; isHoldingAim=false
    if fireOk then _G.AutoReloadV2.ReloadWeapon(weapon) end
end

local function toggleWallbang(enabled) wallbangEnabled=enabled end

local function startAutoFire()
    if autoFireConnection then autoFireConnection:Disconnect(); autoFireConnection=nil end
    autoFireConnection=RunService.Heartbeat:Connect(function()
        if not autoFireToggled then autoFireConnection:Disconnect(); autoFireConnection=nil; return end
        if not isFiring and not isFireAnimPlaying then task.spawn(autoFireAtTarget) end
    end)
end

local function startAutoFireHeadless()
    if autoFireHeadlessConnection then autoFireHeadlessConnection:Disconnect(); autoFireHeadlessConnection=nil end
    autoFireHeadlessConnection=RunService.Heartbeat:Connect(function()
        if not autoFireHeadlessToggled then autoFireHeadlessConnection:Disconnect(); autoFireHeadlessConnection=nil; return end
        if not isFireHeadless and not isFireHeadlessAnimPlaying then task.spawn(autoFireAtHeadless) end
    end)
end

local function toggleAutoFire(enabled)
    autoFireToggled=enabled
    if enabled then
        isFiring=false; isReloading=false; isFireAnimPlaying=false; currentTarget=nil; startAutoFire()
    else
        stopWeaponAnimation(currentAimTrack); stopWeaponAnimation(currentFireTrack)
        currentAimTrack=nil; currentFireTrack=nil
        if autoFireConnection then autoFireConnection:Disconnect(); autoFireConnection=nil end
        isFiring=false; isReloading=false; isFireAnimPlaying=false; aimingForShot=false; currentTarget=nil
    end
end

local function toggleAutoFireHeadless(enabled)
    autoFireHeadlessToggled=enabled
    if enabled then
        isFireHeadless=false; isReloading=false; isFireHeadlessAnimPlaying=false; headlessBoss=nil; startAutoFireHeadless()
    else
        stopWeaponAnimation(currentHeadlessAimTrack); stopWeaponAnimation(currentHeadlessFireTrack)
        currentHeadlessAimTrack=nil; currentHeadlessFireTrack=nil
        if autoFireHeadlessConnection then autoFireHeadlessConnection:Disconnect(); autoFireHeadlessConnection=nil end
        isFireHeadless=false; isReloading=false; isFireHeadlessAnimPlaying=false; headlessBoss=nil
    end
end

-- Auto Reload V2
local RunService2=game:GetService("RunService")
local autoReloadToggled=false; local autoReloadConnection=nil; local currentReloadMode=2
local activeReloads={}; local lastReloadAttempt={}
local ReloadMode={FAST=1,ANIMATION=2,BACKGROUND=3}

local function getEquippedWeapon()
    if not LocalPlayer.Character then return nil end
    for _,tool in pairs(LocalPlayer.Character:GetChildren()) do
        if tool:IsA("Tool") then
            local remoteEvent=tool:FindFirstChild("RemoteEvent") or tool:FindFirstChild("Remote")
            if remoteEvent then return tool end
        end
    end
    return nil
end

local function getWeaponAmmo(weapon) if not weapon then return 0 end; local ammo=weapon:FindFirstChild("Ammo") or weapon:FindFirstChild("ShotsLoaded"); if ammo then return ammo.Value end; return 0 end
local function getWeaponCartridges(weapon) if not weapon then return 0 end; local c=weapon:FindFirstChild("Cartridges"); if c then return c.Value end; return 999 end
local function needsReload(weapon) if not weapon then return false end; return getWeaponAmmo(weapon)<=0 and getWeaponCartridges(weapon)>0 end
local function isWeaponInInventory(weapon)
    if not weapon or not weapon.Parent then return false end
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(weapon.Name) then return true end
    if LocalPlayer.Backpack:FindFirstChild(weapon.Name) then return true end
    return false
end

local function bypassServerReloadChecks(weapon)
    if not weapon then return false end
    pcall(function()
        weapon:SetAttribute("Reloading",false); weapon:SetAttribute("Stancing",false)
        weapon:SetAttribute("Firing",false); weapon:SetAttribute("Aiming",false)
        weapon:SetAttribute("IsReloading",false); weapon:SetAttribute("ReloadLocked",false)
        local reloadStage=weapon:FindFirstChild("ReloadStage"); if reloadStage then reloadStage.Value=0 end
        local ammo=weapon:FindFirstChild("Ammo") or weapon:FindFirstChild("ShotsLoaded")
        if ammo then ammo.Value=0; task.wait(0.03) end
        local cfg=weapon:FindFirstChild("Configuration")
        if cfg then pcall(function() cfg:SetAttribute("Reloading",false); cfg:SetAttribute("Stancing",false) end) end
    end)
    return true
end

local function stealthReloadSequence(weapon)
    if not weapon then return false end
    local remoteEvent=weapon:FindFirstChild("RemoteEvent") or weapon:FindFirstChild("Remote"); if not remoteEvent then return false end
    local success=false
    task.spawn(function()
        bypassServerReloadChecks(weapon)
        for i=1,3 do
            pcall(function() remoteEvent:FireServer("Reload") end); task.wait(0.1)
            local ammo=getWeaponAmmo(weapon); if ammo>0 then success=true; break end
            pcall(function()
                local reloadStage=weapon:FindFirstChild("ReloadStage")
                if reloadStage then
                    reloadStage.Value=1; task.wait(0.05); remoteEvent:FireServer("Reload")
                    task.wait(0.1); reloadStage.Value=2; task.wait(0.05); remoteEvent:FireServer("Reload")
                end
            end); task.wait(0.1)
        end
        if success then pcall(function() weapon:SetAttribute("Reloading",false); weapon:SetAttribute("Stancing",false) end) end
    end)
    return true
end

local function fastReload(weapon)
    if not weapon then return false end
    local remoteEvent=weapon:FindFirstChild("RemoteEvent") or weapon:FindFirstChild("Remote"); if not remoteEvent then return false end
    bypassServerReloadChecks(weapon); pcall(function() remoteEvent:FireServer("Reload") end); task.wait(0.5); return true
end

local function animationReloadMode(weapon)
    if not weapon or not weapon.Parent then return false end
    if not LocalPlayer.Character then return false end
    if isReloading then return false end
    local remoteEvent=weapon:FindFirstChild("RemoteEvent") or weapon:FindFirstChild("Remote"); if not remoteEvent then return false end
    local isEquipped=LocalPlayer.Character:FindFirstChild(weapon.Name)~=nil; if not isEquipped then return false end
    isReloading=true; bypassServerReloadChecks(weapon); pcall(function() remoteEvent:FireServer("Reload") end); task.wait(4.5); isReloading=false; return true
end

local function backgroundReload(weapon)
    if not weapon then return false end
    if activeReloads[weapon] then return false end
    activeReloads[weapon]=true
    task.spawn(function()
        stealthReloadSequence(weapon)
        local maxWait=8; local startTime=tick(); local startAmmo=getWeaponAmmo(weapon)
        while tick()-startTime<maxWait do
            task.wait(0.2)
            if not isWeaponInInventory(weapon) then break end
            if getWeaponAmmo(weapon)>startAmmo then break end
            local remoteEvent=weapon:FindFirstChild("RemoteEvent") or weapon:FindFirstChild("Remote")
            if remoteEvent then pcall(function() bypassServerReloadChecks(weapon); remoteEvent:FireServer("Reload") end) end
        end
        activeReloads[weapon]=nil
        pcall(function() weapon:SetAttribute("Reloading",false); weapon:SetAttribute("Stancing",false); weapon:SetAttribute("Firing",false) end)
    end)
    return true
end

local function performReload(weapon)
    if not weapon or not needsReload(weapon) then return false end
    local currentTime=tick()
    if lastReloadAttempt[weapon] and currentTime-lastReloadAttempt[weapon]<0.8 then return false end
    lastReloadAttempt[weapon]=currentTime
    if currentReloadMode==ReloadMode.FAST then return fastReload(weapon)
    elseif currentReloadMode==ReloadMode.ANIMATION then return animationReloadMode(weapon)
    elseif currentReloadMode==ReloadMode.BACKGROUND then return backgroundReload(weapon) end
    return false
end

local lastCheck=0; local CHECK_INTERVAL=0.3

local function startAutoReload()
    if autoReloadConnection then autoReloadConnection:Disconnect() end
    autoReloadConnection=RunService2.Heartbeat:Connect(function()
        if not autoReloadToggled then return end
        local currentTime=tick(); if currentTime-lastCheck<CHECK_INTERVAL then return end; lastCheck=currentTime
        local equippedWeapon=getEquippedWeapon()
        if equippedWeapon and needsReload(equippedWeapon) then
            if currentReloadMode==ReloadMode.ANIMATION or currentReloadMode==ReloadMode.FAST then
                task.spawn(function() performReload(equippedWeapon) end)
            end
        end
        if currentReloadMode==ReloadMode.BACKGROUND then
            for _,weapon in pairs(LocalPlayer.Backpack:GetChildren()) do
                if weapon:IsA("Tool") and needsReload(weapon) then task.spawn(function() performReload(weapon) end) end
            end
            if equippedWeapon and needsReload(equippedWeapon) then task.spawn(function() performReload(equippedWeapon) end) end
        end
    end)
end

local function toggleAutoReload(enabled)
    autoReloadToggled=enabled
    if enabled then startAutoReload()
    else if autoReloadConnection then autoReloadConnection:Disconnect(); autoReloadConnection=nil end end
end

local function setReloadMode(mode)
    if mode<1 or mode>3 then return end
    currentReloadMode=mode
    if autoReloadToggled then toggleAutoReload(false); task.wait(0.1); toggleAutoReload(true) end
end

_G.AutoReloadV2={
    Toggle=toggleAutoReload,SetMode=setReloadMode,
    IsEnabled=function() return autoReloadToggled end,
    GetMode=function() return currentReloadMode end,
    ReloadWeapon=performReload,Modes=ReloadMode
}

-- ESP
local bossFolder=nil; local bossESPConnection=nil
local function updateBossESP()
    pcall(function()
        local sleepyHollow=workspace:WaitForChild("Sleepy Hollow",5); if not sleepyHollow then return end
        local modes=sleepyHollow:FindFirstChild("Modes"); if not modes then return end
        local boss=modes:FindFirstChild("Boss"); if not boss then return end
        bossFolder=boss:FindFirstChild("HeadlessHorsemanBoss")
        if bossFolder then
            if not espBossToggled then
                for _,child in pairs(bossFolder:GetChildren()) do if child:FindFirstChild("Highlight") then child.Highlight:Destroy() end end
                return
            end
            for _,child in pairs(bossFolder:GetChildren()) do
                if child and child.Parent and not child:FindFirstChild("Highlight") then
                    local h=Instance.new("Highlight"); h.Parent=child; h.Adornee=child
                    h.FillColor=Color3.fromRGB(255,0,0); h.OutlineColor=Color3.fromRGB(255,255,255); h.OutlineTransparency=0.5
                end
            end
        end
    end)
end
local function setupBossESP()
    if bossESPConnection then bossESPConnection:Disconnect(); bossESPConnection=nil end
    task.spawn(function()
        while task.wait(2) do
            if not espBossToggled then return end
            updateBossESP()
            if bossFolder and not bossESPConnection then
                bossESPConnection=bossFolder.ChildAdded:Connect(function(child)
                    if espBossToggled and child and child.Parent then
                        task.wait(0.1)
                        if not child:FindFirstChild("Highlight") then
                            local h=Instance.new("Highlight"); h.Parent=child; h.Adornee=child
                            h.FillColor=Color3.fromRGB(255,0,0); h.OutlineColor=Color3.fromRGB(255,255,255); h.OutlineTransparency=0.5
                        end
                    end
                end)
            elseif not bossFolder and bossESPConnection then bossESPConnection:Disconnect(); bossESPConnection=nil end
        end
    end)
end
setupBossESP()

workspace.Camera.ChildAdded:Connect(function(child)
    if child.Name=="m_Zombie" then
        task.spawn(function()
            local Origin=child:FindFirstChild("Orig")
            if not Origin then task.wait(0.1); Origin=child:FindFirstChild("Orig") end
            if Origin and Origin.Value~=nil then
                local zombie=Origin.Value:FindFirstChild("Zombie"); if not zombie then return end
                if espRToggled and zombie.WalkSpeed>16 then local h=Instance.new("Highlight"); h.Parent=child; h.Adornee=child end
                if espBToggled and child:FindFirstChild("Barrel")~=nil then local h=Instance.new("Highlight"); h.Parent=child; h.Adornee=child; h.FillColor=Color3.fromRGB(65,105,225) end
                if espIToggled and child:FindFirstChild("Whale Oil Lantern")~=nil then local h=Instance.new("Highlight"); h.Parent=child; h.Adornee=child; h.FillColor=Color3.fromRGB(255,255,51) end
                if espCuToggled and child:FindFirstChild("Sword")~=nil then local h=Instance.new("Highlight"); h.Parent=child; h.Adornee=child; h.FillColor=Color3.fromRGB(65,105,225) end
                if espZToggled and child:FindFirstChild("Axe")~=nil then local h=Instance.new("Highlight"); h.Parent=child; h.Adornee=child; h.FillColor=Color3.fromRGB(255,0,255) end
            end
        end)
    end
end)

espMedicToggled=false; espInfectionToggled=false
function checkPlayersLife()
    if not espMedicToggled and not espInfectionToggled then
        for _,player in pairs(workspace.Players:GetChildren()) do if player:FindFirstChild("Highlight") then player.Highlight:Destroy() end end
        return
    end
    while espMedicToggled or espInfectionToggled do
        for _,player in pairs(workspace.Players:GetChildren()) do
            if espMedicToggled then
                local humanoid=player:FindFirstChild("Humanoid")
                if humanoid and humanoid.Health<60 and player.Name~=LocalPlayer.Name and
                   (LocalPlayer.Backpack:FindFirstChild("Medical Supplies") or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Medical Supplies"))) then
                    if not player:FindFirstChild("Highlight") then
                        local h=Instance.new("Highlight"); h.Parent=player; h.Adornee=player
                        h.FillColor=Color3.fromRGB(255,169,108); h.FillTransparency=0.8
                        h.OutlineColor=Color3.fromRGB(255,206,108); h.OutlineTransparency=0.2
                    end
                else if player:FindFirstChild("Highlight") then player.Highlight:Destroy() end end
            end
            if espInfectionToggled then
                if LocalPlayer.Backpack:FindFirstChild("Mercy") or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Mercy")) then
                    local userStates=player:FindFirstChild("UserStates")
                    if userStates and userStates:FindFirstChild("Infected") then
                        local infectedVal=userStates.Infected.Value
                        if infectedVal>10 then
                            local existingHighlight=player:FindFirstChild("Highlight")
                            if infectedVal>89 then
                                local h=existingHighlight or Instance.new("Highlight")
                                h.Parent=player; h.Adornee=player; h.FillColor=Color3.fromRGB(178,34,34)
                            else
                                if not existingHighlight then
                                    local h=Instance.new("Highlight"); h.Parent=player; h.Adornee=player
                                    h.FillColor=Color3.fromRGB(255,169,108); h.FillTransparency=0.8
                                    h.OutlineColor=Color3.fromRGB(255,206,108); h.OutlineTransparency=0.2
                                end
                            end
                        elseif player:FindFirstChild("Highlight") and infectedVal==0 then player.Highlight:Destroy() end
                    end
                end
            end
        end
        task.wait(2.0)
    end
end

toolEquip=true

LocalPlayer.CharacterAdded:Connect(function(character)
    stopWeaponAnimation(currentAimTrack); stopWeaponAnimation(currentFireTrack)
    currentAimTrack=nil; currentFireTrack=nil
    stopWeaponAnimation(currentHeadlessAimTrack); stopWeaponAnimation(currentHeadlessFireTrack)
    currentHeadlessAimTrack=nil; currentHeadlessFireTrack=nil
    isReloading=false; activeReloads={}; lastReloadAttempt={}
    isFiring=false; isFireAnimPlaying=false; currentTarget=nil
    isFireHeadless=false; isFireHeadlessAnimPlaying=false; headlessBoss=nil
    if autoFireToggled then task.wait(1); startAutoFire() end
    if autoFireHeadlessToggled then task.wait(1); startAutoFireHeadless() end
    if autoReloadToggled then task.wait(1); _G.AutoReloadV2.Toggle(false); task.wait(0.1); _G.AutoReloadV2.Toggle(true) end
end)

-- Kill & Shove Aura
observerOnline=false; killAuraToggled=false; shoveAuraToggled=false; isDead=false; killAuraConnection=nil
shoveRadius=8; maxShovePerCycle=30
local stunCooldowns={}; local lastShoveTime=0; local shoveStunCooldown=0.15; local lastAttackTime=0
local killAuraRadius=13
maxKillPerCycle=maxKillPerCycle or 1; killDelayMultiplier=killDelayMultiplier or 1.0
local adaptiveKillDelay=0.2; local adaptiveAttackDelay=0.2; local killAuraActive=true
local cycleStartTime=tick(); local cycleDuration=0.1; local pauseDuration=1.0
local currentPing=0; local lagCompensationMultiplier=1.0

local function updatePing()
    task.spawn(function()
        while task.wait(2) do
            pcall(function()
                currentPing=Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
                if currentPing>200 then lagCompensationMultiplier=1.3; adaptiveAttackDelay=0.3; pauseDuration=1.5
                elseif currentPing>100 then lagCompensationMultiplier=1.15; adaptiveAttackDelay=0.25; pauseDuration=1.2
                else lagCompensationMultiplier=1.0; adaptiveAttackDelay=0.2; pauseDuration=1.0 end
            end)
        end
    end)
end
updatePing()

local raycastParams=RaycastParams.new()
raycastParams.FilterDescendantsInstances={LocalPlayer.Character}
raycastParams.FilterType=Enum.RaycastFilterType.Exclude
local params=OverlapParams.new()
params.FilterDescendantsInstances={LocalPlayer.Character}

function getEquippedWeapon()
    if not LocalPlayer.Character then return nil end
    for _,child in pairs(LocalPlayer.Character:GetChildren()) do
        if child:IsA("Tool") and (child:FindFirstChild("RemoteEvent") or child:FindFirstChild("Remote")) then return child end
    end
    return nil
end

function canWeaponShove(weapon)
    if not weapon then return false end
    local shoveWeapons={"Pickaxe","Axe","Carbine","Navy Pistol","Baguette"}
    for _,sw in pairs(shoveWeapons) do if weapon.Name:lower():find(sw:lower()) then return true end end
    if weapon:GetAttribute("CanShove")==true then return true end
    return false
end

function batchShoveAttack(weapon,zombieList)
    if not weapon or #zombieList==0 then return end
    local currentTime=tick()
    local remoteEvent=weapon:FindFirstChild("RemoteEvent") or weapon:FindFirstChild("Remote"); if not remoteEvent then return end
    local weaponName=weapon.Name:lower()
    for i,zombieData in ipairs(zombieList) do
        local hit=zombieData.hit; local zombieId=tostring(hit); stunCooldowns[zombieId]=currentTime
        task.spawn(function()
            pcall(function()
                if weaponName:find("axe") then remoteEvent:FireServer("BraceBlock"); remoteEvent:FireServer("StopBraceBlock") end
                local rs=game:GetService("ReplicatedStorage")
                if rs:FindFirstChild("Remotes") then
                    local remotes=rs.Remotes
                    if remotes:FindFirstChild("Stun") then remotes.Stun:FireServer(hit) end
                end
            end)
        end)
    end
end

function getPredictedPosition(zombie,currentPos,velocity)
    if not zombie or not currentPos then return currentPos end
    local predictionTime=(currentPing/1000)*lagCompensationMultiplier
    return currentPos+(velocity*predictionTime)
end

function attackWithWeapon(weapon,hit,hitPart,calc,normal)
    if not weapon then return end
    local remoteEvent=weapon:FindFirstChild("RemoteEvent") or weapon:FindFirstChild("Remote"); if not remoteEvent then return end
    pcall(function() game:GetService("ReplicatedStorage").Remotes.Gib:FireServer(hit,"Head",hitPart.CFrame.Position,normal,true) end)
    local success=false
    pcall(function()
        remoteEvent:FireServer("Swing","Thrust"); task.wait(0.02)
        remoteEvent:FireServer("HitZombie",hit,hitPart.CFrame.Position,true,calc*25,"Head",normal); success=true
    end)
    if not success then pcall(function() remoteEvent:FireServer("HitZombie",hit,hitPart.CFrame.Position,true,calc*25,"Head",normal) end) end
end

function detectEnemy(hitbox,hrp)
    if killAuraConnection then return end
    killAuraConnection=RunService.Heartbeat:Connect(function()
        if not killAuraToggled and not shoveAuraToggled then
            isDead=false; observerOnline=false; killAuraActive=true
            if killAuraConnection then killAuraConnection:Disconnect(); killAuraConnection=nil end
            return
        end
        if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
        if not hitbox or not hitbox.Parent then return end
        local currentTime=tick()
        if killAuraToggled then
            local elapsed=currentTime-cycleStartTime
            if elapsed>cycleDuration+pauseDuration then cycleStartTime=currentTime; killAuraActive=true
            elseif elapsed>cycleDuration then killAuraActive=false; return end
        end
        local success,parts=pcall(function() return workspace:GetPartsInPart(hitbox,params) end)
        if not success then return end
        local zombiesToShove={}; local zombiesToAttack={}
        local equippedWeapon=getEquippedWeapon()
        for i,part in pairs(parts) do
            if part.Parent and part.Parent.Name=="m_Zombie" then
                local Origin=part.Parent:FindFirstChild("Orig")
                if Origin and Origin.Value then
                    local hit=Origin.Value
                    local zombieComponent=hit:FindFirstChild("Zombie")
                    local head=hit:FindFirstChild("Head")
                    local zombieHRP=hit:FindFirstChild("HumanoidRootPart")
                    if head and zombieHRP and zombieComponent then
                        local velocity=zombieHRP.AssemblyLinearVelocity or Vector3.new(0,0,0)
                        local predictedPos=getPredictedPosition(hit,zombieHRP.Position,velocity)
                        local distance=(predictedPos-hrp.Position).Magnitude
                        if shoveAuraToggled and equippedWeapon and canWeaponShove(equippedWeapon) and distance<=shoveRadius then
                            local zombieId=tostring(hit)
                            if not stunCooldowns[zombieId] or currentTime-stunCooldowns[zombieId]>=shoveStunCooldown then
                                local raycastResult=workspace:Raycast(hrp.CFrame.Position,head.CFrame.Position-hrp.CFrame.Position,raycastParams)
                                if raycastResult then
                                    table.insert(zombiesToShove,{hit=hit,hitPart=head,zombie=zombieComponent,raycast=raycastResult,priority=zombieComponent.WalkSpeed>16 and 1 or 2,distance=distance})
                                end
                            end
                        end
                        if killAuraToggled and killAuraActive and distance<=killAuraRadius then
                            local zombieId=tostring(hit); local willBeShoved=false
                            if shoveAuraToggled and equippedWeapon and canWeaponShove(equippedWeapon) and distance<=shoveRadius then
                                if not stunCooldowns[zombieId] or currentTime-stunCooldowns[zombieId]>=shoveStunCooldown then willBeShoved=true end
                            end
                            if not willBeShoved then
                                local raycastResult=workspace:Raycast(hrp.CFrame.Position,head.CFrame.Position-hrp.CFrame.Position,raycastParams)
                                if raycastResult then
                                    local calc=(raycastResult.Position-hrp.CFrame.Position)
                                    if calc:Dot(calc)>1 then calc=calc.Unit end
                                    table.insert(zombiesToAttack,{hit=hit,part=part,zombie=zombieComponent,raycast=raycastResult,calc=calc,priority=zombieComponent.WalkSpeed>16 and 1 or 2,distance=distance})
                                end
                            end
                        end
                    end
                end
            end
        end
        if #zombiesToShove>0 and equippedWeapon and canWeaponShove(equippedWeapon) and toolEquip then
            table.sort(zombiesToShove,function(a,b) if a.priority~=b.priority then return a.priority<b.priority end; return a.distance<b.distance end)
            local shoveCount=math.min(#zombiesToShove,maxShovePerCycle)
            local batchList={}; for i=1,shoveCount do table.insert(batchList,zombiesToShove[i]) end
            batchShoveAttack(equippedWeapon,batchList); lastShoveTime=currentTime; return
        end
        if #zombiesToAttack>0 and equippedWeapon and toolEquip and killAuraActive then
            local adjustedKillDelay=adaptiveKillDelay*killDelayMultiplier
            if currentTime-lastAttackTime<adjustedKillDelay then return end
            table.sort(zombiesToAttack,function(a,b) if a.priority~=b.priority then return a.priority<b.priority end; return a.distance<b.distance end)
            local killCount=math.min(#zombiesToAttack,maxKillPerCycle)
            for i=1,killCount do
                local zombieData=zombiesToAttack[i]
                task.spawn(function()
                    if zombieData.zombie.WalkSpeed>16 then attackWithWeapon(equippedWeapon,zombieData.hit,zombieData.hit.Head,zombieData.calc,zombieData.raycast.Normal)
                    else if not zombieData.part.Parent:FindFirstChild("Barrel") then attackWithWeapon(equippedWeapon,zombieData.hit,zombieData.hit.Head,zombieData.calc,zombieData.raycast.Normal) end end
                end)
                if i<killCount then task.wait(adaptiveAttackDelay*killDelayMultiplier) end
            end
            lastAttackTime=currentTime
        end
    end)
end

function startAutoFace()
    if autoFaceConnection then return end
    autoFaceConnection=RunService.RenderStepped:Connect(function(deltaTime)
        if not (killAuraToggled or shoveAuraToggled or bayonetKillAuraToggled) or not autoFaceToggled then return end
        local hrp=LocalPlayer.Character:FindFirstChild("HumanoidRootPart"); if not hrp then return end
        local activeRadius=math.max((killAuraToggled and killAuraRadius or 0),(shoveAuraToggled and shoveRadius or 0),(bayonetKillAuraToggled and bayonetKillAuraRadius or 0))
        if activeRadius==0 then return end
        local nearestDist=math.huge; local nearestTarget=nil
        for _,agent in pairs(workspace.Zombies:GetChildren()) do
            local zombieHRP=agent:FindFirstChild("HumanoidRootPart")
            if zombieHRP then local dist=(zombieHRP.Position-hrp.Position).Magnitude; if dist<nearestDist and dist<=activeRadius then nearestDist=dist; nearestTarget=zombieHRP end end
        end
        for _,child in pairs(workspace.Camera:GetChildren()) do
            if child.Name=="m_Zombie" then
                local Origin=child:FindFirstChild("Orig")
                if Origin and Origin.Value then
                    local zombieHRP=Origin.Value:FindFirstChild("HumanoidRootPart")
                    if zombieHRP then local dist=(zombieHRP.Position-hrp.Position).Magnitude; if dist<nearestDist and dist<=activeRadius then nearestDist=dist; nearestTarget=zombieHRP end end
                end
            end
        end
        if nearestTarget then smoothLookAtWithVelocity(hrp,nearestTarget.Position,deltaTime) end
    end)
end

function stopAutoFace()
    if autoFaceConnection then autoFaceConnection:Disconnect(); autoFaceConnection=nil end
end

function setShoveRadius(newRadius)
    shoveRadius=newRadius
    if (killAuraToggled or shoveAuraToggled) and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        observerOnline=false
        if killAuraConnection then killAuraConnection:Disconnect(); killAuraConnection=nil end
        local existingHitbox=LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Hitbox")
        if existingHitbox then existingHitbox:Destroy() end
        task.wait(0.1); createHitBox()
    end
end

function setMaxShovePerCycle(newMax) maxShovePerCycle=newMax end
function setMaxKillPerCycle(newMax) maxKillPerCycle=newMax end

function createHitBox()
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return false end
    local torso=LocalPlayer.Character.HumanoidRootPart
    local existingHitbox=torso:FindFirstChild("Hitbox")
    local _hitboxSz,hitboxOffset
    if shoveAuraToggled and not killAuraToggled then
        _hitboxSz=Vector3.new(shoveRadius*2,6,shoveRadius*2); hitboxOffset=CFrame.new(0,0,-shoveRadius*0.6)
    elseif killAuraToggled and not shoveAuraToggled then
        _hitboxSz=Vector3.new(killAuraRadius*2,7,killAuraRadius*2); hitboxOffset=CFrame.new(0,0,-killAuraRadius*0.6)
    else
        local maxRadius=math.max(shoveRadius,killAuraRadius)
        _hitboxSz=Vector3.new(maxRadius*2,7,maxRadius*2); hitboxOffset=CFrame.new(0,0,-maxRadius*0.6)
    end
    if existingHitbox then
        existingHitbox.Size=_hitboxSz; existingHitbox.CFrame=torso.CFrame*hitboxOffset
        if not observerOnline then observerOnline=true; detectEnemy(existingHitbox,torso) end
        return true
    else
        local hitbox=Instance.new("Part"); hitbox.Name="Hitbox"; hitbox.Parent=torso
        hitbox.Anchored=false; hitbox.Massless=true; hitbox.CanCollide=false; hitbox.CanTouch=false
        hitbox.Transparency=1; hitbox.Size=_hitboxSz; hitbox.CFrame=torso.CFrame*hitboxOffset
        local weld=Instance.new("WeldConstraint"); weld.Parent=torso; weld.Part0=hitbox; weld.Part1=torso
        if not observerOnline then observerOnline=true; detectEnemy(hitbox,torso) end
        return true
    end
end

task.spawn(function()
    while true do task.wait(3); local currentTime=tick(); for zombieId,lastTime in pairs(stunCooldowns) do if currentTime-lastTime>5 then stunCooldowns[zombieId]=nil end end end
end)

-- Bayonet Kill Aura
bayonetKillAuraToggled=false; bayonetKillAuraConnection=nil; bayonetKillAuraRadius=13
lastBayonetAttack=0; bayonetAttackCooldown=0.05; maxBayonetPerCycle=5
local bayonetHitCooldowns={}

local function hasBayonetWeapon()
    if not LocalPlayer.Character then return nil end
    for _,tool in pairs(LocalPlayer.Character:GetChildren()) do
        if tool:IsA("Tool") then
            local hasBayonet=tool:FindFirstChild("Configuration") and tool.Configuration:GetAttribute("HasBayonet")
            if hasBayonet and (tool:FindFirstChild("RemoteEvent") or tool:FindFirstChild("Remote")) then return tool end
        end
    end
    return nil
end

local function findAgentFromZombie(mZombie)
    local Origin=mZombie:FindFirstChild("Orig"); if not Origin or not Origin.Value then return nil end
    local agent=Origin.Value
    if agent and agent.Parent==workspace.Zombies then return agent end
    return nil
end

local function bayonetAttack(weapon,agent,hitPosition,direction)
    if not weapon or not agent or not hitPosition then return end
    local remoteEvent=weapon:FindFirstChild("RemoteEvent") or weapon:FindFirstChild("Remote"); if not remoteEvent then return end
    pcall(function()
        remoteEvent:FireServer("ThrustBayonet")
        remoteEvent:FireServer("Bayonet_HitZombie",agent,hitPosition,true,"Head")
        local hitID=tick()
        agent:SetAttribute("WepHitID",hitID); agent:SetAttribute("WepHitDirection",direction*10); agent:SetAttribute("WepHitPos",hitPosition)
        task.delay(0.2,function()
            if agent:GetAttribute("WepHitID")==hitID then
                agent:SetAttribute("WepHitDirection",nil); agent:SetAttribute("WepHitPos",nil); agent:SetAttribute("WepHitID",nil)
            end
        end)
        local gibRemote=game:GetService("ReplicatedStorage").Remotes:FindFirstChild("Gib")
        if gibRemote then gibRemote:FireServer(agent,"Head",hitPosition,direction.Unit,true) end
    end)
end

local function createBayonetHitbox()
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return nil end
    local torso=LocalPlayer.Character.HumanoidRootPart
    local existingHitbox=torso:FindFirstChild("BayonetHitbox")
    if existingHitbox then
        existingHitbox.Size=Vector3.new(bayonetKillAuraRadius*2,7,bayonetKillAuraRadius*2)
        existingHitbox.CFrame=torso.CFrame*CFrame.new(0,0,-bayonetKillAuraRadius*0.6); return existingHitbox
    end
    local hitbox=Instance.new("Part"); hitbox.Name="BayonetHitbox"; hitbox.Parent=torso
    hitbox.Anchored=false; hitbox.Massless=true; hitbox.CanCollide=false; hitbox.CanTouch=false
    hitbox.Transparency=1; hitbox.Size=Vector3.new(bayonetKillAuraRadius*2,7,bayonetKillAuraRadius*2)
    hitbox.CFrame=torso.CFrame*CFrame.new(0,0,-bayonetKillAuraRadius*0.6)
    local weld=Instance.new("WeldConstraint"); weld.Parent=torso; weld.Part0=hitbox; weld.Part1=torso
    return hitbox
end

local function startBayonetKillAura()
    if bayonetKillAuraConnection then bayonetKillAuraConnection:Disconnect(); bayonetKillAuraConnection=nil end
    local bayonetHitbox=createBayonetHitbox(); if not bayonetHitbox then return end
    local bayonetParams=OverlapParams.new(); bayonetParams.FilterDescendantsInstances={LocalPlayer.Character}
    bayonetKillAuraConnection=RunService.Heartbeat:Connect(function()
        if not bayonetKillAuraToggled then
            if bayonetKillAuraConnection then bayonetKillAuraConnection:Disconnect(); bayonetKillAuraConnection=nil end
            if bayonetHitbox and bayonetHitbox.Parent then bayonetHitbox:Destroy() end; return
        end
        if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
        if not bayonetHitbox or not bayonetHitbox.Parent then bayonetHitbox=createBayonetHitbox(); if not bayonetHitbox then return end end
        local currentTime=tick()
        if currentTime-lastBayonetAttack<bayonetAttackCooldown then return end
        local weapon=hasBayonetWeapon(); if not weapon or not toolEquip then return end
        local hrp=LocalPlayer.Character.HumanoidRootPart; local zombiesToAttack={}
        local success,parts=pcall(function() return workspace:GetPartsInPart(bayonetHitbox,bayonetParams) end)
        if not success then return end
        for _,part in pairs(parts) do
            if part.Parent and part.Parent.Name=="m_Zombie" then
                local agent=findAgentFromZombie(part.Parent)
                if agent then
                    local zombie=agent:FindFirstChild("Zombie"); local head=agent:FindFirstChild("Head"); local zombieHRP=agent:FindFirstChild("HumanoidRootPart")
                    if zombie and head and zombieHRP then
                        local velocity=zombieHRP.AssemblyLinearVelocity or Vector3.new(0,0,0)
                        local predictedPos=zombieHRP.Position+velocity*0.13
                        local distance=(predictedPos-hrp.Position).Magnitude
                        if distance<=bayonetKillAuraRadius then
                            local zombieId=tostring(agent)
                            if not bayonetHitCooldowns[zombieId] or currentTime-bayonetHitCooldowns[zombieId]>=1.0 then
                                local bayonetRayParams=RaycastParams.new()
                                bayonetRayParams.FilterDescendantsInstances={LocalPlayer.Character}
                                bayonetRayParams.FilterType=Enum.RaycastFilterType.Exclude
                                local raycastResult=workspace:Raycast(hrp.Position,head.Position-hrp.Position,bayonetRayParams)
                                if raycastResult and raycastResult.Instance:IsDescendantOf(agent) then
                                    local direction=(head.Position-hrp.Position).Unit
                                    table.insert(zombiesToAttack,{agent=agent,head=head,distance=distance,priority=zombie.WalkSpeed>16 and 1 or 2,zombieId=zombieId,direction=direction,hitPosition=head.Position})
                                end
                            end
                        end
                    end
                end
            end
        end
        if #zombiesToAttack>0 then
            table.sort(zombiesToAttack,function(a,b) if a.priority~=b.priority then return a.priority<b.priority end; return a.distance<b.distance end)
            local target=zombiesToAttack[1]
            bayonetAttack(weapon,target.agent,target.hitPosition,target.direction)
            bayonetHitCooldowns[target.zombieId]=currentTime; lastBayonetAttack=currentTime
        end
    end)
end

local function toggleBayonetKillAura(enabled)
    bayonetKillAuraToggled=enabled
    if enabled then
        startBayonetKillAura()
        if autoFaceToggled then stopAutoFace(); startAutoFace() end
    else
        if bayonetKillAuraConnection then bayonetKillAuraConnection:Disconnect(); bayonetKillAuraConnection=nil end
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hitbox=LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BayonetHitbox")
            if hitbox then hitbox:Destroy() end
        end
        bayonetHitCooldowns={}
    end
end

-- Hitbox Expander
local hitboxEnabled=false
local zombieFolder=workspace:WaitForChild("Zombies")
local function addOuterHitbox(zombie)
    if not zombie or not zombie.Parent then return end
    local hrp=zombie:FindFirstChild("HumanoidRootPart")
    if hrp and not zombie:FindFirstChild("OuterHitbox") then
        pcall(function()
            local part=Instance.new("Part"); part.Name="OuterHitbox"
            part.Size=Vector3.new(hitboxSize,hitboxSize,hitboxSize); part.Transparency=1
            part.Anchored=false; part.CanCollide=false; part.Massless=true; part.CanTouch=true
            part.CFrame=hrp.CFrame; part.Parent=zombie
            local weld=Instance.new("WeldConstraint"); weld.Part0=hrp; weld.Part1=part; weld.Parent=part
        end)
    end
end
local function removeHitboxes(zombie)
    if not zombie then return end
    pcall(function()
        local outer=zombie:FindFirstChild("OuterHitbox"); local head=zombie:FindFirstChild("HeadHitbox")
        if outer then outer:Destroy() end; if head then head:Destroy() end
    end)
end
local function updateHitboxes(zombie)
    if not zombie then return end
    if hitboxEnabled then removeHitboxes(zombie); task.wait(0.05); addOuterHitbox(zombie)
    else removeHitboxes(zombie) end
end
local function toggleHitboxExpander(enabled)
    hitboxEnabled=enabled
    pcall(function()
        for _,zombie in pairs(zombieFolder:GetChildren()) do updateHitboxes(zombie) end
        for _,zombie in pairs(workspace.Camera:GetChildren()) do if zombie.Name=="m_Zombie" then updateHitboxes(zombie) end end
    end)
end
local function setHitboxSize(newSize)
    hitboxSize=newSize
    if hitboxEnabled then
        pcall(function()
            for _,zombie in pairs(zombieFolder:GetChildren()) do updateHitboxes(zombie) end
            for _,zombie in pairs(workspace.Camera:GetChildren()) do if zombie.Name=="m_Zombie" then updateHitboxes(zombie) end end
        end)
    end
end
zombieFolder.ChildAdded:Connect(function(zombie) if hitboxEnabled then task.spawn(function() task.wait(0.2); updateHitboxes(zombie) end) end end)

-- Fullbright
local Light=game:GetService("Lighting"); local fullbrightEnabled=false; local fullbrightConnection=nil
local originalLighting={Ambient=Light.Ambient,ColorShift_Bottom=Light.ColorShift_Bottom,ColorShift_Top=Light.ColorShift_Top,OutdoorAmbient=Light.OutdoorAmbient,Brightness=Light.Brightness}
local function doFullbright() if not fullbrightEnabled then return end; Light.Ambient=Color3.new(1,1,1); Light.ColorShift_Bottom=Color3.new(1,1,1); Light.ColorShift_Top=Color3.new(1,1,1); Light.OutdoorAmbient=Color3.new(1,1,1); Light.Brightness=2 end
local function restoreLighting() Light.Ambient=originalLighting.Ambient; Light.ColorShift_Bottom=originalLighting.ColorShift_Bottom; Light.ColorShift_Top=originalLighting.ColorShift_Top; Light.OutdoorAmbient=originalLighting.OutdoorAmbient; Light.Brightness=originalLighting.Brightness end
local function toggleFullbright(enabled)
    fullbrightEnabled=enabled
    if fullbrightConnection then fullbrightConnection:Disconnect(); fullbrightConnection=nil end
    if enabled then doFullbright(); fullbrightConnection=Light.LightingChanged:Connect(doFullbright)
    else restoreLighting() end
end

-- Killbrick
local killbrickEnabled=true; local killbrickConnection=nil
local function toggleKillbrick(enabled)
    killbrickEnabled=enabled
    if killbrickConnection then killbrickConnection:Disconnect(); killbrickConnection=nil end
    if not enabled then
        killbrickConnection=RunService.Heartbeat:Connect(function()
            if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
            local parts=workspace:GetPartBoundsInRadius(LocalPlayer.Character.HumanoidRootPart.Position,10)
            for _,part in ipairs(parts) do part.CanTouch=false end
        end)
    end
end

-- WalkSpeed
local connection=nil; walkSpeedToggled=false; walkSpeedValue=16
local function changeWalkSpeed(newValue,wsToggled)
    local workPlayer=LocalPlayer.Character
    if workPlayer and workPlayer:FindFirstChild("Humanoid") then
        workPlayer.Humanoid.WalkSpeed=newValue
        if wsToggled then
            if connection then connection:Disconnect() end
            connection=workPlayer.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function() workPlayer.Humanoid.WalkSpeed=newValue end)
        else if connection then connection:Disconnect(); connection=nil end end
    end
end

-- Auto Repair
local autoRepairToggled=false; local autoEquipHammerToggled=false; local autoRepairConnection=nil
local lastRepairTime=0; local isRepairing=false
local function equipHammer()
    local hammer=LocalPlayer.Backpack:FindFirstChild("Hammer"); if not hammer then return false end
    pcall(function() LocalPlayer.Character.Humanoid:EquipTool(hammer) end); task.wait(0.2)
    return LocalPlayer.Character:FindFirstChild("Hammer")~=nil
end
local function performRepair()
    if isRepairing or not autoRepairToggled or not LocalPlayer.Character then return false end
    local currentTime=tick(); if currentTime-lastRepairTime<0.1 then return false end
    local hammerTool=LocalPlayer.Character:FindFirstChild("Hammer")
    if not hammerTool and autoEquipHammerToggled then if not equipHammer() then return false end; hammerTool=LocalPlayer.Character:FindFirstChild("Hammer") end
    if not hammerTool then return false end
    isRepairing=true
    local remoteEvent=hammerTool:FindFirstChild("RemoteEvent"); if not remoteEvent then isRepairing=false; return false end
    local repairParams=RaycastParams.new(); repairParams.IgnoreWater=true; repairParams.FilterDescendantsInstances={LocalPlayer.Character}; repairParams.FilterType=Enum.RaycastFilterType.Exclude
    local head=LocalPlayer.Character:FindFirstChild("Head"); if not head then isRepairing=false; return false end
    local repaired=false
    pcall(function()
        local direction=workspace.CurrentCamera.CFrame.LookVector
        local raycast=workspace:Raycast(head.Position,direction*8,repairParams)
        if raycast and raycast.Instance then
            local buildingHealth=raycast.Instance.Parent:FindFirstChild("BuildingHealth") or raycast.Instance.Parent.Parent:FindFirstChild("BuildingHealth")
            local constructHealth=raycast.Instance:FindFirstChild("ConstructHealth")
            if buildingHealth or constructHealth then remoteEvent:FireServer("Repair",buildingHealth or constructHealth); lastRepairTime=currentTime; repaired=true end
        end
    end)
    isRepairing=false; return repaired
end
local function autoRepair(Value)
    autoRepairToggled=Value
    if autoRepairConnection then autoRepairConnection:Disconnect(); autoRepairConnection=nil end
    if autoRepairToggled then
        isRepairing=false
        autoRepairConnection=RunService.Heartbeat:Connect(function()
            if not autoRepairToggled then if autoRepairConnection then autoRepairConnection:Disconnect(); autoRepairConnection=nil end; return end
            if tick()-lastRepairTime>=0.1 then task.spawn(function() pcall(performRepair) end) end
        end)
    else isRepairing=false end
end

-- Auto Play
autoplay=false; local autoPlayConnection=nil; local lastUpdateAccuracy=0; local updateInterval=0.5
local autoStartConnection=nil; local colorCheckConnection=nil; local equippedConnections={}
local function autoPerfectPlay()
    if not autoplay or not LocalPlayer.Character then return end
    pcall(function()
        for _,tool in pairs(LocalPlayer.Character:GetChildren()) do
            if tool:IsA("Tool") and (tool.Name:find("Fife") or tool.Name:find("Drum") or tool.Name:find("Bagpipe")) then
                local remoteEvent=tool:FindFirstChild("RemoteEvent")
                if remoteEvent then remoteEvent:FireServer("UpdateAccuracy",100); break end
            end
        end
    end)
end
local function startAutoPlay()
    if autoPlayConnection then autoPlayConnection:Disconnect() end
    if autoStartConnection then task.cancel(autoStartConnection) end
    lastUpdateAccuracy=0
    autoStartConnection=task.spawn(function()
        while autoplay do
            pcall(function()
                if not LocalPlayer.Character then return end
                for _,tool in pairs(LocalPlayer.Character:GetChildren()) do
                    if tool:IsA("Tool") and (tool.Name:find("Fife") or tool.Name:find("Drum") or tool.Name:find("Bagpipe")) then
                        local remoteEvent=tool:FindFirstChild("RemoteEvent")
                        if remoteEvent then
                            local songSource=tool:FindFirstChild("Model") and tool.Model:FindFirstChild("Handle") and tool.Model.Handle:FindFirstChild("SoundSource")
                            if songSource and not songSource.IsPlaying then remoteEvent:FireServer("Play","La Marseillaise"); task.wait(0.5) end
                        end
                    end
                end
            end)
            task.wait(2)
        end
    end)
    autoPlayConnection=RunService.Heartbeat:Connect(function(deltaTime)
        if not autoplay then if autoPlayConnection then autoPlayConnection:Disconnect(); autoPlayConnection=nil end; return end
        lastUpdateAccuracy=lastUpdateAccuracy-deltaTime
        if lastUpdateAccuracy<=0 then lastUpdateAccuracy=updateInterval; autoPerfectPlay() end
    end)
end

-- Fly
local FLYING=false; local NO_FALL_DAMAGE=false; local FLY_SPEED=35
local flyControl2={forward=0,backward=0,left=0,right=0,up=0,down=0}; local flyMobileMovement2={x=0,y=0}
local QEfly2=true; local iyflyspeed2=1; local flyKeyDown2,flyKeyUp2
local IsOnMobile2=table.find({Enum.Platform.Android,Enum.Platform.IOS},UIS:GetPlatform()) or (UIS.TouchEnabled and not UIS.KeyboardEnabled)

local function sFLY()
    local char=LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid=char:FindFirstChildOfClass("Humanoid"); if not humanoid then repeat task.wait() until char:FindFirstChildOfClass("Humanoid"); humanoid=char:FindFirstChildOfClass("Humanoid") end
    if flyKeyDown2 or flyKeyUp2 then flyKeyDown2:Disconnect(); flyKeyUp2:Disconnect() end
    local T=getRoot(char); local CONTROL={F=0,B=0,L=0,R=0,Q=0,E=0}; local lCONTROL={F=0,B=0,L=0,R=0,Q=0,E=0}; local SPEED=0
    local function FLY()
        FLYING=true
        local BG=Instance.new("BodyGyro"); local BV=Instance.new("BodyVelocity")
        BG.P=9e4; BG.Parent=T; BV.Parent=T; BG.MaxTorque=Vector3.new(9e9,9e9,9e9); BG.CFrame=T.CFrame; BV.Velocity=Vector3.new(0,0,0); BV.MaxForce=Vector3.new(9e9,9e9,9e9)
        task.spawn(function()
            repeat task.wait()
                local camera=workspace.CurrentCamera; if not FLY then humanoid.PlatformStand=true end
                if CONTROL.L+CONTROL.R~=0 or CONTROL.F+CONTROL.B~=0 or CONTROL.Q+CONTROL.E~=0 then SPEED=50
                elseif SPEED~=0 then SPEED=0 end
                if (CONTROL.L+CONTROL.R)~=0 or (CONTROL.F+CONTROL.B)~=0 or (CONTROL.Q+CONTROL.E)~=0 then
                    BV.Velocity=((camera.CFrame.LookVector*(CONTROL.F+CONTROL.B))+((camera.CFrame*CFrame.new(CONTROL.L+CONTROL.R,(CONTROL.F+CONTROL.B+CONTROL.Q+CONTROL.E)*0.2,0).p)-camera.CFrame.p))*SPEED
                    lCONTROL={F=CONTROL.F,B=CONTROL.B,L=CONTROL.L,R=CONTROL.R}
                elseif (CONTROL.L+CONTROL.R)==0 and (CONTROL.F+CONTROL.B)==0 and (CONTROL.Q+CONTROL.E)==0 and SPEED~=0 then
                    BV.Velocity=((camera.CFrame.LookVector*(lCONTROL.F+lCONTROL.B))+((camera.CFrame*CFrame.new(lCONTROL.L+lCONTROL.R,(lCONTROL.F+lCONTROL.B+CONTROL.Q+CONTROL.E)*0.2,0).p)-camera.CFrame.p))*SPEED
                else BV.Velocity=Vector3.new(0,0,0) end
                BG.CFrame=camera.CFrame
            until not FLYING
            CONTROL={F=0,B=0,L=0,R=0,Q=0,E=0}; lCONTROL={F=0,B=0,L=0,R=0,Q=0,E=0}; SPEED=0
            BG:Destroy(); BV:Destroy(); if humanoid then humanoid.PlatformStand=false end
        end)
    end
    flyKeyDown2=UIS.InputBegan:Connect(function(input,processed)
        if processed then return end
        if input.KeyCode==Enum.KeyCode.W then CONTROL.F=iyflyspeed2
        elseif input.KeyCode==Enum.KeyCode.S then CONTROL.B=-iyflyspeed2
        elseif input.KeyCode==Enum.KeyCode.A then CONTROL.L=-iyflyspeed2
        elseif input.KeyCode==Enum.KeyCode.D then CONTROL.R=iyflyspeed2
        elseif input.KeyCode==Enum.KeyCode.E and QEfly2 then CONTROL.Q=iyflyspeed2*2
        elseif input.KeyCode==Enum.KeyCode.Q and QEfly2 then CONTROL.E=-iyflyspeed2*2 end
    end)
    flyKeyUp2=UIS.InputEnded:Connect(function(input,processed)
        if input.KeyCode==Enum.KeyCode.W then CONTROL.F=0
        elseif input.KeyCode==Enum.KeyCode.S then CONTROL.B=0
        elseif input.KeyCode==Enum.KeyCode.A then CONTROL.L=0
        elseif input.KeyCode==Enum.KeyCode.D then CONTROL.R=0
        elseif input.KeyCode==Enum.KeyCode.E then CONTROL.Q=0
        elseif input.KeyCode==Enum.KeyCode.Q then CONTROL.E=0 end
    end)
    FLY()
end

local function NOFLY()
    FLYING=false
    if flyKeyDown2 or flyKeyUp2 then flyKeyDown2:Disconnect(); flyKeyUp2:Disconnect() end
    if LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        local hum=LocalPlayer.Character:FindFirstChildOfClass("Humanoid"); hum.PlatformStand=false
        pcall(function() hum:SetStateEnabled(Enum.HumanoidStateType.Climbing,true); hum:ChangeState(Enum.HumanoidStateType.Freefall); task.wait(0.1); hum:ChangeState(Enum.HumanoidStateType.Landing) end)
    end
end

-- Noclip
local NOCLIPPING2=false; local noclipConnection2=nil; local antiPullbackConnection2=nil
local lastSafePosition2=nil; local stuckCounter2=0; local positionHistory2={}
local function startNoclip()
    if NOCLIPPING2 then return end; NOCLIPPING2=true
    local char=LocalPlayer.Character; local hrp=char and char:FindFirstChild("HumanoidRootPart"); local hum=char and char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end
    pcall(function() hrp:SetNetworkOwner(LocalPlayer) end)
    positionHistory2={}; lastSafePosition2=hrp.CFrame
    noclipConnection2=RunService.Stepped:Connect(function()
        if not NOCLIPPING2 then return end
        local char=LocalPlayer.Character; if not char then return end
        for _,part in pairs(char:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide=false end end
        local hrp=char:FindFirstChild("HumanoidRootPart"); local hum=char:FindFirstChildOfClass("Humanoid")
        if hrp then hrp.AssemblyLinearVelocity=Vector3.new(0,0,0); hrp.AssemblyAngularVelocity=Vector3.new(0,0,0) end
        if hum then hum:ChangeState(Enum.HumanoidStateType.NoPhysics) end
    end)
end
local function stopNoclip()
    if not NOCLIPPING2 then return end; NOCLIPPING2=false
    if noclipConnection2 then noclipConnection2:Disconnect(); noclipConnection2=nil end
    local char=LocalPlayer.Character; if not char then return end
    for _,part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") and part:IsDescendantOf(char) then
            if part.Name=="Head" or part.Name=="Torso" or part.Name=="HumanoidRootPart" then part.CanCollide=true end
        end
    end
    local hrp=char:FindFirstChild("HumanoidRootPart")
    if hrp then pcall(function() hrp:SetNetworkOwner(LocalPlayer) end) end
    task.wait(0.15)
    local hum=char:FindFirstChildOfClass("Humanoid")
    if hum then hum.PlatformStand=false; hum:ChangeState(Enum.HumanoidStateType.Running) end
end

-- Silent Aim
local silentAimEnabled=false; local silentAimMode="Auto"
local function findSilentAimTarget()
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return nil,nil,nil end
    local hrp=LocalPlayer.Character.HumanoidRootPart; local head=LocalPlayer.Character:FindFirstChild("Head"); if not head then return nil,nil,nil end
    local candidates={}
    for _,zombie in pairs(workspace.Zombies:GetChildren()) do
        local zombieHRP=zombie:FindFirstChild("HumanoidRootPart"); local zombieHead=zombie:FindFirstChild("Head"); local hasBarrel=zombie:FindFirstChild("Barrel")~=nil
        if zombieHRP and zombieHead and hasBarrel then
            local distance=(zombieHRP.Position-hrp.Position).Magnitude
            if distance<autoFireRange then table.insert(candidates,{zombie=zombie,head=zombieHead,distance=distance,targetType="Barrel"}) end
        end
    end
    for _,child in pairs(workspace.Camera:GetChildren()) do
        if child.Name=="m_Zombie" then
            local Origin=child:FindFirstChild("Orig")
            if Origin and Origin.Value then
                local zombie=Origin.Value; local zombieHRP=zombie:FindFirstChild("HumanoidRootPart"); local zombieHead=zombie:FindFirstChild("Head"); local hasBarrel=child:FindFirstChild("Barrel")~=nil
                if zombieHRP and zombieHead and hasBarrel then
                    local distance=(zombieHRP.Position-hrp.Position).Magnitude
                    if distance<autoFireRange then table.insert(candidates,{zombie=zombie,head=zombieHead,distance=distance,targetType="Barrel"}) end
                end
            end
            local lantern=child:FindFirstChild("Whale Oil Lantern")
            if lantern then
                local Origin=child:FindFirstChild("Orig")
                if Origin and Origin.Value then
                    local zombie=Origin.Value; local zombieHRP=zombie:FindFirstChild("HumanoidRootPart"); local zombieHead=zombie:FindFirstChild("Head")
                    if zombieHRP and zombieHead then
                        local distance=(zombieHRP.Position-hrp.Position).Magnitude
                        if distance<autoFireRange then table.insert(candidates,{zombie=zombie,head=zombieHead,distance=distance,targetType="Igniter"}) end
                    end
                end
            end
        end
    end
    local boss=findHeadlessBoss()
    if boss and boss.Parent then
        local torso=boss:FindFirstChild("Torso")
        if torso then local distance=(torso.Position-hrp.Position).Magnitude; if distance<=autoFireHeadlessRange then table.insert(candidates,{zombie=boss,head=torso,distance=distance,targetType="Headless"}) end end
    end
    local filtered={}
    for _,c in ipairs(candidates) do
        if silentAimMode=="Auto" then table.insert(filtered,c)
        elseif silentAimMode=="Barrel/Igniter" and (c.targetType=="Barrel" or c.targetType=="Igniter") then table.insert(filtered,c)
        elseif silentAimMode=="Headless" and c.targetType=="Headless" then table.insert(filtered,c) end
    end
    table.sort(filtered,function(a,b) return a.distance<b.distance end)
    for _,candidate in ipairs(filtered) do
        if wallbangEnabled or isTargetVisible(head.Position,candidate.head.Position,candidate.zombie) then
            return candidate.zombie,candidate.head,candidate.targetType
        end
    end
    return nil,nil,nil
end

_G.silentAimEnabled=false; _G.silentShootEnabled=false
_G._zentra_findSilentAimTarget=findSilentAimTarget
_G._zentra_getPredictedHeadless=getPredictedHeadlessPosition
_G.toggleSilentAim=function(enabled) silentAimEnabled=enabled; _G.silentAimEnabled=enabled end
_G.setSilentAimMode=function(mode) silentAimMode=mode end

-- Head Lock
local FlintLockSuccess,FlintLock=pcall(require,game:GetService("ReplicatedStorage").Modules.Weapons:FindFirstChild("Flintlock"))
local originBayonet,v_u_1
if FlintLockSuccess then
    originBayonet=FlintLock.BayonetHitCheck; v_u_1={}
    function v_u_1.BayonetHitCheck(p115,p116,p117,p118,p119)
        local v120=workspace:Raycast(p116,p117,p118)
        if v120 then
            if v120.Instance.Parent.Name=="m_Zombie" then
                local v121=p118.FilterDescendantsInstances; local v122=v120.Instance
                table.insert(v121,v122); p118.FilterDescendantsInstances=v121
                local v123=v120.Instance.Parent:FindFirstChild("Orig")
                if v123 then
                    local Head=nil
                    for i,part in pairs(v120.Instance.Parent:GetChildren()) do
                        if part.Name=="Head" and (part.ClassName=="Part" or part.ClassName=="MeshPart") then Head=part; break end
                    end
                    if Head then
                        p115.remoteEvent:FireServer("Bayonet_HitZombie",v123.Value,Head.CFrame.Position,true,"Head")
                        local v_u_124=v123.Value; local v_u_125=tick()
                        v_u_124:SetAttribute("WepHitID",tick()); v_u_124:SetAttribute("WepHitDirection",p117*10); v_u_124:SetAttribute("WepHitPos",v120.Position)
                        task.delay(0.2,function()
                            if v_u_124:GetAttribute("WepHitID")==v_u_125 then
                                v_u_124:SetAttribute("WepHitDirection",nil); v_u_124:SetAttribute("WepHitPos",nil); v_u_124:SetAttribute("WepHitID",nil)
                            end
                        end)
                    end
                end
                return 1
            end
        end
        return 0
    end
end
function changeBayonet(value)
    if FlintLockSuccess then FlintLock.BayonetHitCheck=value and v_u_1.BayonetHitCheck or originBayonet end
end

local MeleeBaseSuccess,MeleeBase=pcall(require,game:GetService("ReplicatedStorage").Modules.Weapons:FindFirstChild("MeleeBase"))
local originMelee,u1
if MeleeBaseSuccess then
    originMelee=MeleeBase.MeleeHitCheck; u1={}
    function u1.MeleeHitCheck(p100,p101,p102,p103,p104,p105)
        local v106=workspace:Raycast(p101,p102,p103)
        if v106 then
            if v106.Instance.Parent.Name=="m_Zombie" then
                local v107=p103.FilterDescendantsInstances; local v108=v106.Instance
                table.insert(v107,v108); p103.FilterDescendantsInstances=v107
                local v109=v106.Instance.Parent:FindFirstChild("Orig")
                if v109 then
                    if not p104[v109] or p104[v109]<(p100.Stats.MaxHits or 3) then
                        if not p105 then
                            local Head=nil
                            for i,part in pairs(v106.Instance.Parent:GetChildren()) do
                                if part.Name=="Head" and (part.ClassName=="Part" or part.ClassName=="MeshPart") then Head=part; break end
                            end
                            if Head then
                                local u112=v109.Value; local v113=Head.CFrame.Position-p101
                                if v113:Dot(v113)>1 then v113=v113.Unit end
                                local v114=v113*25
                                p100.remoteEvent:FireServer("HitZombie",u112,Head.CFrame.Position,true,v114,"Head",v106.Normal)
                            end
                        end
                        if p104[v109] then p104[v109]=p104[v109]+1 else table.insert(p104,v109); p104[v109]=1 end
                    end
                end
                return 1
            end
        end
        return 0
    end
end
function changeMelee(value)
    if MeleeBaseSuccess then MeleeBase.MeleeHitCheck=value and u1.MeleeHitCheck or originMelee end
end

-- onLights
function onLights()
    local ligthPost=workspace:FindFirstChild("Saint Petersburg"); if not ligthPost then return end
    local modes=ligthPost:FindFirstChild("Modes"); if not modes then return end
    local holdout=modes:FindFirstChild("Holdout"); if not holdout then return end
    local lampPosts=holdout:FindFirstChild("LampPosts"); if not lampPosts then return end
    for _,part in pairs(lampPosts:GetChildren()) do
        local metal=part:FindFirstChild("Metal")
        if metal and metal:FindFirstChild("Light") then metal.Light.PointLight.Enabled=true; metal.Light.Visible=true end
    end
end

LocalPlayer.CharacterAdded:Connect(function(character)
    task.wait(1); stunCooldowns={}; lastShoveTime=0; lastAttackTime=0
    if killAuraToggled or shoveAuraToggled then
        observerOnline=false; if killAuraConnection then killAuraConnection:Disconnect(); killAuraConnection=nil end
        task.wait(0.1); createHitBox()
    end
    if bayonetKillAuraToggled then toggleBayonetKillAura(false); task.wait(0.2); toggleBayonetKillAura(true) end
    raycastParams.FilterDescendantsInstances={character}; params.FilterDescendantsInstances={character}
    if not killbrickEnabled then toggleKillbrick(false) end
end)

-- Fly PreSimulation
RunService.PreSimulation:Connect(function(dt)
    local char=LocalPlayer.Character; local hrp=char and char:FindFirstChild("HumanoidRootPart"); local hum=char and char:FindFirstChildOfClass("Humanoid")
    if FLYING and hrp and hum then
        hum:ChangeState(Enum.HumanoidStateType.NoPhysics)
        hrp.Velocity=Vector3.new(0,0.01,0); hrp.AssemblyLinearVelocity=Vector3.new(0,0.01,0); hrp.AssemblyAngularVelocity=Vector3.new(0,0,0)
        pcall(function() if hrp.ReceiveAge>0.08 then hrp:SetNetworkOwner(LocalPlayer) end end)
    end
end)

-- No Fall Damage loop
task.spawn(function()
    while true do task.wait(1); if NO_FALL_DAMAGE then
        local char=LocalPlayer.Character
        if char then local health=char:FindFirstChild("Health"); if health then local fsd=health:FindFirstChild("ForceSelfDamage"); if fsd then pcall(function() fsd:FireServer(0) end) end end end
    end end
end)

end) -- end pcall

if not success then warn("Feature load error: "..tostring(errorMsg)) end

-- ===================== BUILD GUI TABS =====================

local o = 0
local function nextOrder() o=o+1; return o end

-- ========== COMBAT TAB ==========
local cf = TabFrames["Combat"]
makeSection(cf, "Combat Functions", nextOrder())
makeToggle(cf, "Silent Shoot", false, function(v) _G.toggleSilentAim(v) end, nextOrder())
makeDropdown(cf, "Silent Shoot Target", {"Auto (Priority)","Barrel/Igniter Only","Headless Only"}, "Auto (Priority)", function(v)
    local m={["Auto (Priority)"]="Auto",["Barrel/Igniter Only"]="Barrel/Igniter",["Headless Only"]="Headless"}
    _G.setSilentAimMode(m[v] or "Auto")
end, nextOrder())
makeToggle(cf, "Kill Aura", false, function(v)
    killAuraToggled=v
    if v then task.wait(0.1); createHitBox(); if autoFaceToggled then startAutoFace() end
    else
        if not shoveAuraToggled then
            if killAuraConnection then killAuraConnection:Disconnect(); killAuraConnection=nil end
            observerOnline=false
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local h=LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Hitbox"); if h then h:Destroy() end
            end
        end
        if not shoveAuraToggled and autoFaceToggled then stopAutoFace() end
    end
end, nextOrder())
makeToggle(cf, "Shove Aura", false, function(v)
    shoveAuraToggled=v
    if v then task.wait(0.1); createHitBox(); if autoFaceToggled then startAutoFace() end
    else
        if not killAuraToggled then
            if killAuraConnection then killAuraConnection:Disconnect(); killAuraConnection=nil end
            observerOnline=false
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local h=LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Hitbox"); if h then h:Destroy() end
            end
        end
        if not killAuraToggled and autoFaceToggled then stopAutoFace() end
    end
end, nextOrder())
makeToggle(cf, "Bayonet Kill Aura", false, function(v) toggleBayonetKillAura(v) end, nextOrder())
makeToggle(cf, "Auto Face Zombies", false, function(v)
    autoFaceToggled=v
    if v and (killAuraToggled or shoveAuraToggled or bayonetKillAuraToggled) then startAutoFace() else stopAutoFace() end
end, nextOrder())
makeToggle(cf, "Head Lock (Melee+Bayonet)", false, function(v) changeBayonet(v); changeMelee(v) end, nextOrder())
makeSlider(cf, "Shove Radius", 1, 15, 8, function(v) setShoveRadius(v) end, nextOrder())
makeSlider(cf, "Max Shove/Cycle", 1, 50, 30, function(v) setMaxShovePerCycle(v) end, nextOrder())
makeSlider(cf, "Max Kill/Cycle", 1, 20, 1, function(v) setMaxKillPerCycle(v) end, nextOrder())
makeSlider(cf, "Bayonet Kill Radius", 5, 25, 13, function(v) bayonetKillAuraRadius=v; if bayonetKillAuraToggled then toggleBayonetKillAura(false); task.wait(0.1); toggleBayonetKillAura(true) end end, nextOrder())
makeSlider(cf, "KillAura Speed Mult", 1, 20, 10, function(v) killDelayMultiplier=v/10 end, nextOrder())
makeToggle(cf, "Zombie Hitbox Expander", false, function(v) toggleHitboxExpander(v) end, nextOrder())
makeSlider(cf, "Hitbox Size", 1, 30, 10, function(v) setHitboxSize(v) end, nextOrder())

-- ========== AUTO TAB ==========
o=0
local af2 = TabFrames["Auto"]
makeSection(af2, "Auto Functions", nextOrder())
makeToggle(af2, "Auto Fire", false, function(v) toggleAutoFire(v) end, nextOrder())
makeSlider(af2, "Auto Fire Range", 10, 100, 50, function(v) autoFireRange=v end, nextOrder())
makeToggle(af2, "Wallbang Mode", false, function(v) toggleWallbang(v) end, nextOrder())
makeToggle(af2, "Auto Reload", false, function(v) _G.AutoReloadV2.Toggle(v) end, nextOrder())
makeDropdown(af2, "Reload Mode", {"Fast","Animation","Background"}, "Animation", function(v)
    local m={["Fast"]=1,["Animation"]=2,["Background"]=3}
    _G.AutoReloadV2.SetMode(m[v] or 2)
end, nextOrder())
makeToggle(af2, "Auto Repair", false, function(v) autoRepair(v) end, nextOrder())
makeToggle(af2, "Auto Equip Hammer", false, function(v) autoEquipHammerToggled=v end, nextOrder())
makeToggle(af2, "Auto Play (Music)", false, function(v)
    autoplay=v
    if v then startAutoPlay()
    else
        if autoPlayConnection then autoPlayConnection:Disconnect(); autoPlayConnection=nil end
        if autoStartConnection then task.cancel(autoStartConnection); autoStartConnection=nil end
        lastUpdateAccuracy=0
    end
end, nextOrder())

-- ========== ESP TAB ==========
o=0
local ef = TabFrames["ESP"]
makeSection(ef, "Zombie ESP", nextOrder())
makeToggle(ef, "ESP Runner (Fast)", false, function(v) espRToggled=v end, nextOrder())
makeToggle(ef, "ESP Bomber", false, function(v) espBToggled=v end, nextOrder())
makeToggle(ef, "ESP Igniter", false, function(v) espIToggled=v end, nextOrder())
makeToggle(ef, "ESP Cuirassier", false, function(v) espCuToggled=v end, nextOrder())
makeToggle(ef, "ESP Zapper", false, function(v) espZToggled=v end, nextOrder())
makeSection(ef, "Boss & Player ESP", nextOrder())
makeToggle(ef, "ESP Boss (Headless)", false, function(v) espBossToggled=v; updateBossESP() end, nextOrder())
makeToggle(ef, "Medic Player ESP", false, function(v) espMedicToggled=v; if v or espInfectionToggled then checkPlayersLife() end end, nextOrder())
makeToggle(ef, "Infection ESP", false, function(v) espInfectionToggled=v; if v or espMedicToggled then checkPlayersLife() end end, nextOrder())

-- ========== PLAYER TAB ==========
o=0
local pf = TabFrames["Player"]
makeSection(pf, "Movement", nextOrder())
makeToggle(pf, "Fly", false, function(v)
    FLYING=v
    if v then sFLY() else NOFLY() end
end, nextOrder())
makeToggle(pf, "Noclip", false, function(v) if v then startNoclip() else stopNoclip() end end, nextOrder())
makeToggle(pf, "No Fall Damage", false, function(v) NO_FALL_DAMAGE=v end, nextOrder())
makeSlider(pf, "Fly Speed", 10, 100, 35, function(v) FLY_SPEED=v; iyflyspeed2=v/50 end, nextOrder())
makeSection(pf, "WalkSpeed", nextOrder())
makeToggle(pf, "WalkSpeed Override", false, function(v) walkSpeedToggled=v; changeWalkSpeed(walkSpeedValue,walkSpeedToggled) end, nextOrder())
makeSlider(pf, "Walk Speed Value", 4, 100, 16, function(v) walkSpeedValue=v; changeWalkSpeed(v,walkSpeedToggled) end, nextOrder())
makeSection(pf, "Protection", nextOrder())
makeToggle(pf, "Killbrick Protection", false, function(v) toggleKillbrick(not v) end, nextOrder())

-- ========== VISUAL TAB ==========
o=0
local vf = TabFrames["Visual"]
makeSection(vf, "Lighting", nextOrder())
makeToggle(vf, "Fullbright", false, function(v) toggleFullbright(v) end, nextOrder())

-- ========== EVENT TAB ==========
o=0
local evf = TabFrames["Event"]
makeSection(evf, "Headless Horseman", nextOrder())
makeToggle(evf, "Auto Fire Headless", false, function(v) toggleAutoFireHeadless(v) end, nextOrder())
makeSlider(evf, "Headless Fire Range", 50, 200, 100, function(v) autoFireHeadlessRange=v end, nextOrder())
makeToggle(evf, "Auto Prediction", true, function(v) autoPredictionEnabled=v; if not v then currentPrediction=basePrediction end end, nextOrder())
makeSlider(evf, "Base Prediction (x100)", 5, 50, 15, function(v) basePrediction=v/100; if not autoPredictionEnabled then currentPrediction=v/100 end end, nextOrder())

-- ========== MISC TAB ==========
o=0
local mf = TabFrames["Misc"]
makeSection(mf, "Utilities", nextOrder())
makeButton(mf, "Lights On (Saint Petersburg)", function() pcall(onLights) end, nextOrder())
makeButton(mf, "Load Old Source", function()
    local ok,err=pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/cjbbth1-crypto/Chaos-Hub-GB/refs/heads/main/Chaos%20Hub"))() end)
    if not ok then warn("Load failed: "..tostring(err)) end
end, nextOrder())
makeButton(mf, "Load Animation Fun", function()
    local ok,err=pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/cjbbth1-crypto/Animation-fun/refs/heads/main/Animation%20fun"))() end)
    if not ok then warn("Load failed: "..tostring(err)) end
end, nextOrder())

-- ===================== TOGGLE BUTTON =====================

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 55, 0, 55)
ToggleBtn.Position = UDim2.new(1, -70, 0, 15)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(80, 120, 220)
ToggleBtn.BackgroundTransparency = 0.1
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Text = "Z"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 26
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.ZIndex = 10
ToggleBtn.Parent = ScreenGui
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
local TBS = Instance.new("UIStroke"); TBS.Color = Color3.fromRGB(255,255,255); TBS.Thickness = 2; TBS.Transparency = 0.6; TBS.Parent = ToggleBtn

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
    if MainFrame.Visible then
        MainFrame.Size = UDim2.new(0, 650, 0, 450)
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 700, 0, 500)}):Play()
    end
end)

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.RightShift then MainFrame.Visible = not MainFrame.Visible end
end)

-- ===================== SHOW GUI =====================

selectTab("Combat")
task.wait(0.3)
MainFrame.Visible = true
TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 700, 0, 500)}):Play()

print("[ZentraHub + ReyHub GUI] Loaded! Press RightShift to toggle.")