-- ✅ Tự gia nhập phe từ cấu hình
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer


-- ✅ Cấu hình
local Config = {
    Team = "Marines", 
    SpeedTween = 325,
    Fixlag = true,
    Screen = true,
    EspFruit = true,
    RandomFruit = true,
    AutoStoreFruit = true,
    Random_Auto = true,
    CheckFruitInterval = 0.2,
    MaxStoreErrorsBeforeHop = 1,
    AutoTeleport = true,
    NoClip = true, 
}

-- Kiểm tra sự tồn tại của Remote chuyển phe
if ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CommF_") then
    local currentTeam = LocalPlayer.Team
    -- Kiểm tra nếu người chơi chưa thuộc phe đã chỉ định trong cấu hình
    if currentTeam.Name ~= Config.Team then
        ReplicatedStorage.Remotes.CommF_:InvokeServer("SetTeam", Config.Team)
        print("✅ Đã tự động gia nhập phe " .. Config.Team)
    else
        print("✅ Bạn đã thuộc phe " .. Config.Team .. " rồi!")
    end
else
    print("⚠ Không tìm thấy Remote chuyển team!")
end

wait(1)






-- ✅ Tự động chạy script Fix Lag nếu bật
if Config.FixLag then
    task.spawn(function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/NomDomOnTop/refs/heads/main/SuperFixLag"))()
        end)
    end)
end

local RunService = game:GetService("RunService")
local LocalPlayer = game.Players.LocalPlayer

-- Hàm bật NoClip
local function enableNoClip()
    if Config.NoClip then
        local NoClipConnection
        NoClipConnection = RunService.Stepped:Connect(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                -- Vòng lặp qua tất cả các bộ phận của nhân vật và tắt va chạm
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
        return NoClipConnection
    end
end

-- Hàm tắt NoClip
local function disableNoClip(NoClipConnection)
    if NoClipConnection then
        NoClipConnection:Disconnect()
    end
    local char = LocalPlayer.Character
    if char then
        -- Bật lại va chạm cho tất cả các bộ phận của nhân vật
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

-- Kiểm tra và bật/tắt NoClip
local NoClipConnection = nil

if Config.NoClip then
    -- Bật NoClip
    NoClipConnection = enableNoClip()
else
    -- Tắt NoClip nếu đang bật
    if NoClipConnection then
        disableNoClip(NoClipConnection)
    end
end




-- ✅ Tạo hiệu ứng mờ
local blurEffect = Instance.new("BlurEffect")
blurEffect.Parent = game.Lighting
blurEffect.Size = 30  -- Càng cao thì càng mờ

-- ✅ Vòng lặp kiểm soát hiệu ứng mờ tùy theo Config.Screen
spawn(function()
    while task.wait() do
        blurEffect.Enabled = Config.Screen
    end
end)


-- ✅ Hiển thị chữ "NomDom Hub" mà không có nền
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "NomDomHubUI"

local NomDomLabel = Instance.new("TextLabel")
NomDomLabel.Name = "NomDomLabel"
NomDomLabel.Parent = ScreenGui
NomDomLabel.AnchorPoint = Vector2.new(0.5, 0)
NomDomLabel.Position = UDim2.new(0.5, 0, 0.22, 0) -- Chỉnh cao/thấp tại đây
NomDomLabel.Size = UDim2.new(0, 300, 0, 40)
NomDomLabel.BackgroundTransparency = 1 -- Không có nền
NomDomLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25) -- Không ảnh hưởng vì BackgroundTransparency = 1
NomDomLabel.BorderSizePixel = 0
NomDomLabel.Text = "NomDom Hub"
NomDomLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
NomDomLabel.TextSize = 24
NomDomLabel.Font = Enum.Font.GothamBold
NomDomLabel.TextStrokeTransparency = 0.5
NomDomLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
NomDomLabel.ZIndex = 100
NomDomLabel.Visible = true






-- ✅ UI trạng thái
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "FruitStatus"
gui.ResetOnSpawn = false
local status = Instance.new("TextLabel", gui)
status.Size = UDim2.new(0, 400, 0, 80)
status.Position = UDim2.new(0.5, -200, 0.1, 0)
status.BackgroundTransparency = 1
status.TextScaled = true
status.Font = Enum.Font.GothamBold
status.TextColor3 = Color3.fromRGB(255, 255, 255)
status.Text = "Status : Checking fruit"

-- ✅ ESP trái cây
local fruitsESP = {}
if Config.EspFruit then
    game:GetService("RunService").Heartbeat:Connect(function()
        for _, v in pairs(workspace:GetChildren()) do
            if v:IsA("Tool") and string.find(v.Name:lower(), "fruit") then
                local handle = v:FindFirstChild("Handle")
                if handle and not v:FindFirstChild("ESPBox") then
                    local box = Instance.new("BoxHandleAdornment", v)
                    box.Name = "ESPBox"
                    box.Adornee = handle
                    box.AlwaysOnTop = true
                    box.ZIndex = 5
                    box.Size = Vector3.new(2, 2, 2)
                    box.Transparency = 0.5
                    box.Color3 = Color3.fromRGB(0, 255, 0)

                    local billboard = Instance.new("BillboardGui", handle)
                    billboard.Name = "ESPInfo"
                    billboard.Size = UDim2.new(0, 200, 0, 70)
                    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
                    billboard.AlwaysOnTop = true

                    local nameLabel = Instance.new("TextLabel", billboard)
                    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.Text = v.Name
                    nameLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                    nameLabel.TextScaled = true
                    nameLabel.Font = Enum.Font.SourceSansBold

                    local timeLabel = Instance.new("TextLabel", billboard)
                    timeLabel.Size = UDim2.new(1, 0, 0.5, 0)
                    timeLabel.Position = UDim2.new(0, 0, 0.5, 0)
                    timeLabel.BackgroundTransparency = 1
                    timeLabel.TextColor3 = Color3.Yellow
                    timeLabel.TextScaled = true
                    timeLabel.Font = Enum.Font.SourceSansBold
                    timeLabel.Text = os.date("%H:%M:%S")

                    fruitsESP[v] = {Box = box, Billboard = billboard, TimeLabel = timeLabel}
                elseif fruitsESP[v] and handle then
                    fruitsESP[v].TimeLabel.Text = os.date("%H:%M:%S")
                elseif fruitsESP[v] and not handle then
                    fruitsESP[v].Box:Destroy()
                    fruitsESP[v].Billboard:Destroy()
                    fruitsESP[v] = nil
                end
            end
        end
    end)
end

-- ✅ Tween đến trái cây
local TweenService = game:GetService("TweenService")
local function tweenTo(pos)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local dist = (hrp.Position - pos).Magnitude
        local tweenTime = dist / Config.SpeedTween
        local tween = TweenService:Create(hrp, TweenInfo.new(tweenTime, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)})
        tween:Play()
    end
end

-- ✅ Tìm trái cây
local function findFruit()
    local fruits = {}
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Tool") and string.find(v.Name:lower(), "fruit") and v:FindFirstChild("Handle") then
            table.insert(fruits, v)
        end
    end
    return #fruits > 0 and (Config.RandomFruit and fruits[math.random(1, #fruits)] or fruits[1])
end

local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local isHopping = false

local function hopServer()
    if isHopping then return end
    isHopping = true
    status.Text = "Status : Hop Server..."

    local maxplayers = math.huge
    local serversmaxplayer
    local goodserver
    local gamelink = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100" 

    local function serversearch(link)
        local success, result = pcall(function()
            return HttpService:JSONDecode(game:HttpGet(link))
        end)
        if success and result and result.data then
            for _, v in pairs(result.data) do
                if v.playing and v.id ~= game.JobId and v.playing < maxplayers then
                    serversmaxplayer = v.maxPlayers
                    maxplayers = v.playing
                    goodserver = v.id
                end
            end
            if result.nextPageCursor then
                serversearch(gamelink .. "&cursor=" .. result.nextPageCursor)
            end
        end
    end

    serversearch(gamelink)

    if goodserver then
        TeleportService:TeleportToPlaceInstance(game.PlaceId, goodserver)
    else
        status.Text = "Status : No Server"
        isHopping = false
        task.delay(2, function()  -- ⏳ Đợi 5 giây rồi thử lại
            hopServer()
        end)
    end
end


-- ✅ Chức năng lưu trái
local canStoreFruit, storeErrorCount = true, 0
local Fruits = {
    ["Kilo Fruit"] = "Kilo-Kilo",
    ["Spin Fruit"] = "Spin-Spin",
    ["Rocket Fruit"] = "Rocket-Rocket",
    ["Chop Fruit"] = "Chop-Chop",
    ["Spring Fruit"] = "Spring-Spring",
    ["Bomb Fruit"] = "Bomb-Bomb",
    ["Smoke Fruit"] = "Smoke-Smoke",
    ["Spike Fruit"] = "Spike-Spike",
    ["Flame Fruit"] = "Flame-Flame",
    ["Ice Fruit"] = "Ice-Ice",
    ["Sand Fruit"] = "Sand-Sand",
    ["Dark Fruit"] = "Dark-Dark",
    ["Revive Fruit"] = "Ghost-Ghost",
    ["Diamond Fruit"] = "Diamond-Diamond",
    ["Light Fruit"] = "Light-Light",
    ["Love Fruit"] = "Love-Love",
    ["Rubber Fruit"] = "Rubber-Rubber",
    ["Creation Fruit"] = "Barrier-Barrier", -- tên mới của Barrier
    ["Eagle Fruit"] = "Bird-Bird: Falcon", -- tên mới của Falcon
    ["Magma Fruit"] = "Magma-Magma",
    ["Portal Fruit"] = "Portal-Portal",
    ["Quake Fruit"] = "Quake-Quake",
    ["Human-Human: Buddha Fruit"] = "Human-Human: Buddha",
    ["Spider Fruit"] = "Spider-Spider",
    ["Bird: Phoenix Fruit"] = "Bird-Bird: Phoenix",
    ["Rumble Fruit"] = "Rumble-Rumble",
    ["Paw Fruit"] = "Pain-Pain",
    ["Gravity Fruit"] = "Gravity-Gravity", -- trái vừa được làm lại
    ["Dough Fruit"] = "Dough-Dough",
    ["Shadow Fruit"] = "Shadow-Shadow",
    ["Venom Fruit"] = "Venom-Venom",
    ["Control Fruit"] = "Control-Control",
    ["Spirit Fruit"] = "Spirit-Spirit", -- tên mới của Soul
    ["Dragon Fruit"] = "Dragon-Dragon",
    ["Leopard Fruit"] = "Leopard-Leopard",
    ["Gas Fruit"] = "Gas-Gas"
}


if Config.AutoStoreFruit then
    task.spawn(function()
        while task.wait(0.1) do
            local backpack = LocalPlayer:FindFirstChild("Backpack")
            if canStoreFruit and backpack then
                for _, tool in pairs(backpack:GetChildren()) do
                    if Fruits[tool.Name] then
                        local result = ReplicatedStorage.Remotes.CommF_:InvokeServer("StoreFruit", Fruits[tool.Name])
                        if result == "Success" then
                            storeErrorCount = 0
                            print("Stored:", tool.Name)
                        else
                            storeErrorCount += 1
                            print("Store failed:", tool.Name, "-", result)
                            if storeErrorCount >= Config.MaxStoreErrorsBeforeHop then
                                hopServer()
                            end
                        end
                    end
                end
            end
        end
    end)
end

-- ▶️ Luồng chính
task.spawn(function()
    while true do
        local fruit = findFruit()
        if fruit then
            status.Text = "Status : Fruit Spawns"
            if game.Lighting:FindFirstChildOfClass("BlurEffect") then
                game.Lighting:FindFirstChildOfClass("BlurEffect"):Destroy()
            end
            tweenTo(fruit.Handle.Position)
            repeat task.wait() until not fruit or not fruit:IsDescendantOf(workspace)
            if Config.AutoTeleport then hopServer() end
            break
        else
            status.Text = "Status : Fruits Don't Spawn"
            if Config.AutoTeleport then
                hopServer()
            else
                task.wait(5)
            end
        end
        task.wait(Config.CheckFruitInterval)
    end
end)




-- UI đếm thời gian chơi

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "TimeCounter"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- TextLabel
local label = Instance.new("TextLabel")
label.Parent = gui
label.Size = UDim2.new(0, 350, 0, 40)
label.Position = UDim2.new(0.5, -175, 1, -60) -- Dưới giữa màn hình một chút
label.BackgroundTransparency = 1
label.TextScaled = true
label.TextColor3 = Color3.new(1, 1, 1)
label.Font = Enum.Font.SourceSansBold
label.Text = "Time : 00 Hour | 00 Minute | 00 Second"

-- Timer logic
local seconds = 0

task.spawn(function()
	while true do
		wait(1)
		seconds += 1
		local minutes = math.floor(seconds / 60)
		local hours = math.floor(minutes / 60)
		local displaySeconds = seconds % 60
		local display = string.format("Time : %02d Hour | %02d Minute | %02d Second", hours, minutes % 60, displaySeconds)
		label.Text = display
	end
end)


