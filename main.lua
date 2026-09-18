--=============================================================
-- NEXUS HUB - main.lua
-- Key + Load + Aimbot (whitelist) + ESP + Player + Armas + Teams + Veiculos + AutoFarm
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
    local ok = pcall(function()
        local t = Instance.new("ScreenGui"); t.Parent = CoreGui; t:Destroy()
    end)
    if not ok then parentGui = LocalPlayer:WaitForChild("PlayerGui") end

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

    local kc = Instance.new("UICorner"); kc.CornerRadius = UDim.new(0,14); kc.Parent = KCard
    local ks = Instance.new("UIStroke"); ks.Color = Color3.fromRGB(0,255,224); ks.Thickness = 1.5; ks.Parent = KCard

    local kt = Instance.new("TextLabel")
    kt.Size = UDim2.new(1,0,0,50); kt.Position = UDim2.new(0,0,0,15)
    kt.BackgroundTransparency = 1; kt.Text = "NEXUS HUB"
    kt.Font = Enum.Font.GothamBlack; kt.TextSize = 32
    kt.TextColor3 = Color3.fromRGB(0,255,224); kt.Parent = KCard

    local ksub = Instance.new("TextLabel")
    ksub.Size = UDim2.new(1,0,0,20); ksub.Position = UDim2.new(0,0,0,60)
    ksub.BackgroundTransparency = 1; ksub.Text = "Digite sua Key"
    ksub.Font = Enum.Font.Gotham; ksub.TextSize = 13
    ksub.TextColor3 = Color3.fromRGB(180,180,210); ksub.Parent = KCard

    local kbox = Instance.new("Frame")
    kbox.Size = UDim2.new(1,-60,0,44); kbox.Position = UDim2.new(0,30,0,105)
    kbox.BackgroundColor3 = Color3.fromRGB(25,25,40); kbox.BorderSizePixel = 0; kbox.Parent = KCard

    local kbc = Instance.new("UICorner"); kbc.CornerRadius = UDim.new(0,8); kbc.Parent = kbox

    local kinput = Instance.new("TextBox")
    kinput.Size = UDim2.fromScale(1,1); kinput.BackgroundTransparency = 1
    kinput.Text = ""; kinput.PlaceholderText = "Cole sua key..."
    kinput.PlaceholderColor3 = Color3.fromRGB(100,100,130)
    kinput.Font = Enum.Font.Code; kinput.TextSize = 14
    kinput.TextColor3 = Color3.fromRGB(0,255,224)
    kinput.TextXAlignment = Enum.TextXAlignment.Center
    kinput.ClearTextOnFocus = false; kinput.Parent = kbox

    local kenter = Instance.new("TextButton")
    kenter.Size = UDim2.new(1,-60,0,42); kenter.Position = UDim2.new(0,30,0,165)
    kenter.BackgroundColor3 = Color3.fromRGB(0,180,160); kenter.BorderSizePixel = 0
    kenter.Text = "ENTRAR"; kenter.Font = Enum.Font.GothamBold
    kenter.TextSize = 14; kenter.TextColor3 = Color3.fromRGB(255,255,255); kenter.Parent = KCard

    local kec = Instance.new("UICorner"); kec.CornerRadius = UDim.new(0,8); kec.Parent = kenter

    local kstat = Instance.new("TextLabel")
    kstat.Size = UDim2.new(1,0,0,20); kstat.Position = UDim2.new(0,0,0,220)
    kstat.BackgroundTransparency = 1; kstat.Text = ""
    kstat.Font = Enum.Font.Gotham; kstat.TextSize = 12
    kstat.TextColor3 = Color3.fromRGB(255,100,100); kstat.Parent = KCard

    kenter.MouseButton1Click:Connect(function()
        local e = kinput.Text:gsub("%s+","")
        if e == "" then kstat.Text = "Digite uma key!" return end
        if VALID_KEYS[e] then
            kstat.Text = "Key valida!"; kstat.TextColor3 = Color3.fromRGB(0,255,136)
            pcall(function() if writefile then writefile("nexus_key.txt", e) end end)
            task.wait(0.5); keyOk = true; KeyGui:Destroy()
        else
            kstat.Text = "Key invalida!"; kinput.Text = ""
        end
    end)

    local t0 = tick() + 30
    repeat task.wait(0.1) until keyOk or tick() > t0
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

local lbc = Instance.new("UICorner"); lbc.CornerRadius = UDim.new(1,0); lbc.Parent = LBarBg

local LBarFill = Instance.new("Frame")
LBarFill.Size = UDim2.fromScale(0,1)
LBarFill.BackgroundColor3 = Color3.fromRGB(0,255,224)
LBarFill.BorderSizePixel = 0
LBarFill.Parent = LBarBg

local lbfc = Instance.new("UICorner"); lbfc.CornerRadius = UDim.new(1,0); lbfc.Parent = LBarFill

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
local State
