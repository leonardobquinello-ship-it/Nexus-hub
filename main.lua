--=============================================================
-- NEXUS HUB - main.lua
-- Key + Load + Aimbot + ESP (Skeleton + Dist) + TP + Player + Armas + Teams + Farm + Config
--=============================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local CoreGui = game:GetService("CoreGui")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local UIS = UserInputService

--=============================================================
-- KEY SYSTEM
--=============================================================
local VALID_KEYS = {
    ["2010pepeu"]=true, ["NEXUS-A1B2-C3D4"]=true, ["NEXUS-E5F6-G7H8"]=true,
    ["NEXUS-I9J0-K1L2"]=true, ["NEXUS-M3N4-O5P6"]=true, ["NEXUS-Q7R8-S9T0"]=true,
    ["NEXUS-U1V2-W3X4"]=true, ["NEXUS-Y5Z6-A7B8"]=true, ["NEXUS-C9D0-E1F2"]=true,
    ["NEXUS-G3H4-I5J6"]=true,
}

local keyOk = false
pcall(function()
    if isfile and readfile and isfile("nexus_key.txt") then
        if VALID_KEYS[readfile("nexus_key.txt")] then keyOk = true end
    end
end)

if not keyOk then
    local parentGui = CoreGui
    local testOk = pcall(function()
        local t = Instance.new("ScreenGui"); t.Parent = CoreGui; t:Destroy()
    end)
    if not testOk then parentGui = LocalPlayer:WaitForChild("PlayerGui") end

    local KeyGui = Instance.new("ScreenGui")
    KeyGui.Name = "NexusKey"
    KeyGui.IgnoreGuiInset = true
    KeyGui.ResetOnSpawn = false
    KeyGui.DisplayOrder = 99999
    KeyGui.Parent = parentGui

    local KBg = Instance.new("Frame")
    KBg.Size = UDim2.fromScale(1,1)
    KBg.BackgroundColor3 = Color3.fromRGB(8,8,18)
    KBg.BorderSizePixel = 0
    KBg.Parent = KeyGui

    local KCard = Instance.new("Frame")
    KCard.AnchorPoint = Vector2.new(0.5,0.5)
    KCard.Position = UDim2.fromScale(0.5,0.5)
    KCard.Size = UDim2.fromOffset(420,280)
    KCard.BackgroundColor3 = Color3.fromRGB(15,15,25)
    KCard.BorderSizePixel = 0
    KCard.Parent = KBg

    local KCardC = Instance.new("UICorner")
    KCardC.CornerRadius = UDim.new(0,14)
    KCardC.Parent = KCard

    local KStroke = Instance.new("UIStroke")
    KStroke.Color = Color3.fromRGB(0,255,224)
    KStroke.Thickness = 1.5
    KStroke.Parent = KCard

    local KTitle = Instance.new("TextLabel")
    KTitle.Size = UDim2.new(1,0,0,50)
    KTitle.Position = UDim2.new(0,0,0,15)
    KTitle.BackgroundTransparency = 1
    KTitle.Text = "NEXUS HUB"
    KTitle.Font = Enum.Font.GothamBlack
    KTitle.TextSize = 32
    KTitle.TextColor3 = Color3.fromRGB(0,255,224)
    KTitle.Parent = KCard

    local KSub = Instance.new("TextLabel")
    KSub.Size = UDim2.new(1,0,0,20)
    KSub.Position = UDim2.new(0,0,0,60)
    KSub.BackgroundTransparency = 1
    KSub.Text = "Digite sua Key"
    KSub.Font = Enum.Font.Gotham
    KSub.TextSize = 13
    KSub.TextColor3 = Color3.fromRGB(180,180,210)
    KSub.Parent = KCard

    local KBox = Instance.new("Frame")
    KBox.Size = UDim2.new(1,-60,0,44)
    KBox.Position = UDim2.new(0,30,0,105)
    KBox.BackgroundColor3 = Color3.fromRGB(25,25,40)
    KBox.BorderSizePixel = 0
    KBox.Parent = KCard

    local KBoxC = Instance.new("UICorner")
    KBoxC.CornerRadius = UDim.new(0,8)
    KBoxC.Parent = KBox

    local KInput = Instance.new("TextBox")
    KInput.Size = UDim2.fromScale(1,1)
    KInput.BackgroundTransparency = 1
    KInput.Text = ""
    KInput.PlaceholderText = "Cole sua key..."
    KInput.PlaceholderColor3 = Color3.fromRGB(100,100,130)
    KInput.Font = Enum.Font.Code
    KInput.TextSize = 14
    KInput.TextColor3 = Color3.fromRGB(0,255,224)
    KInput.TextXAlignment = Enum.TextXAlignment.Center
    KInput.ClearTextOnFocus = false
    KInput.Parent = KBox

    local KEnter = Instance.new("TextButton")
    KEnter.Size = UDim2.new(1,-60,0,42)
    KEnter.Position = UDim2.new(0,30,0,165)
    KEnter.BackgroundColor3 = Color3.fromRGB(0,180,160)
    KEnter.BorderSizePixel = 0
    KEnter.Text = "ENTRAR"
    KEnter.Font = Enum.Font.GothamBold
    KEnter.TextSize = 14
    KEnter.TextColor3 = Color3.fromRGB(255,255,255)
    KEnter.Parent = KCard

    local KEnterC = Instance.new("UICorner")
    KEnterC.CornerRadius = UDim.new(0,8)
    KEnterC.Parent = KEnter

    local KStatus = Instance.new("TextLabel")
    KStatus.Size = UDim2.new(1,0,0,20)
    KStatus.Position = UDim2.new(0,0,0,220)
    KStatus.BackgroundTransparency = 1
    KStatus.Text = ""
    KStatus.Font = Enum.Font.Gotham
    KStatus.TextSize = 12
    KStatus.TextColor3 = Color3.fromRGB(255,100,100)
    KStatus.Parent = KCard

    KEnter.MouseButton1Click:Connect(function()
        local e = KInput.Text:gsub("%s+","")
        if e == "" then KStatus.Text = "Digite uma key!" return end
        if VALID_KEYS[e] then
            KStatus.Text = "Key valida!"
            KStatus.TextColor3 = Color3.fromRGB(0,255,136)
            pcall(function() if writefile then writefile("nexus_key.txt", e) end end)
            task.wait(0.5)
            keyOk = true
            KeyGui:Destroy()
        else
            KStatus.Text = "Key invalida!"
            KInput.Text = ""
        end
    end)

    local timeout = tick() + 30
    repeat task.wait(0.1) until keyOk or tick() > timeout
    if not keyOk and KeyGui.Parent then KeyGui:Destroy() end
end

--=============================================================
-- LOAD SCREEN
--=============================================================
if CoreGui:FindFirstChild("NexusLoad") then CoreGui.NexusLoad:Destroy() end
if CoreGui:FindFirstChild("NexusHub") then CoreGui.NexusHub:Destroy() end

local LoadGui = Instance.new("ScreenGui")
LoadGui.Name = "NexusLoad"
LoadGui.IgnoreGuiInset = true
LoadGui.ResetOnSpawn = false
LoadGui.DisplayOrder = 9999
LoadGui.Parent = CoreGui

local LBg = Instance.new("Frame")
LBg.Size = UDim2.fromScale(1,1)
LBg.BackgroundColor3 = Color3.fromRGB(8,8,18)
LBg.BorderSizePixel = 0
LBg.Parent = LoadGui

local LTitle = Instance.new("TextLabel")
LTitle.AnchorPoint = Vector2.new(0.5,0.5)
LTitle.Position = UDim2.fromScale(0.5,0.35)
LTitle.Size = UDim2.fromOffset(700,80)
LTitle.BackgroundTransparency = 1
LTitle.Text = "NEXUS HUB"
LTitle.Font = Enum.Font.GothamBlack
LTitle.TextSize = 60
LTitle.TextColor3 = Color3.fromRGB(0,255,224)
LTitle.Parent = LBg

local LBarBg = Instance.new("Frame")
LBarBg.AnchorPoint = Vector2.new(0.5,0.5)
LBarBg.Position = UDim2.fromScale(0.5,0.55)
LBarBg.Size = UDim2.fromOffset(520,10)
LBarBg.BackgroundColor3 = Color3.fromRGB(20,20,35)
LBarBg.BorderSizePixel = 0
LBarBg.Parent = LBg

local LBarBgC = Instance.new("UICorner")
LBarBgC.CornerRadius = UDim.new(1,0)
LBarBgC.Parent = LBarBg

local LBarFill = Instance.new("Frame")
LBarFill.Size = UDim2.fromScale(0,1)
LBarFill.BackgroundColor3 = Color3.fromRGB(0,255,224)
LBarFill.BorderSizePixel = 0
LBarFill.Parent = LBarBg

local LBarFillC = Instance.new("UICorner")
LBarFillC.CornerRadius = UDim.new(1,0)
LBarFillC.Parent = LBarFill

task.spawn(function()
    for i = 0, 100, 2 do
        TweenService:Create(LBarFill, TweenInfo.new(0.1), {Size = UDim2.fromScale(i/100,1)}):Play()
        task.wait(0.015)
    end
    task.wait(0.3)
    local fade = TweenInfo.new(0.5, Enum.EasingStyle.Quad)
    for _, d in ipairs(LBg:GetDescendants()) do
        if d:IsA("TextLabel") then TweenService:Create(d, fade, {TextTransparency=1}):Play() end
    end
    TweenService:Create(LBg, fade, {BackgroundTransparency=1}):Play()
    task.wait(0.5)
    LoadGui:Destroy()
end)

--=============================================================
-- ESTADO
--=============================================================
local State = {
    Aimbot = { Enabled=false, Mode="Camera", OnClick=false, FOV=120, Smooth=5, Part="Head",
               MaxDist=500, TeamCheck=true, VisibleCheck=true, ShowFOV=true },
    ESP = { Enabled=false, Box=false, Name=false, Dist=false, Line=false, TeamCheck=true,
            Health=false, Skeleton=false, SkeletonThick=1,
            MaxDistance=1000, MinDistance=0 },
    Player = { Fly=false, FlySpeed=150, Noclip=false },
    AutoFarm = { Enabled=false, Speed=0.5 },
}

local AimbotWhitelist = {}

--=============================================================
-- JANELA PRINCIPAL
--=============================================================
local Hub = Instance.new("ScreenGui")
Hub.Name = "NexusHub"
Hub.IgnoreGuiInset = true
Hub.ResetOnSpawn = false
Hub.DisplayOrder = 100
Hub.Parent = CoreGui

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(600, 460)
Main.Position = UDim2.new(0.5, -300, 0.5, -230)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = Hub

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0,12)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(0,255,224)
MainStroke.Thickness = 1.5
MainStroke.Transparency = 0.5
MainStroke.Parent = Main

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1,0,0,40)
Header.BackgroundColor3 = Color3.fromRGB(20,20,32)
Header.BorderSizePixel = 0
Header.Parent = Main

local HeaderC = Instance.new("UICorner")
HeaderC.CornerRadius = UDim.new(0,12)
HeaderC.Parent = Header

local HeaderTitle = Instance.new("TextLabel")
HeaderTitle.Position = UDim2.new(0,15,0,0)
HeaderTitle.Size = UDim2.new(0.7,0,1,0)
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.Text = "NEXUS HUB"
HeaderTitle.Font = Enum.Font.GothamBold
HeaderTitle.TextSize = 16
HeaderTitle.TextColor3 = Color3.fromRGB(0,255,224)
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
HeaderTitle.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.fromOffset(28,28)
CloseBtn.Position = UDim2.new(1,-35,0,6)
CloseBtn.BackgroundColor3 = Color3.fromRGB(220,50,80)
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.TextColor3 = Color3.fromRGB(255,255,255)
CloseBtn.Parent = Header

local CloseC = Instance.new("UICorner")
CloseC.CornerRadius = UDim.new(0,6)
CloseC.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function() Hub:Destroy() end)

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.fromOffset(28,28)
MinBtn.Position = UDim2.new(1,-68,0,6)
MinBtn.BackgroundColor3 = Color3.fromRGB(60,60,80)
MinBtn.BorderSizePixel = 0
MinBtn.Text = "-"
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 14
MinBtn.TextColor3 = Color3.fromRGB(255,255,255)
MinBtn.Parent = Header

local MinC = Instance.new("UICorner")
MinC.CornerRadius = UDim.new(0,6)
MinC.Parent = MinBtn

local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    Main.Visible = not minimized
end)

UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.Home then
        minimized = not minimized
        Main.Visible = not minimized
    end
end)

local Sidebar = Instance.new("Frame")
Sidebar.Position = UDim2.new(0,0,0,40)
Sidebar.Size = UDim2.new(0,140,1,-40)
Sidebar.BackgroundColor3 = Color3.fromRGB(18,18,30)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

local SidebarC = Instance.new("UICorner")
SidebarC.CornerRadius = UDim.new(0,12)
SidebarC.Parent = Sidebar

local Content = Instance.new("Frame")
Content.Position = UDim2.new(0,145,0,45)
Content.Size = UDim2.new(1,-155,1,-55)
Content.BackgroundTransparency = 1
Content.Parent = Main

--=============================================================
-- HELPERS UI
--=============================================================
local function CreateSection(parent, title)
    local sec = Instance.new("Frame")
    sec.Size = UDim2.new(1,0,0,26)
    sec.BackgroundTransparency = 1
    sec.Parent = parent
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.fromScale(1,1)
    lbl.BackgroundTransparency = 1
    lbl.Text = "> " .. title
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 13
    lbl.TextColor3 = Color3.fromRGB(0,255,224)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = sec
end

local function CreateToggle(parent, label, default, callback)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1,0,0,28)
    row.BackgroundTransparency = 1
    row.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.7,0,1,0)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 13
    lbl.TextColor3 = Color3.fromRGB(220,220,230)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = row

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.fromOffset(45,22)
    btn.Position = UDim2.new(1,-45,0.5,-11)
    btn.BackgroundColor3 = default and Color3.fromRGB(0,200,170) or Color3.fromRGB(50,50,65)
    btn.BorderSizePixel = 0
    btn.Text = default and "ON" or "OFF"
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Parent = row

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0,6)
    c.Parent = btn

    local val = default
    btn.MouseButton1Click:Connect(function()
        val = not val
        btn.Text = val and "ON" or "OFF"
        btn.BackgroundColor3 = val and Color3.fromRGB(0,200,170) or Color3.fromRGB(50,50,65)
        if callback then callback(val) end
    end)
end

local function CreateSlider(parent, label, min, max, default, callback)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1,0,0,40)
    row.BackgroundTransparency = 1
    row.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.6,0,0,18)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 12
    lbl.TextColor3 = Color3.fromRGB(220,220,230)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = row

    local valLbl = Instance.new("TextLabel")
    valLbl.Size = UDim2.new(0.4,0,0,18)
    valLbl.Position = UDim2.new(0.6,0,0,0)
    valLbl.BackgroundTransparency = 1
    valLbl.Text = tostring(default)
    valLbl.Font = Enum.Font.Code
    valLbl.TextSize = 12
    valLbl.TextColor3 = Color3.fromRGB(0,255,224)
    valLbl.TextXAlignment = Enum.TextXAlignment.Right
    valLbl.Parent = row

    local track = Instance.new("Frame")
    track.Position = UDim2.new(0,0,0,24)
    track.Size = UDim2.new(1,0,0,6)
    track.BackgroundColor3 = Color3.fromRGB(40,40,55)
    track.BorderSizePixel = 0
    track.Parent = row

    local tc = Instance.new("UICorner")
    tc.CornerRadius = UDim.new(1,0)
    tc.Parent = track

    local fill = Instance.new("Frame")
    fill.Size = UDim2.fromScale((default-min)/(max-min),1)
    fill.BackgroundColor3 = Color3.fromRGB(0,255,224)
    fill.BorderSizePixel = 0
    fill.Parent = track

    local fc = Instance.new("UICorner")
    fc.CornerRadius = UDim.new(1,0)
    fc.Parent = fill

    local dragging = false

    track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            local pos = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
            local v = math.floor(min + pos * (max - min) + 0.5)
            fill.Size = UDim2.fromScale((v-min)/(max-min),1)
            valLbl.Text = tostring(v)
            if callback then callback(v) end
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local pos = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
            local v = math.floor(min + pos * (max - min) + 0.5)
            fill.Size = UDim2.fromScale((v-min)/(max-min),1)
            valLbl.Text = tostring(v)
            if callback then callback(v) end
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

local function CreateButton(parent, label, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,0,0,30)
    btn.BackgroundColor3 = Color3.fromRGB(30,30,45)
    btn.BorderSizePixel = 0
    btn.Text = label
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.TextColor3 = Color3.fromRGB(0,255,224)
    btn.Parent = parent

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0,8)
    c.Parent = btn

    btn.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
    return btn
end

local function CreateDropdown(parent, label, options, default, callback)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1,0,0,30)
    row.BackgroundTransparency = 1
    row.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.5,0,1,0)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 13
    lbl.TextColor3 = Color3.fromRGB(220,220,230)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = row

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.5,-10,0,24)
    btn.Position = UDim2.new(0.5,10,0.5,-12)
    btn.BackgroundColor3 = Color3.fromRGB(30,30,45)
    btn.BorderSizePixel = 0
    btn.Text = default .. " v"
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    btn.TextColor3 = Color3.fromRGB(0,255,224)
    btn.Parent = row

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0,6)
    c.Parent = btn

    local current = 1
    for i, v in ipairs(options) do
        if v == default then current = i break end
    end

    btn.MouseButton1Click:Connect(function()
        current = current + 1
        if current > #options then current = 1 end
        btn.Text = options[current] .. " v"
        if callback then callback(options[current]) end
    end)
end

--=============================================================
-- NOTIFICACAO
--=============================================================
local function Notificar(titulo, texto, cor)
    local notif = Instance.new("Frame")
    notif.Size = UDim2.fromOffset(280,60)
    notif.Position = UDim2.new(1,20,1,-80)
    notif.BackgroundColor3 = Color3.fromRGB(20,20,32)
    notif.BorderSizePixel = 0
    notif.Parent = Hub

    local nc = Instance.new("UICorner")
    nc.CornerRadius = UDim.new(0,10)
    nc.Parent = notif

    local ns = Instance.new("UIStroke")
    ns.Color = cor
    ns.Thickness = 1.5
    ns.Parent = notif

    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1,-20,0,22)
    t.Position = UDim2.new(0,10,0,5)
    t.BackgroundTransparency = 1
    t.Text = titulo
    t.Font = Enum.Font.GothamBold
    t.TextSize = 13
    t.TextColor3 = cor
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.Parent = notif

    local d = Instance.new("TextLabel")
    d.Size = UDim2.new(1,-20,0,30)
    d.Position = UDim2.new(0,10,0,25)
    d.BackgroundTransparency = 1
    d.Text = texto
    d.Font = Enum.Font.Gotham
    d.TextSize = 11
    d.TextColor3 = Color3.fromRGB(200,200,210)
    d.TextXAlignment = Enum.TextXAlignment.Left
    d.TextWrapped = true
    d.Parent = notif

    TweenService:Create(notif, TweenInfo.new(0.3), {Position = UDim2.new(1,-300,1,-80)}):Play()
    task.delay(3, function()
        TweenService:Create(notif, TweenInfo.new(0.3), {Position = UDim2.new(1,20,1,-80)}):Play()
        task.wait(0.3)
        notif:Destroy()
    end)
end

--=============================================================
-- ABAS
--=============================================================
local tabButtons = {}
local tabContents = {}
local tabsContainer = Instance.new("Frame")
tabsContainer.Position = UDim2.new(0,5,0,5)
tabsContainer.Size = UDim2.new(1,-10,1,-10)
tabsContainer.BackgroundTransparency = 1
tabsContainer.Parent = Sidebar

local tabsLayout = Instance.new("UIListLayout")
tabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabsLayout.Padding = UDim.new(0,5)
tabsLayout.Parent = tabsContainer

local function SwitchTab(name)
    for _, c in pairs(tabContents) do c.Visible = false end
    if tabContents[name] then tabContents[name].Visible = true end
    for _, btn in pairs(tabButtons) do
        btn.BackgroundColor3 = (btn.Name == name) and Color3.fromRGB(0,180,160) or Color3.fromRGB(28,28,42)
    end
end

local function AddTab(name, icon)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(1,0,0,30)
    btn.BackgroundColor3 = Color3.fromRGB(28,28,42)
    btn.BorderSizePixel = 0
    btn.Text = "  " .. icon .. "  " .. name
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.TextColor3 = Color3.fromRGB(220,220,230)
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = tabsContainer

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0,8)
    c.Parent = btn

    btn.MouseButton1Click:Connect(function() SwitchTab(name) end)
    tabButtons[name] = btn

    local content = Instance.new("Frame")
    content.Size = UDim2.fromScale(1,1)
    content.BackgroundTransparency = 1
    content.Visible = false
    content.Parent = Content

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.fromScale(1,1)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 4
    scroll.ScrollBarImageColor3 = Color3.fromRGB(0,255,224)
    scroll.CanvasSize = UDim2.new(0,0,0,0)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.Parent = content

    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0,6)
    layout.Parent = scroll

    tabContents[name] = content
    return scroll
end

--=============================================================
-- ABA PLAYER (com TP para players)
--=============================================================
local PlayerTab = AddTab("Player", "P")

local flyConnection, flyBodyVelocity, flyBodyGyro

local function StartFly()
    if not LocalPlayer.Character then return end
    local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.PlatformStand = true end

    flyBodyVelocity = Instance.new("BodyVelocity")
    flyBodyVelocity.MaxForce = Vector3.new(9e9,9e9,9e9)
    flyBodyVelocity.Parent = hrp

    flyBodyGyro = Instance.new("BodyGyro")
    flyBodyGyro.MaxTorque = Vector3.new(9e9,9e9,9e9)
    flyBodyGyro.P = 1000
    flyBodyGyro.D = 50
    flyBodyGyro.Parent = hrp

    flyConnection = RunService.RenderStepped:Connect(function()
        if not State.Player.Fly then return end
        if not LocalPlayer.Character then return end
        local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not root then return end

        local moveDir = Vector3.zero
        if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Camera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Camera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0,1,0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir = moveDir - Vector3.new(0,1,0) end

        flyBodyVelocity.Velocity = moveDir.Magnitude > 0 and moveDir.Unit * State.Player.FlySpeed or Vector3.zero
        flyBodyGyro.CFrame = Camera.CFrame
    end)
end

local function StopFly()
    if flyConnection then flyConnection:Disconnect() flyConnection = nil end
    if flyBodyVelocity then flyBodyVelocity:Destroy() flyBodyVelocity = nil end
    if flyBodyGyro then flyBodyGyro:Destroy() flyBodyGyro = nil end
    if LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.PlatformStand = false end
    end
end

CreateSection(PlayerTab, "Movimento")
CreateToggle(PlayerTab, "Fly (WASD + Space/LCtrl)", false, function(v)
    State.Player.Fly = v
    if v then StartFly() else StopFly() end
end)
CreateSlider(PlayerTab, "Velocidade do Fly", 50, 1000, 150, function(v) State.Player.FlySpeed = v end)
CreateToggle(PlayerTab, "Noclip", false, function(v) State.Player.Noclip = v end)

-- ============ TP PARA PLAYERS ============
CreateSection(PlayerTab, "Teleport (TP)")

local selectedTP = nil

local tpFrame = Instance.new("Frame")
tpFrame.Size = UDim2.new(1,0,0,180)
tpFrame.BackgroundColor3 = Color3.fromRGB(20,20,35)
tpFrame.BorderSizePixel = 0
tpFrame.Parent = PlayerTab

local tpFrameC = Instance.new("UICorner")
tpFrameC.CornerRadius = UDim.new(0,8)
tpFrameC.Parent = tpFrame

local tpScroll = Instance.new("ScrollingFrame")
tpScroll.Size = UDim2.fromScale(1,1)
tpScroll.BackgroundTransparency = 1
tpScroll.BorderSizePixel = 0
tpScroll.ScrollBarThickness = 4
tpScroll.ScrollBarImageColor3 = Color3.fromRGB(0,255,224)
tpScroll.CanvasSize = UDim2.new(0,0,0,0)
tpScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
tpScroll.Parent = tpFrame

local tpLayout = Instance.new("UIListLayout")
tpLayout.SortOrder = Enum.SortOrder.LayoutOrder
tpLayout.Padding = UDim.new(0,3)
tpLayout.Parent = tpScroll

local tpPad = Instance.new("UIPadding")
tpPad.PaddingTop = UDim.new(0,6)
tpPad.PaddingLeft = UDim.new(0,6)
tpPad.PaddingRight = UDim.new(0,6)
tpPad.Parent = tpScroll

local tpRows = {}
local selectedTPRow = nil

local function RefreshTPList()
    for _, row in ipairs(tpRows) do
        if row and row.Parent then row:Destroy() end
    end
    tpRows = {}

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local row = Instance.new("TextButton")
            row.Size = UDim2.new(1,-12,0,24)
            row.BackgroundColor3 = Color3.fromRGB(35,35,55)
            row.BorderSizePixel = 0
            row.Text = ""
            row.Parent = tpScroll

            local rc = Instance.new("UICorner")
            rc.CornerRadius = UDim.new(0,6)
            rc.Parent = row

            local txt = Instance.new("TextLabel")
            txt.Position = UDim2.new(0,10,0,0)
            txt.Size = UDim2.new(1,-14,1,0)
            txt.BackgroundTransparency = 1
            txt.Text = plr.Name
            txt.Font = Enum.Font.Gotham
            txt.TextSize = 12
            txt.TextColor3 = Color3.fromRGB(220,220,230)
            txt.TextXAlignment = Enum.TextXAlignment.Left
            txt.Parent = row

            row.MouseButton1Click:Connect(function()
                if selectedTPRow then
                    selectedTPRow.BackgroundColor3 = Color3.fromRGB(35,35,55)
                end
                row.BackgroundColor3 = Color3.fromRGB(0,180,160)
                selectedTPRow = row
                selectedTP = plr.Name
            end)

            table.insert(tpRows, row)
        end
    end
end

RefreshTPList()

CreateButton(PlayerTab, "📍 TP para o jogador selecionado", function()
    if not selectedTP then
        Notificar("Nenhum jogador", "Clique num jogador da lista", Color3.fromRGB(255,180,0))
        return
    end
    local target = Players:FindFirstChild(selectedTP)
    if not target or not target.Character then
        Notificar("Nao encontrado", selectedTP.." saiu", Color3.fromRGB(255,180,0))
        return
    end
    local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
    local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if targetHRP and myHRP then
        myHRP.CFrame = targetHRP.CFrame + Vector3.new(0, 3, 0)
        Notificar("Teleportado", "Para: "..selectedTP, Color3.fromRGB(0,255,136))
    else
        Notificar("Falha", "Nao foi possivel teleportar", Color3.fromRGB(255,100,100))
    end
end)

CreateButton(PlayerTab, "🔄 Atualizar lista de players", function()
    RefreshTPList()
    Notificar("Lista atualizada", #tpRows.." jogadores", Color3.fromRGB(0,200,255))
end)

task.spawn(function()
    while PlayerTab.Parent do
        task.wait(5)
        RefreshTPList()
    end
end)

--=============================================================
-- ABA AIMBOT
--=============================================================
local AimbotTab = AddTab("Aimbot", "A")

CreateSection(AimbotTab, "Geral")
CreateToggle(AimbotTab, "Ativar Aimbot", false, function(v) State.Aimbot.Enabled = v end)
CreateToggle(AimbotTab, "Segurar Botao Direito", false, function(v) State.Aimbot.OnClick = v end)
CreateToggle(AimbotTab, "Ignorar Time", true, function(v) State.Aimbot.TeamCheck = v end)
CreateToggle(AimbotTab, "Verificar Visibilidade", true, function(v) State.Aimbot.VisibleCheck = v end)

CreateSection(AimbotTab, "Modo")
CreateDropdown(AimbotTab, "Tipo", {"Camera","Snap","Rage"}, "Camera", function(v) State.Aimbot.Mode = v end)

CreateSection(AimbotTab, "Config")
CreateSlider(AimbotTab, "FOV", 10, 800, 120, function(v) State.Aimbot.FOV = v end)
CreateSlider(AimbotTab, "Suavidade", 1, 100, 5, function(v) State.Aimbot.Smooth = v end)
CreateSlider(AimbotTab, "Distancia maxima", 10, 1000, 500, function(v) State.Aimbot.MaxDist = v end)
CreateDropdown(AimbotTab, "Parte do alvo", {"Head","UpperTorso","HumanoidRootPart"}, "Head", function(v) State.Aimbot.Part = v end)

CreateSection(AimbotTab, "FOV Visual")
CreateToggle(AimbotTab, "Mostrar circulo FOV", true, function(v) State.Aimbot.ShowFOV = v end)

CreateSection(AimbotTab, "Whitelist (ignorar jogadores)")
local wlInfo = Instance.new("TextLabel")
wlInfo.Size = UDim2.new(1,0,0,20)
wlInfo.BackgroundTransparency = 1
wlInfo.Text = "Clique pra marcar quem NAO deve ser mirado"
wlInfo.Font = Enum.Font.Gotham
wlInfo.TextSize = 11
wlInfo.TextColor3 = Color3.fromRGB(150,150,180)
wlInfo.TextXAlignment = Enum.TextXAlignment.Left
wlInfo.Parent = AimbotTab

local playerListFrame = Instance.new("Frame")
playerListFrame.Size = UDim2.new(1,0,0,150)
playerListFrame.BackgroundColor3 = Color3.fromRGB(20,20,35)
playerListFrame.BorderSizePixel = 0
playerListFrame.Parent = AimbotTab

local plfc = Instance.new("UICorner")
plfc.CornerRadius = UDim.new(0,8)
plfc.Parent = playerListFrame

local plScroll = Instance.new("ScrollingFrame")
plScroll.Size = UDim2.fromScale(1,1)
plScroll.BackgroundTransparency = 1
plScroll.BorderSizePixel = 0
plScroll.ScrollBarThickness = 4
plScroll.ScrollBarImageColor3 = Color3.fromRGB(0,255,224)
plScroll.CanvasSize = UDim2.new(0,0,0,0)
plScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
plScroll.Parent = playerListFrame

local plLayout = Instance.new("UIListLayout")
plLayout.SortOrder = Enum.SortOrder.LayoutOrder
plLayout.Padding = UDim.new(0,3)
plLayout.Parent = plScroll

local plPad = Instance.new("UIPadding")
plPad.PaddingTop = UDim.new(0,6)
plPad.PaddingLeft = UDim.new(0,6)
plPad.PaddingRight = UDim.new(0,6)
plPad.Parent = plScroll

local playerRows = {}

local function RefreshPlayerList()
    for _, row in ipairs(playerRows) do
        if row and row.Parent then row:Destroy() end
    end
    playerRows = {}

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local row = Instance.new("TextButton")
            row.Size = UDim2.new(1,-12,0,24)
            row.BackgroundColor3 = AimbotWhitelist[plr.Name] and Color3.fromRGB(120,30,30) or Color3.fromRGB(35,35,55)
            row.BorderSizePixel = 0
            row.Text = ""
            row.Parent = plScroll

            local rc = Instance.new("UICorner")
            rc.CornerRadius = UDim.new(0,6)
            rc.Parent = row

            local check = Instance.new("Frame")
            check.Size = UDim2.fromOffset(14,14)
            check.Position = UDim2.new(0,8,0.5,-7)
            check.BackgroundColor3 = AimbotWhitelist[plr.Name] and Color3.fromRGB(255,80,80) or Color3.fromRGB(60,60,80)
            check.BorderSizePixel = 0
            check.Parent = row

            local ccc = Instance.new("UICorner")
            ccc.CornerRadius = UDim.new(0,3)
            ccc.Parent = check

            local mark = Instance.new("TextLabel")
            mark.Size = UDim2.fromScale(1,1)
            mark.BackgroundTransparency = 1
            mark.Text = AimbotWhitelist[plr.Name] and "X" or ""
            mark.Font = Enum.Font.GothamBold
            mark.TextSize = 11
            mark.TextColor3 = Color3.fromRGB(255,255,255)
            mark.Parent = check

            local txt = Instance.new("TextLabel")
            txt.Position = UDim2.new(0,30,0,0)
            txt.Size = UDim2.new(1,-34,1,0)
            txt.BackgroundTransparency = 1
            txt.Text = plr.Name
            txt.Font = Enum.Font.Gotham
            txt.TextSize = 12
            txt.TextColor3 = Color3.fromRGB(220,220,230)
            txt.TextXAlignment = Enum.TextXAlignment.Left
            txt.Parent = row

            row.MouseButton1Click:Connect(function()
                if AimbotWhitelist[plr.Name] then
                    AimbotWhitelist[plr.Name] = nil
                    row.BackgroundColor3 = Color3.fromRGB(35,35,55)
                    check.BackgroundColor3 = Color3.fromRGB(60,60,80)
                    mark.Text = ""
                else
                    AimbotWhitelist[plr.Name] = true
                    row.BackgroundColor3 = Color3.fromRGB(120,30,30)
                    check.BackgroundColor3 = Color3.fromRGB(255,80,80)
                    mark.Text = "X"
                end
            end)

            table.insert(playerRows, row)
        end
    end
end

RefreshPlayerList()
CreateButton(AimbotTab, "Atualizar lista", function() RefreshPlayerList() end)
CreateButton(AimbotTab, "Limpar whitelist", function() AimbotWhitelist = {} RefreshPlayerList() end)

task.spawn(function()
    while AimbotTab.Parent do
        task.wait(5)
        RefreshPlayerList()
    end
end)

local function IsAliveAimbot(plr)
    if not (plr and plr.Character) then return false end
    local hum = plr.Character:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return false end
    return true
end

local function IsVisibleCheck(targetPart)
    if not State.Aimbot.VisibleCheck then return true end
    local origin = Camera.CFrame.Position
    local direction = (targetPart.Position - origin)
    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {LocalPlayer.Character, targetPart.Parent}
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.IgnoreWater = true
    return workspace:Raycast(origin, direction, params) == nil
end

local function GetClosestTarget()
    local closest, closestDist = nil, State.Aimbot.FOV
    local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and IsAliveAimbot(plr) then
            if AimbotWhitelist[plr.Name] then continue end
            if State.Aimbot.TeamCheck and plr.Team == LocalPlayer.Team then continue end

            local target = plr.Character:FindFirstChild(State.Aimbot.Part)
            if target then
                local screenPos, onScreen = Camera:WorldToViewportPoint(target.Position)
                if onScreen then
                    local mag = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
                    local dist = (Camera.CFrame.Position - target.Position).Magnitude
                    if mag <= State.Aimbot.FOV and dist <= State.Aimbot.MaxDist then
                        if IsVisibleCheck(target) and mag < closestDist then
                            closestDist = mag
                            closest = plr
                        end
                    end
                end
            end
        end
    end
    return closest
end

local lastTriggerShot = 0

local function ExecuteAimbot()
    if not State.Aimbot.Enabled then return end
    if State.Aimbot.OnClick and not UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then return end
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end

    local target = GetClosestTarget()
    if not target or not target.Character then return end

    local part = target.Character:FindFirstChild(State.Aimbot.Part)
        or target.Character:FindFirstChild("Head")
        or target.Character:FindFirstChild("HumanoidRootPart")
    if not part then return end

    if State.Aimbot.Mode == "Camera" then
        local alpha = 1 - (State.Aimbot.Smooth / 100)
        Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, part.Position), math.max(alpha, 0.02))
    elseif State.Aimbot.Mode == "Snap" then
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, part.Position)
    elseif State.Aimbot.Mode == "Rage" then
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, part.Position)
        if tick() - lastTriggerShot > 0.05 then
            lastTriggerShot = tick()
            pcall(function() mouse1click() end)
        end
    end
end

--=============================================================
-- ABA ESP
--=============================================================
local EspTab = AddTab("ESP", "E")
local ESPObjs = {}

CreateSection(EspTab, "Ativacao")
CreateToggle(EspTab, "Ativar ESP", false, function(v)
    State.ESP.Enabled = v
    if not v then
        for _, esp in pairs(ESPObjs) do
            for _, d in pairs(esp) do
                if d and d.Visible ~= nil then pcall(function() d.Visible = false end) end
            end
        end
    end
end)
CreateToggle(EspTab, "Filtro por equipe", true, function(v) State.ESP.TeamCheck = v end)

CreateSection(EspTab, "Distancia")
CreateSlider(EspTab, "Distancia maxima (m)", 10, 2000, 1000, function(v) State.ESP.MaxDistance = v end)
CreateSlider(EspTab, "Distancia minima (m)", 0, 200, 0, function(v) State.ESP.MinDistance = v end)

CreateSection(EspTab, "Elementos")
CreateToggle(EspTab, "Caixa (Box)", false, function(v) State.ESP.Box = v end)
CreateToggle(EspTab, "Nome", false, function(v) State.ESP.Name = v end)
CreateToggle(EspTab, "Distancia (texto)", false, function(v) State.ESP.Dist = v end)
CreateToggle(EspTab, "Vida (Health)", false, function(v) State.ESP.Health = v end)
CreateToggle(EspTab, "Linha / Tracer", false, function(v) State.ESP.Line = v end)

CreateSection(EspTab, "Skeleton")
CreateToggle(EspTab, "Ativar Skeleton", false, function(v) State.ESP.Skeleton = v end)
CreateSlider(EspTab, "Espessura das linhas", 1, 5, 1, function(v) State.ESP.SkeletonThick = v end)

local function CreateSkeletonPart()
    local l = Drawing.new("Line")
    l.Thickness = 1
    l.Transparency = 1
    return l
end

local function CreateESP(plr)
    if plr == LocalPlayer then return end
    local o = {
        Box = Drawing.new("Square"),
        Name = Drawing.new("Text"),
        Dist = Drawing.new("Text"),
        Health = Drawing.new("Text"),
        Line = Drawing.new("Line"),
        Head = CreateSkeletonPart(),
        Torso = CreateSkeletonPart(),
        ArmL = CreateSkeletonPart(),
        ArmR = CreateSkeletonPart(),
        LegL = CreateSkeletonPart(),
        LegR = CreateSkeletonPart(),
    }
    o.Box.Thickness = 1.5
    o.Box.Filled = false
    o.Name.Size = 13
    o.Name.Center = true
    o.Name.Outline = true
    o.Dist.Size = 12
    o.Dist.Center = true
    o.Dist.Outline = true
    o.Health.Size = 12
    o.Health.Center = true
    o.Health.Outline = true
    o.Line.Thickness = 1
    ESPObjs[plr] = o
end

for _, p in ipairs(Players:GetPlayers()) do CreateESP(p) end
Players.PlayerAdded:Connect(CreateESP)
Players.PlayerRemoving:Connect(function(p)
    if ESPObjs[p] then
        for _, d in pairs(ESPObjs[p]) do
            if d and d.Remove then pcall(function() d:Remove() end) end
        end
        ESPObjs[p] = nil
    end
end)

--=============================================================
-- ABA ARMAS
--=============================================================
local WeaponsTab = AddTab("Armas", "W")
local AmmoState = { InfiniteAmmo=false, AutoReload=true }

local function AplicarMunicaoInfinita()
    local char = LocalPlayer.Character
    if not char then return end
    for _, obj in ipairs(char:GetDescendants()) do
        if obj:IsA("IntValue") or obj:IsA("NumberValue") then
            local n = obj.Name:lower()
            if n:find("ammo") or n:find("municao") or n:find("bullet") or n:find("bala") or n:find("mag") or n:find("clip") then
                obj.Value = 999
            end
        end
    end
end

task.spawn(function()
    while true do
        task.wait(0.1)
        if AmmoState.InfiniteAmmo then pcall(AplicarMunicaoInfinita) end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.02)
        if AmmoState.AutoReload and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
            local char = LocalPlayer.Character
            if char then
                local tool = char:FindFirstChildWhichIsA("Tool")
                if tool then
                    for _, obj in ipairs(tool:GetDescendants()) do
                        if obj:IsA("IntValue") or obj:IsA("NumberValue") then
                            local n = obj.Name:lower()
                            if n:find("ammo") or n:find("municao") or n:find("bullet") or n:find("bala") or n:find("mag") or n:find("clip") then
                                obj.Value = 999
                            end
                        end
                    end
                end
            end
        end
    end
end)

CreateSection(WeaponsTab, "Municao")
CreateToggle(WeaponsTab, "Municao Infinita", false, function(v)
    AmmoState.InfiniteAmmo = v
    if v then AplicarMunicaoInfinita() Notificar("Municao Infinita", "Ativada", Color3.fromRGB(0,255,136)) end
end)
CreateToggle(WeaponsTab, "Atirar sem recarregar", true, function(v)
    AmmoState.AutoReload = v
    AmmoState.InfiniteAmmo = v
end)

--=============================================================
-- ABA TEAMS
--=============================================================
local TeamsTab = AddTab("Teams", "T")

local teamsList = {"Civil","Eletricista","Samu","PM","GCM","CI","CRT","PRF","TDF","MEC","ROTA","PF","PC","BOPE","Cartel","Militar","Federal","EB","Turquia"}

local function EncontrarTimePorNome(nomeBusca)
    local nomeLower = string.lower(nomeBusca)
    for _, team in ipairs(game:GetService("Teams"):GetChildren()) do
        if string.find(string.lower(team.Name), nomeLower, 1, true) then
            return team
        end
    end
    return nil
end

local function AplicarTimeEmMim(nomeBusca)
    if not nomeBusca or nomeBusca == "" then return false end
    local sucesso = false
    local teamReal = EncontrarTimePorNome(nomeBusca)

    if teamReal then
        pcall(function()
            LocalPlayer.Team = teamReal
            LocalPlayer.TeamColor = teamReal.TeamColor
            sucesso = true
        end)
    end

    pcall(function()
        local nomeEnviar = teamReal and teamReal.Name or nomeBusca
        for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
            if obj:IsA("RemoteEvent") then
                local n = string.lower(obj.Name)
                if string.find(n, "team") or string.find(n, "time") or string.find(n, "equipe") or string.find(n, "trocar") then
                    pcall(function() obj:FireServer(nomeEnviar) end)
                    pcall(function() obj:FireServer(LocalPlayer, nomeEnviar) end)
                    sucesso = true
                end
            end
        end
    end)

    return sucesso, teamReal and teamReal.Name or nil
end

CreateSection(TeamsTab, "Clique num time")
local selectedHighlight = nil

for _, nomeTime in ipairs(teamsList) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,0,0,30)
    btn.BackgroundColor3 = Color3.fromRGB(28,28,42)
    btn.BorderSizePixel = 0
    btn.Text = nomeTime
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    btn.TextColor3 = Color3.fromRGB(220,220,230)
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = TeamsTab

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0,8)
    c.Parent = btn

    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0,12)
    padding.Parent = btn

    btn.MouseButton1Click:Connect(function()
        if selectedHighlight then
            selectedHighlight.BackgroundColor3 = Color3.fromRGB(28,28,42)
            local s = selectedHighlight:FindFirstChildOfClass("UIStroke")
            if s then s:Destroy() end
        end
        btn.BackgroundColor3 = Color3.fromRGB(0,100,90)
        local stroke = Instance.new("UIStroke")
        stroke.Color = Color3.fromRGB(0,255,224)
        stroke.Thickness = 2
        stroke.Parent = btn
        selectedHighlight = btn

        local ok, timeEncontrado = AplicarTimeEmMim(nomeTime)
        if ok then
            Notificar("Time aplicado", timeEncontrado or nomeTime, Color3.fromRGB(0,255,136))
        else
            Notificar("Falha", "Nenhum time com '"..nomeTime.."'", Color3.fromRGB(255,180,0))
        end
    end)
end

--=============================================================
-- ABA FARM
--=============================================================
local FarmTab = AddTab("Farm", "F")
CreateSection(FarmTab, "Config")
CreateToggle(FarmTab, "Ativar Auto Farm", false, function(v) State.AutoFarm.Enabled = v end)
CreateSlider(FarmTab, "Velocidade", 0.1, 3, 0.5, function(v) State.AutoFarm.Speed = v end)

task.spawn(function()
    while true do
        task.wait(State.AutoFarm.Speed)
        if State.AutoFarm.Enabled then
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                local cp, cd = nil, math.huge
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("ProximityPrompt") and obj.Enabled then
                        local pa = obj.Parent
                        if pa and pa:IsA("BasePart") then
                            local d = (hrp.Position - pa.Position).Magnitude
                            if d < cd then cd = d cp = obj end
                        end
                    end
                end
                if cp and cp.Parent then
                    hrp.CFrame = CFrame.new(cp.Parent.Position + Vector3.new(0,3,0))
                    task.wait(0.1)
                    pcall(function() fireproximityprompt(cp) end)
                end
            end
        end
    end
end)

--=============================================================
-- ABA CONFIG
--=============================================================
local ConfigTab = AddTab("Config", "C")
CreateSection(ConfigTab, "Interface")
CreateSlider(ConfigTab, "Tamanho", 80, 150, 100, function(v) Main.Size = UDim2.fromOffset(600*(v/100), 460*(v/100)) end)
CreateSlider(ConfigTab, "Transparencia", 0, 100, 0, function(v) Main.BackgroundTransparency = v/100 end)

CreateSection(ConfigTab, "Sessao")
CreateButton(ConfigTab, "Log Out", function()
    pcall(function()
        if delfile and isfile("nexus_key.txt") then
            delfile("nexus_key.txt")
            Notificar("Deslogado", "Reabra o script", Color3.fromRGB(0,255,136))
        end
    end)
end)
CreateButton(ConfigTab, "Fechar Hub", function() Hub:Destroy() end)

--=============================================================
-- LOOP PRINCIPAL
--=============================================================
local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = false
FOVCircle.Radius = State.Aimbot.FOV
FOVCircle.Thickness = 2
FOVCircle.NumSides = 100
FOVCircle.Color = Color3.fromRGB(0,255,224)

task.spawn(function()
    while true do
        task.wait(0.1)
        if State.Player.Noclip and LocalPlayer.Character then
            for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    FOVCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    FOVCircle.Radius = State.Aimbot.FOV
    FOVCircle.Visible = State.Aimbot.Enabled and State.Aimbot.ShowFOV

    pcall(ExecuteAimbot)

    for plr, esp in pairs(ESPObjs) do
        local show = State.ESP.Enabled and IsAliveAimbot(plr)
        if show and State.ESP.TeamCheck and plr.Team == LocalPlayer.Team then show = false end

        if show and plr.Character then
            local hrp0 = plr.Character:FindFirstChild("HumanoidRootPart")
            if hrp0 then
                local d0 = (Camera.CFrame.Position - hrp0.Position).Magnitude
                if d0 > State.ESP.MaxDistance or d0 < State.ESP.MinDistance then
                    show = false
                end
            end
        end

        if show and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = plr.Character.HumanoidRootPart
            local pos, vis = Camera:WorldToViewportPoint(hrp.Position)
            if vis then
                local clr = (plr.Team == LocalPlayer.Team) and Color3.fromRGB(0,255,0) or Color3.fromRGB(0,255,224)
                local dist = (Camera.CFrame.Position - hrp.Position).Magnitude
                local sz = math.clamp(1200/dist, 22, 110)

                esp.Box.Visible = State.ESP.Box
                if State.ESP.Box then
                    esp.Box.Size = Vector2.new(sz/1.8, sz)
                    esp.Box.Position = Vector2.new(pos.X, pos.Y) - Vector2.new(sz/3.6, sz/2)
                    esp.Box.Color = clr
                end

                esp.Name.Visible = State.ESP.Name
                if State.ESP.Name then
                    esp.Name.Text = plr.Name
                    esp.Name.Position = Vector2.new(pos.X, pos.Y - sz/2 - 14)
                    esp.Name.Color = clr
                end

                esp.Dist.Visible = State.ESP.Dist
                if State.ESP.Dist then
                    esp.Dist.Text = math.floor(dist).."m"
                    esp.Dist.Position = Vector2.new(pos.X, pos.Y + sz/2 + 2)
                    esp.Dist.Color = clr
                end

                esp.Health.Visible = State.ESP.Health
                if State.ESP.Health then
                    local hum = plr.Character:FindFirstChildOfClass("Humanoid")
                    if hum then
                        esp.Health.Text = math.floor(hum.Health).." HP"
                        esp.Health.Position = Vector2.new(pos.X, pos.Y - sz/2 - 28)
                        if hum.Health > 60 then
                            esp.Health.Color = Color3.fromRGB(0,255,0)
                        elseif hum.Health > 30 then
                            esp.Health.Color = Color3.fromRGB(255,200,0)
                        else
                            esp.Health.Color = Color3.fromRGB(255,50,50)
                        end
                    end
                end

                esp.Line.Visible = State.ESP.Line
                if State.ESP.Line then
                    esp.Line.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                    esp.Line.To = Vector2.new(pos.X, pos.Y)
                    esp.Line.Color = clr
                end

                if State.ESP.Skeleton and plr.Character then
                    local function GSP(partName)
                        local part = plr.Character:FindFirstChild(partName)
                        if not part then return nil end
                        local p, v = Camera:WorldToViewportPoint(part.Position)
                        if v then return Vector2.new(p.X, p.Y) end
                        return nil
                    end

                    local head = GSP("Head")
                    local torso = GSP("UpperTorso") or GSP("Torso")
                    local hrpP = GSP("HumanoidRootPart")
                    local armL = GSP("LeftHand") or GSP("Left Arm") or GSP("LeftUpperArm")
                    local armR = GSP("RightHand") or GSP("Right Arm") or GSP("RightUpperArm")
                    local legL = GSP("LeftFoot") or GSP("Left Leg") or GSP("LeftUpperLeg")
                    local legR = GSP("RightFoot") or GSP("Right Leg") or GSP("RightUpperLeg")

                    local thick = State.ESP.SkeletonThick or 1

                    if head and torso then
                        esp.Head.Visible = true
                        esp.Head.From = head
                        esp.Head.To = torso
                        esp.Head.Color = clr
                        esp.Head.Thickness = thick
                    else
                        esp.Head.Visible = false
                    end

                    if torso and hrpP then
                        esp.Torso.Visible = true
                        esp.Torso.From = torso
                        esp.Torso.To = hrpP
                        esp.Torso.Color = clr
                        esp.Torso.Thickness = thick
                    else
                        esp.Torso.Visible = false
                    end

                    if torso and armL then
                        esp.ArmL.Visible = true
                        esp.ArmL.From = torso
                        esp.ArmL.To = armL
                        esp.ArmL.Color = clr
                        esp.ArmL.Thickness = thick
                    else
                        esp.ArmL.Visible = false
                    end

                    if torso and armR then
                        esp.ArmR.Visible = true
                        esp.ArmR.From = torso
                        esp.ArmR.To = armR
                        esp.ArmR.Color = clr
                        esp.ArmR.Thickness = thick
                    else
                        esp.ArmR.Visible = false
                    end

                    if hrpP and legL then
                        esp.LegL.Visible = true
                        esp.LegL.From = hrpP
                        esp.LegL.To = legL
                        esp.LegL.Color = clr
                        esp.LegL.Thickness = thick
                    else
                        esp.LegL.Visible = false
                    end

                    if hrpP and legR then
                        esp.LegR.Visible = true
                        esp.LegR.From = hrpP
                        esp.LegR.To = legR
                        esp.LegR.Color = clr
                        esp.LegR.Thickness = thick
                    else
                        esp.LegR.Visible = false
                    end
                else
                    esp.Head.Visible = false
                    esp.Torso.Visible = false
                    esp.ArmL.Visible = false
                    esp.ArmR.Visible = false
                    esp.LegL.Visible = false
                    esp.LegR.Visible = false
                end
            else
                for _, d in pairs(esp) do
                    if d and d.Visible ~= nil then d.Visible = false end
                end
            end
        else
            for _, d in pairs(esp) do
                if d and d.Visible ~= nil then d.Visible = false end
            end
        end
    end
end)

SwitchTab("Player")
Notificar("Nexus Hub", "TP para players adicionado!", Color3.fromRGB(0,255,224))
print("[NEXUS] Hub carregado!")
