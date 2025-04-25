-- Tải thư viện Fluent
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/UiHack/refs/heads/main/Fluent"))()
local window = Fluent:CreateWindow({
    Title = "NomDom | General",
    SubTitle = "by Duy",
    TabWidth = 290,
    Theme = "Dark",
    Acrylic = false,
    Size = UDim2.fromOffset(700, 490),
    MinimizeKey = Enum.KeyCode.End
})

-- Thêm các Tab
local tabs = {
    Infor = window:AddTab({ Title = "Infor" }),
    Main = window:AddTab({ Title = "Anouncement" }),
    Localplayer = window:AddTab({ Title = "Localplayer" }),
    Joinid = window:AddTab({ Title = "Join server" }),
    Bloxfruit = window:AddTab({ Title = "Blox Fruit" }),
    Bluelock = window:AddTab({ Title = "Blue Lock" }),
    Fisch = window:AddTab({ Title = "Fisching" }),
    Petgo = window:AddTab({ Title = "Pet Go" }),
    Deedrails = window:AddTab({ Title = "Deed Rails" }),
    Arisecrossover = window:AddTab({ Title = "Arise Crossover" }),
    Volleyball = window:AddTab({ Title = "Volleyball Legends" }),
    Basketball = window:AddTab({ Title = "Basketball" }),
    Mm2 = window:AddTab({ Title = "Mm2" }),
    Tsb = window:AddTab({ Title = "The Strongest Battlegrounds" }),
    Rivals = window:AddTab({ Title = "Rivals" }),
    Misc = window:AddTab({ Title = "Misc" }),
}

local Options = Fluent.Options
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local speaker = Players.LocalPlayer

-- ⚙️ Phần Thông Tin
tabs.Infor:AddButton({
    Title = "My Discord",
    Description = "Chat",
    Callback = function()
        setclipboard("https://discord.gg/p7CcRT44")
    end
})

tabs.Infor:AddButton({
    Title = "My Youtube",
    Description = "Youtube",
    Callback = function()
        setclipboard("https://www.youtube.com/channel/NomDomDZ")
    end
})

tabs.Infor:AddParagraph({ Title = "Duy Sdikibi", Content = "Dev" })
tabs.Infor:AddParagraph({ Title = "KhangG", Content = "Support" })

-- Phát hiện Executor
local executor = "Không xác định"
if syn then
    executor = "Synapse X"
elseif KRNL_LOADED then
    executor = "KRNL"
elseif fluxus then
    executor = "Fluxus"
elseif getexecutorname then
    local success, execName = pcall(getexecutorname)
    if success and type(execName) == "string" then
        executor = execName
    end
end

tabs.Infor:AddParagraph({ Title = "Use Client", Content = executor })
tabs.Infor:AddParagraph({
    Title = "Cập Nhật",
    Content = "VN: Tôi Sẽ Cập Nhiều Nhiều Script Hơn Để Mang Đến Cho Các Bạn Trải Nghiệm Tốt Nhất | EN: I Will Update More Scenarios To Bring You The Best"
})
tabs.Infor:AddParagraph({ Title = "Supported Android Clients", Content = "Support all Android clients" })
tabs.Infor:AddParagraph({ Title = "Supported PC Clients", Content = "Support all PC clients" })

local Anouncement = tabs.Main:AddSection("Anouncement")

Anouncement:AddParagraph({ Title = "Vn", Content = "Dừng Update script vì phải thi" })
Anouncement:AddParagraph({ Title = "En", Content = "Stop updating script because i have exam" })

local Status = tabs.Main:AddSection("Status")

Status:AddParagraph({ Title = "Script : Working", Content = "" })
Status:AddParagraph({ Title = "Update : Cannot", Content = "" })

-- 🧍 WalkSpeed & Jump
local Walkspeed = tabs.Localplayer:AddSection("WalkSpeed")
local tpwalking = false
local currentSpeed = 90
local overrideSpeed = nil
local heartbeatConnection = nil
local originalWalkSpeed = 16

local function startTeleportWalk(character)
    if not character then return end
    local hum = character:WaitForChild("Humanoid", 5)
    if not hum then return end

    hum.HealthChanged:Connect(function()
        local hpPercent = (hum.Health / hum.MaxHealth) * 100
        if not overrideSpeed then
            currentSpeed = hpPercent <= 30 and 190 or 90
        end
    end)

    if heartbeatConnection then heartbeatConnection:Disconnect() end
    heartbeatConnection = RunService.Heartbeat:Connect(function(dt)
        if tpwalking and hum and hum.Parent then
            local moveDir = hum.MoveDirection
            if moveDir.Magnitude > 0 then
                character:TranslateBy(moveDir * currentSpeed * dt)
            end
        end
    end)
end

Players.LocalPlayer.CharacterAdded:Connect(function(char)
    if tpwalking then
        task.wait(1)
        startTeleportWalk(char)
    end
end)

if speaker.Character then
    startTeleportWalk(speaker.Character)
end

Walkspeed:AddToggle("tpwalk_toggle", {
    Title = "Walk speed",
    Default = false,
    Callback = function(state)
        tpwalking = state
        local char = speaker.Character
        if char then
            if tpwalking then
                startTeleportWalk(char)
                local hum = char:WaitForChild("Humanoid", 5)
                if hum then hum.WalkSpeed = currentSpeed end
            else
                local hum = char:WaitForChild("Humanoid", 5)
                if hum then hum.WalkSpeed = originalWalkSpeed end
                if heartbeatConnection then heartbeatConnection:Disconnect() end
            end
        end
    end
})

Walkspeed:AddInput("speed_input", {
    Title = "Speed",
    Placeholder = "Enter speed",
    Numeric = true,
    Finished = true,
    Callback = function(value)
        local speed = tonumber(value)
        if speed then
            overrideSpeed = speed
            currentSpeed = speed
        else
            overrideSpeed = nil
        end
    end
})

-- 🦘 Jump Settings
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Jump = tabs.Localplayer:AddSection("Jump")

local infiniteJumpEnabled = false
local customJumpPowerEnabled = false
local jumpPowerOverride = nil

-- Infinite Jump Handler
UserInputService.JumpRequest:Connect(function()
    if infiniteJumpEnabled then
        local char = LocalPlayer.Character
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                humanoid.Jump = true
            end
        end
    end
end)

-- Infinite Jump Toggle
Jump:AddToggle("infinite_jump", {
    Title = "Infiniti Jump",
    Default = false,
    Callback = function(state)
        infiniteJumpEnabled = state
    end
})

-- High Jump Toggle
Jump:AddToggle("custom_jump_toggle", {
    Title = "High Jump",
    Default = false,
    Callback = function(state)
        customJumpPowerEnabled = state
        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.JumpPower = state and (jumpPowerOverride or 50) or 50
        end
    end
})

-- Jump Power Input
Jump:AddInput("jump_power", {
    Title = "Jump Power",
    Placeholder = "Enter jump height",
    Numeric = true,
    Finished = true,
    Callback = function(value)
        jumpPowerOverride = tonumber(value)
        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid and customJumpPowerEnabled then
            humanoid.JumpPower = jumpPowerOverride or 50
        end
    end
})

-- Optional: Auto apply custom JumpPower on respawn
LocalPlayer.CharacterAdded:Connect(function(char)
    char:WaitForChild("Humanoid")
    if customJumpPowerEnabled and jumpPowerOverride then
        char.Humanoid.JumpPower = jumpPowerOverride
    end
end)


-- 🚷 NoClip
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Noclip = tabs.Localplayer:AddSection("No Clip")
local NoClip = false
local NoClipConnection

Noclip:AddToggle("NoClip", {
    Title = "NoClip",
    Default = false,
    Callback = function(state)
        NoClip = state

        if NoClip then
            -- Bắt đầu NoClip
            NoClipConnection = RunService.Stepped:Connect(function()
                local char = LocalPlayer.Character
                if char then
                    for _, part in ipairs(char:GetDescendants()) do
                        if part:IsA("BasePart") and part.CanCollide == true then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        else
            -- Tắt NoClip
            if NoClipConnection then
                NoClipConnection:Disconnect()
                NoClipConnection = nil
            end

            local char = LocalPlayer.Character
            if char then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end
    end
})



local Misc = tabs.Localplayer:AddSection("Misc")

local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")



-- Biến kiểm soát trạng thái bật tắt
local isFullBright = false

-- Toggle Full Bright
Misc:AddToggle("FullBrightToggle", {
    Title = "Full Bright",
    Default = false,
    Callback = function(state)
        isFullBright = state

        -- Nếu tắt thì khôi phục lại Lighting mặc định
        if not state then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.FogEnd = 1000
            Lighting.GlobalShadows = true
        end
    end
})

-- Hàm chạy mỗi frame
RunService.RenderStepped:Connect(function()
    if isFullBright then
        Lighting.Brightness = 10
        Lighting.ClockTime = 12
        Lighting.FogEnd = 1e10
        Lighting.GlobalShadows = false
    end
end)



-- Biến để lưu trạng thái của toggle
local isTeleportEnabled = false  

-- Thêm toggle vào tab Misc
Misc:AddToggle("TeleportToggle", {
    Title = "Click to teleport",   -- Tiêu đề của Toggle
    Default = false,  -- Trạng thái mặc định (tắt)
    Callback = function(state)
        isTeleportEnabled = state  -- Lưu trạng thái của toggle
        if isTeleportEnabled then
            print("Teleport Enabled")
        else
            print("Teleport Disabled")
        end
    end
})

-- Lấy đối tượng LocalPlayer và Mouse
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- Đảm bảo rằng có GUI và nhân vật đã được tải
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- Hàm xử lý khi click chuột trái
mouse.Button1Down:Connect(function()
    -- Kiểm tra xem teleport có được bật không
    if isTeleportEnabled then
        -- Lấy vị trí click chuột
        local clickPosition = mouse.Hit.p
        
        -- Dịch chuyển nhân vật đến vị trí click (thêm chút cao hơn để tránh vướng mặt đất)
        humanoidRootPart.CFrame = CFrame.new(clickPosition + Vector3.new(0, 2, 0))
    end
end)

local Players = game:GetService("Players")
local player = Players.LocalPlayer


-- Hàm cập nhật zoom khi bật toggle
local function updateZoom(state)
    if state then
        player.CameraMinZoomDistance = 0 -- ✅ thay vì 0.5 như trước
        player.CameraMaxZoomDistance = math.huge
    end
end

-- Đảm bảo thiết lập lại khi respawn
player.CharacterAdded:Connect(function()
    if player:GetAttribute("ZoomEnabled") then
        updateZoom(true)
    end
end)

-- Toggle trong UI
Misc:AddToggle("camera_zoom_toggle", {
    Title = "Camera Is Not Locked",
    Default = false,
    Callback = function(state)
        player:SetAttribute("ZoomEnabled", state)
        updateZoom(state)
    end
})

-- Thiết lập ban đầu
if player.Character then
    updateZoom(true)
end

local Players = game:GetService("Players")
local player = Players.LocalPlayer


-- Lưu giá trị gốc mặc định trước khi chỉnh
local defaultMaxZoom = player.CameraMaxZoomDistance

Misc:AddToggle("unlimited_zoom_toggle", {
    Title = "Infinite Zoom",
    Default = false,
    Callback = function(state)
        if state then
            player.CameraMaxZoomDistance = math.huge
        else
            player.CameraMaxZoomDistance = defaultMaxZoom
        end
    end
})














tabs.Joinid:AddInput("Input", {
    Title = "Job ID",
    Default = "",
    Placeholder = "Paste Job ID Here",
    Numeric = false,
    Finished = false,
    Callback = function(Value)
        _G.Job = Value
    end
})
tabs.Joinid:AddButton({
    Title="Join",
    Description="",
    Callback=function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.placeId,_G.Job, game.Players.LocalPlayer)
    end
})
tabs.Joinid:AddButton({
    Title="Copy Job ID",
    Description="",
    Callback=function()
        setclipboard(tostring(game.JobId))
    end
})
local Toggle = tabs.Joinid:AddToggle("MyToggle", {Title="Spam Tham Gia Job ID", Default=false })
Toggle:OnChanged(function(Value)
_G.Join=Value
    end)
    spawn(function()
while wait() do
if _G.Join then
game:GetService("TeleportService"):TeleportToPlaceInstance(game.placeId,_G.Job, game.Players.LocalPlayer)
end
end
end)


tabs.Joinid:AddButton({
Title = "Rejoin Server",
Description = "",
Callback = function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
end
})

tabs.Joinid:AddButton({
Title = "Hop Low Server",
Description = "",
Callback = function()
    getgenv().AutoTeleport = true
    getgenv().DontTeleportTheSameNumber = true 
    getgenv().CopytoClipboard = false
    if not game:IsLoaded() then
        print("Game is loading waiting...")
    end
    local maxplayers = math.huge
    local serversmaxplayer;
    local goodserver;
    local gamelink = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100" 
    function serversearch()
        for _, v in pairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync(gamelink)).data) do
            if type(v) == "table" and v.playing ~= nil and maxplayers > v.playing then
                serversmaxplayer = v.maxPlayers
                maxplayers = v.playing
                goodserver = v.id
            end
        end       
    end
    function getservers()
        serversearch()
        for i,v in pairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync(gamelink))) do
            if i == "nextPageCursor" then
                if gamelink:find("&cursor=") then
                    local a = gamelink:find("&cursor=")
                    local b = gamelink:sub(a)
                    gamelink = gamelink:gsub(b, "")
                end
                gamelink = gamelink .. "&cursor=" ..v
                getservers()
            end
        end
    end 
    getservers()
    if AutoTeleport then
        if DontTeleportTheSameNumber then 
            if #game:GetService("Players"):GetPlayers() - 4  == maxplayers then
                return warn("It has same number of players (except you)")
            elseif goodserver == game.JobId then
                return warn("Your current server is the most empty server atm") 
            end
        end
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, goodserver)
    end
end
})

tabs.Joinid:AddButton({
Title = "Hop Server",
Description = "",
Callback = function()
    local HttpService = game:GetService("HttpService")
    local TPS = game:GetService("TeleportService")
    
    -- Kiểm tra nếu game có thể gửi request HTTP
    local success, response = pcall(function()
        return game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100")
    end)

    if not success then
        print("Không thể lấy danh sách server! Hãy kiểm tra HTTP Requests trong cài đặt game.")
        return
    end
    
    local Servers = HttpService:JSONDecode(response).data
    local AvailableServers = {}

    for _, v in pairs(Servers) do
        if v.playing < v.maxPlayers and v.id ~= game.JobId then
            table.insert(AvailableServers, v.id)
        end
    end

    if #AvailableServers > 0 then
        local RandomServer = AvailableServers[math.random(1, #AvailableServers)]
        
        -- Kiểm tra nếu TPS có thể teleport
        local teleportSuccess, teleportError = pcall(function()
            TPS:TeleportToPlaceInstance(game.PlaceId, RandomServer)
        end)

        if not teleportSuccess then
            print("Lỗi Teleport: " .. teleportError)
        end
    else
        print("Không tìm thấy server phù hợp!")
    end
end
})


tabs.Joinid:AddButton({
Title = "Id Sever",
Description = "",
Callback = function()
    Hop()
end
}) 







local Mainbf = tabs.Bloxfruit:AddSection("Main")---- Add mục Main 

Mainbf:AddButton({
    Title = "W azure",
    Description = "",
    Callback = function()   
        getgenv().Team = "Marines" --Marines Pirates
        getgenv().AutoLoad = true --Will Load Script On Server Hop
        getgenv().SlowLoadUi = false
        getgenv().ForceUseSilentAimDashModifier = false --Force turn on silent aim, if error then executor problem
        getgenv().ForceUseWalkSpeedModifier = true --Force turn on Walk Speed Modifier, if error then executor problem
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/3b2169cf53bc6104dabe8e19562e5cc2.lua"))()
    end
})

Mainbf:AddButton({
    Title = "Redz Hub",
    Description = "",
    Callback = function()  
        local Settings = {
            JoinTeam = "Pirates"; -- Pirates/Marines
            Translator = true; -- true/false
        }
        loadstring(game:HttpGet("https://raw.githubusercontent.com/newredz/BloxFruits/refs/heads/main/Source.luau"))()
    end
})
Mainbf:AddButton({
    Title = "Xero Hub",
    Description = "",
    Callback = function()
        getgenv().Team = "Marines"
    getgenv().Hide_Menu = false
    getgenv().Auto_Execute = false
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Xero2409/XeroHub/refs/heads/main/main.lua"))()  
    end
})    Mainbf:AddButton({
    Title = "Teddy Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/skibiditoiletgojo/Haidepzai/refs/heads/main/Teddy-FREMIUM"))() 
    end
})    Mainbf:AddButton({
    Title = "GreenZ Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaAnarchist/GreenZ-Hub/refs/heads/main/GreenZHub.lua"))()
    end
})    Mainbf:AddButton({
    Title = "Vxeze Hub",
    Description = "",
    Callback = function()
        getgenv().Language = "English" ---vetnamese
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Dex-Bear/Vxezehub/refs/heads/main/VxezeHubMain2"))()
    end
})    Mainbf:AddButton({
    Title = "Doramon Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/obfmoonsec/Masterhub/refs/heads/main/obf"))()
    end
})    Mainbf:AddButton({
    Title = "QuanTum Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Trustmenotcondom/QTONYX/refs/heads/main/QuantumOnyx.lua"))()
    end
})    Mainbf:AddButton({
    Title = "Vxeze Hub",
    Description = "",
    Callback = function()
        getgenv().Language = "English" -----vetnamese
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Dex-Bear/Vxezehub/refs/heads/main/VxezeHubMain2"))()
    end
})    Mainbf:AddButton({
    Title = "Zenith Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Efe0626/ZenithHub/refs/heads/main/Loader"))()  
    end
})    Mainbf:AddButton({
    Title = "Rubu Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/RubuRoblox/refs/heads/main/RubuBF"))()   
    end
})    Mainbf:AddButton({
    Title = "Alchemy Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://scripts.alchemyhub.xyz"))()
    end
})    Mainbf:AddButton({
    Title = "Bapred Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/BapRed/main/BapRedHub"))()  
    end
})    Mainbf:AddButton({
    Title = "Astral Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Overgustx2/Main/refs/heads/main/BloxFruits_25.html"))()   
    end
})    Mainbf:AddButton({
    Title = "Omg Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua"))()  
    end
})    Mainbf:AddButton({
    Title = "Volcano Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/wpisstestfprg/Volcano/refs/heads/main/VolcanoLocal.lua", true))()  
    end
})    Mainbf:AddButton({
    Title = "Kncrypt Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/3345-c-a-t-s-u-s/Kncrypt/refs/heads/main/sources/BloxFruit.lua"))()  
    end
})    Mainbf:AddButton({
    Title = "Hiru Hub",
    Description = "Need Key",
    Callback = function()
        getgenv().Team = "Pirates"
    loadstring(game:HttpGet("https://raw.githubusercontent.com/NGUYENVUDUY1/Source/main/HiruHub.lua"))()  
    end
})   Mainbf:AddButton({
    Title = "HoHo Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI"))()
    end
})    Mainbf:AddButton({
    Title = "BlueX Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Dev-BlueX/BlueX-Hub/refs/heads/main/Main.lua"))()      
    end
})    Mainbf:AddButton({
    Title = "Speed Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()    
    end
})    Mainbf:AddButton({
    Title = "Xeter Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/Loader/main/Xeter.lua"))()   
    end
})    Mainbf:AddButton({
    Title = "Ganteng",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/516a5669fc39b4945cd0609a08264505.lua"))()   
    end
})    Mainbf:AddButton({
    Title = "Cakka Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/UserDevEthical/Loadstring/main/CokkaHub.lua"))()   
    end
})
local Hopbf = tabs.Bloxfruit:AddSection("Hop Server")
Hopbf:AddButton({
    Title = "CutTay Hub Auto Pull Lever",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/a1498369f289af2671cca90085f23fb8.lua"))()  
    end
})    Hopbf:AddButton({
    Title = "Min Gamming Hop Boss",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/Min/refs/heads/main/MinHopBoss"))()
    end
})    Hopbf:AddButton({
    Title = "Teddy Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Teddyseetink/Haidepzai/refs/heads/main/TEDDYHUB-FREEMIUM"))()
    end
})

local Kaitunbf = tabs.Bloxfruit:AddSection("Kaitun")

Kaitunbf:AddButton({
    Title = "Kaitun Xero Hub",
    Description = "Need Key",
    Callback = function()
        -- Max level, godhuman, cdk, sgt
script_key = "" -- premium only, u can leave it blank if ur not
getgenv().Shutdown = false -- Turn on if u are farming bulk accounts
getgenv().Configs = {
    ["Team"] = "Marines",
    ["FPS Boost"] = {
        ["Enable"] = true,
        ["FPS Cap"] = 30,
    },
    ["Farm Boss Drops"] = {
        ["Enable"] = false,
        ["When x2 Exp Expired"] = false
    },
    ["Hop"] = { -- premium only
        ["Enable"] = true,
        ["Hop Find Tushita"] = true,
        ["Hop Find Valkyrie Helm"] = true,
        ["Hop Find Mirror Fractal"] = true,
        ["Hop Find Darkbeard"] = true, -- For skull guitar
        ["Hop Find Soul Reaper"] = true, -- For CDK
        ["Hop Find Mirage"] = true, -- For pull lever
        ["Find Fruit"] = true, -- Will find 1m+ fruit to unlock swan door to access third sea
    },
    ["Farm Mastery"] = {
        ["Enable"] = true,
        ["Farm Mastery Weapons"] = {"Sword", "Gun", "Blox Fruit"}, -- Blox Fruit, Gun (left -> right: High -> Low Priority)
        ["Swords To Farm"] = {"Cursed Dual Katana"},
        ["Guns To Farm"] = {"Skull Guitar"},
        ["Mastery Health (%)"] = 40 -- For Blox Fruit, Gun
    },
    ["Farm Config"] = {
        ["First Farm At Sky"] = true,
        ["Farm Bone Get x2 Exp"] = true
    },
    ["Trackstat"] = {
        ["Enable"] = false,
        ["Key"] = "", -- Get from xerohub.click
        ["Device"] = "test" -- u can put any name here
    },
    ["Auto Spawn rip_indra"] = true,
    ["Auto Spawn Dough King"] = true,
    ["Auto Pull Lever"] = true,
    ["Auto Collect Berry"] = true,
    ["Auto Evo Race"] = true,
    ["Awaken Fruit"] = true,
    ["Rainbow Haki"] = true,
    ["Hop Player Near"] = true,
    ["Skull Guitar"] = true,
    ["Cursed Dual Katana"] = true,
    ["Switch Melee"] = true,
    ["Eat Fruit"] = "", -- leave blank for none, put the fruit name like this example: Smoke Fruit, T-Rex Fruit, ...
    ["Snipe Fruit"] = "", -- leave blank for none, put the fruit name like this example: Smoke Fruit, T-Rex Fruit, ...
    ["Lock Fragment"] = 30000,
    ["Buy Stuffs"] = true -- buso, geppo, soru, ken haki, ...
}
repeat task.wait() pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Xero2409/XeroHub/refs/heads/main/kaitun.lua"))() end) until getgenv().Check_Execute  
    end
})    Kaitunbf:AddButton({
    Title = "Kaitun RoyX Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/Duym500/refs/heads/main/RoyX%20Kaitun"))()    
    end
})    Kaitunbf:AddButton({
    Title = "Kaitun Simple Hub",
    Description = "",
    Callback = function()
        getgenv().simple_settings = {
            ["MASTERY"] = { -- Settings related to leveling up weapon or skill mastery
                ["ACTIVE"] = true, -- Enable or disable mastery leveling (true = enabled, false = disabled)
                ["METHOD"] = "Half", -- Method for gaining mastery, "Half"[350] or "Full"[600]
            },
        
            ["RAID"] = {
                ["MODE"] = "Legit", -- Legit / KillAura (Legit mode is Mob aura in raid)
            },
        
            ["OBJECTIVE"] = { -- Goals for farming and unlocking features
                ["GODHUMAN"] = true, -- Automatically unlock the "Godhuman" fighting style
                ["RACE-CONFIGURE"] = {
                    ["RACE"] = {"Human", "Skypiea", "Fishman", "Mink"}, -- List -- "Human", "Skypiea", "Fishman", "Mink"
                    ["RACE-LOCK"] = true, -- Automatically change the character race if not in the list
                    ["RACE-V3"] = true, -- Automatically upgrade character race to V3 if possible Human, Mink, (Fishman, Ghoul, Cyborg) soon
                },
                ["FRAGMENT"] = 100000, -- Limit number of fragments to collect
        
                -- SWORD
                ["CANVANDER"] = true,
                ["BUDDY-SWORD"] = true,
                ["CURSED-DUAL-KATANA"] = true,
                ["SHARK-ANCHOR"] = true,
        
                --GUN
                ["ACIDUM-RIFLE"] = true,
                ["VENOM-BOW"] = true,
                ["SOUL-GUITAR"] = true,
        
                -- AURA
                ["COLOR-HAKI"] = {"Pure Red","Winter Sky","Snow White"}, -- Aura color to craft
            },
        
            ["FRUITPURCHASE"] = true, -- Automatically purchase fruits based on priority list
            ["PRIORITYFRUIT"] = { -- List of preferred fruits to purchase or eat in order of priority
                [1] = "Dragon-Dragon",
                [2] = "Dough-Dough",
                [3] = "Flame-Flame",
                [4] = "Rumble-Rumble",
                [5] = "Human-Human: Buddha",
                [6] = "Dark-Dark",
            },
        
            ["FPSCAP"] = 30, -- Limit the frame rate to optimize performance
            ["LOWTEXTURE"] = true -- Reduce graphic quality for better performance
        }
        loadstring(game:HttpGet("https://raw.githubusercontent.com/simple-hubs/contents/refs/heads/main/bloxfruit-kaitan-main.lua"))()
    end
})    Kaitunbf:AddButton({
    Title = "Kaitun Quartyz ( Mukuro Hub )",
    Description = "Need Key",
    Callback = function()
        getgenv().Mode = "OneClick"
getgenv().Setting = {
    ["Team"] = "Marines", -- Options "Pirates", "Marines"
    ["FucusOnLevel"] = true,
    ["Fruits"] = {  -- setting for fruits u want
        ["Primary"] = { -- if current fruit is not in this list, eat/buy
            "Dough-Dough",
            "Dragon-Dragon",
            "Buddha-Buddha",
            -- u can configs add mores/remove and must end with , (comma symbol)
        },
        ["Normal"] = { -- it just a normal fruit list
            "Flame-Flame",
            "Light-Light",
            "Magma-Magma",
            -- u can configs add mores/remove and must end with , (comma symbol)
        }
        -- run this for get all fruit name `local t={};for _,v in pairs(game.ReplicatedStorage.Remotes.CommF_:InvokeServer("GetFruits"))do table.insert(t,v.Name)end;setclipboard(table.concat(t, "\n"))`
    },
    ["Lock Fruits"] = { -- don't use or eat fruits in this list
        "Yeti-Yeti",
    },
    ["IdleCheck"] = 300, -- every (x) seconds if not moving rejoin
};

loadstring(game:HttpGet("https://raw.githubusercontent.com/xQuartyx/QuartyzScript/main/Loader.lua"))()    
    end
})    tabs.Bluelock:AddButton({
    Title = "Alchemy Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://scripts.alchemyhub.xyz"))()
    end
})    tabs.Bluelock:AddButton({
    Title = "Bill Dev",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/selciawashere/screepts/refs/heads/main/BLRTBDMOBILEKEYSYS",true))()
    end
})    tabs.Bluelock:AddButton({
    Title = "NS Hub",
    Description = "Need Key",
    Callback = function()
          
    end
})    tabs.Bluelock:AddButton({
    Title = "Lunor",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("loadstring(game:HttpGet('https://raw.githubusercontent.com/Just3itx/Lunor-Loadstrings/refs/heads/main/Loader'))()"))()
    end
})    tabs.Bluelock:AddButton({
    Title = "Omg Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/UPD-Blue-Lock:-Rivals-OMG-Hub-29091"))()
    end
})    tabs.Bluelock:AddButton({
    Title = "Arbix",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet(('https://pastefy.app/O3F7JYSF/raw'),true))()
    end
})    tabs.Bluelock:AddButton({
    Title = "Tbao Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/game/refs/heads/main/TbaoHubBlueLockRivals"))()
    end
})    tabs.Bluelock:AddButton({
    Title = "Style Need Reo",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/D1M2PLua", true))()
    end
})    tabs.Bluelock:AddButton({
    Title = "Inf Stamina",
    Description = "",
    Callback = function()
        local args = {
            [1] = 0/0
        }
        
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StaminaService"):WaitForChild("RE"):WaitForChild("DecreaseStamina"):FireServer(unpack(args))  
    end
})    tabs.Bluelock:AddButton({
    Title = "Auto Slide, Dribble",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Maybie/BlueLock/refs/heads/main/BLR.lua',true))()
    end
})    tabs.Bluelock:AddButton({
    Title = "Sterling",
    Description = "",
    Callback = function()
        local GuiService = game:GetService("GuiService")
    local Players = game:GetService("Players")
    local TeleportService = game:GetService("TeleportService")
    local player = Players.LocalPlayer
    local function onerrorMessageChanged(errorMessage)
        if errorMessage and errorMessage ~= "" then
            print("Error detected: " .. errorMessage)
            if player then
                wait()
                TeleportService:Teleport(game.PlaceId, player)
            end
        end
    end
    GuiService.ErrorMessageChanged:Connect(onerrorMessageChanged)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Zayn31214/name/refs/heads/main/SterlingNew"))()  
    end
})    tabs.Bluelock:AddButton({
    Title = "Over Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet('https://api.overhub.xyz/keys/script/overhub'))()
    end
})    tabs.Bluelock:AddButton({
    Title = "Imp Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/alan11ago/Hub/refs/heads/main/ImpHub.lua"))()
    end
})    tabs.Bluelock:AddButton({
    Title = "Ronix Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/c84ecefd7fa63a35d454d3ecefe3ee7e.lua"))()
    end
})    tabs.Fisch:AddButton({
    Title = "Deng Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/DENGHUB2025/HUGHUB/main/WL", true))()
    end
})    tabs.Fisch:AddButton({
    Title = "Londne",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/londnee/code/refs/heads/main/Fisch.lua"))()
    end
})    tabs.Fisch:AddButton({
    Title = "Naoki Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://naokihub.vercel.app",true))()
    end
})    tabs.Fisch:AddButton({
    Title = "Kiciahook",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/kiciahook/kiciahook/refs/heads/main/loader.lua"))()
    end
})   tabs.Fisch:AddButton({
    Title = "Solix Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/Solixreworkkeysystem/refs/heads/main/solix%20new%20keyui.lua"))()
    end
})    tabs.Fisch:AddButton({
    Title = "Raito Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Efe0626/RaitoHub/refs/heads/main/Script"))()
    end
})    tabs.Fisch:AddButton({
    Title = "Ronix Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/e4d72046eb884e9c01333d3e704fc2d7.lua"))()
    end
})    tabs.Fisch:AddButton({
    Title = "Krcrypt Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/3345-c-a-t-s-u-s/Kncrypt/refs/heads/main/sources/Fisch.lua"))()
    end
})    tabs.Petgo:AddButton({
    Title = "NS Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/OhhMyGehlee/go/refs/heads/main/is"))()
    end
})    tabs.Petgo:AddButton({
    Title = "Zap Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet('https://zaphub.xyz/Exec'))()
    end
})    tabs.Petgo:AddButton({
    Title = "Speed Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
    end
})    tabs.Deedrails:AddButton({
    Title = "NomDom Hub (Beta)",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/CodeNoMaHoa/refs/heads/main/NomDomDeedRails.lua"))()  
    end
})    tabs.Deedrails:AddButton({
    Title = "Tp All Map By Jonas",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/JonasThePogi/DeadRails/refs/heads/main/newloadstring"))()  
    end
})    tabs.Deedrails:AddButton({
    Title = "Tbao Hub (Main)",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/thaibao/refs/heads/main/TbaoHubDeadRails"))()  
    end
})    tabs.Deedrails:AddButton({
    Title = "Tbao Hub (Tp Map)",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/game/refs/heads/main/TbaoHubDeadRailsTp"))()  
    end
})    tabs.Deedrails:AddButton({
    Title = "Tbao Hub (Fram Bond)",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/game/refs/heads/main/TbaoHubDeadRailsFarm"))()  
    end
})    tabs.Deedrails:AddButton({
    Title = "Tn Hub (Fram Bond)",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/thiennrb7/Script/refs/heads/main/autobond"))()  
    end
})    tabs.Deedrails:AddButton({
    Title = "Npc Lock",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/s542AG7U/raw"))()  
    end
})    tabs.Deedrails:AddButton({
    Title = "Increase Hitbox + Aim lock",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/o4SV2jjx/raw"))()  
    end
})    tabs.Deedrails:AddButton({
    Title = "No Clip + Esp",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/refs/heads/main/DeadRails", true))()
    end
})    tabs.Deedrails:AddButton({
    Title = "Auto Fram Bond",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Marco8642/science/refs/heads/ok/dead%20rails"))()
    end
})    tabs.Deedrails:AddButton({
    Title = "Skull Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet('https://skullhub.xyz/loader.lua'))()
    end
})    tabs.Deedrails:AddButton({
    Title = "DHHz Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ducknovis/DHHz-hub/refs/heads/main/Dead-Rails.lua"))()  
    end
})    tabs.Deedrails:AddButton({
    Title = "Deed Rails",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/thiennrb7/Script/refs/heads/main/Bringall"))()
    end
})    tabs.Deedrails:AddButton({
    Title = "Speed Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
    end
})    tabs.Deedrails:AddButton({
    Title = "Null Fire",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/InfernusScripts/Null-Fire/main/Loader"))()
    end
})    tabs.Deedrails:AddButton({
    Title = "Solix Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/Solixreworkkeysystem/refs/heads/main/solix%20new%20keyui.lua"))()
    end
})    tabs.Deedrails:AddButton({
    Title = "Neox Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/hassanxzayn-lua/NEOXHUBMAIN/refs/heads/main/loader", true))()
    end
})    tabs.Deedrails:AddButton({
    Title = "Ronix Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/672a0ae340e8ce7e21a51e37c6bf0cc1.lua"))()
    end
})    tabs.Deedrails:AddButton({
    Title = "Spider Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/SpiderScriptRB/Dead-Rails-SpiderXHub-Script/refs/heads/main/SpiderXHub%202.0.txt"))()
    end
})    tabs.Deedrails:AddButton({
    Title = "Auto Bond Fake",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Emplic/deathrails/refs/heads/main/bond"))()
    end
})    tabs.Deedrails:AddButton({
    Title = "Vehicle Fly",
    Description = "",
    Callback = function()
        Loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Vehicle%20Fly%20Gui'))()
    end
})    tabs.Arisecrossover:AddButton({
    Title = "Arise Crossover By Perfectus",
    Description = "Not sure if there is a key or not",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Arise-Crossover-Keyless-Script-33926"))()
    end
})    tabs.Arisecrossover:AddButton({
    Title = "Twvz",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ZhangJunZ84/twvz/refs/heads/main/arisecrossover.lua"))()
    end
})    tabs.Arisecrossover:AddButton({
    Title = "Almechy Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://scripts.alchemyhub.xyz"))()
    end
})    tabs.Arisecrossover:AddButton({
    Title = "Elgato",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/meobeo8/elgato/a/Loader"))()
    end
})    tabs.Arisecrossover:AddButton({
    Title = "Skull Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet('https://skullhub.xyz/loader.lua'))()
    end
})    tabs.Arisecrossover:AddButton({
    Title = "Arise Crossover",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/refs/heads/main/AriseCrossover"))()
    end
})    tabs.Arisecrossover:AddButton({
    Title = "Omg Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/OhhMyGehlee/y/refs/heads/main/hj"))()
    end
})    tabs.Arisecrossover:AddButton({
    Title = "Sky Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/SKOIXLL/SKYLOLAND/refs/heads/main/Load.lua"))()
    end
})    tabs.Arisecrossover:AddButton({
    Title = "Gentle Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GentleScriptHub/GentleHub/refs/heads/main/Games"))()
    end
})    tabs.Arisecrossover:AddButton({
    Title = "Speed Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
    end
})    tabs.Volleyball:AddButton({
    Title = "Sterling Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Zayn31214/name/refs/heads/main/SterlingNew"))() 
    end
})    tabs.Volleyball:AddButton({
    Title = "Waiting for more script...",
    Description = "",
    Callback = function()
        
    end
})    tabs.Basketball:AddButton({
    Title = "Control Ball",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/RedJDark/CONTROL-SCRIPTT/refs/heads/main/CONTROL"))()
    end
})    tabs.Basketball:AddButton({
    Title = "Waiting for more script...",
    Description = "",
    Callback = function()
        
    end
})    tabs.Tsb:AddButton({
    Title = "Beecon Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BaconBossScript/BeeconHub/main/BeeconHub"))() 
    end
})    tabs.Tsb:AddButton({
    Title = "Phantasm",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ATrainz/Phantasm/refs/heads/main/Phantasm.lua"))()
    end
})    tabs.Tsb:AddButton({
    Title = "Speed Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
    end
})    tabs.Mm2:AddButton({
    Title = "Foggy Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/FOGOTY/mm2-piano-reborn/refs/heads/main/scr"))()
    end
})    tabs.Mm2:AddButton({
    Title = "XHub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Au0yX/Community/main/XhubMM2"))() 
    end
})    tabs.Rivals:AddButton({
    Title = "Ronix Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/e945f55997c4240abc865c0bcc2136c5.lua"))()
    end
})    tabs.Rivals:AddButton({
    Title = "Soluna",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://soluna-script.vercel.app/main.lua",true))()
    end
})

local Script = tabs.Misc:AddSection("Script")

    Script:AddButton({
    Title = "Fly",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/NomDomOnTop/refs/heads/main/NomDomFly"))()
    end
})    Script:AddButton({
    Title = "Test Unc",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/NomDomOnTop/refs/heads/main/UncTest"))()
    end
})    Script:AddButton({
    Title = "Fix Lag 50%",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/NomDomOnTop/refs/heads/main/FixLag"))()
    end
})    Script:AddButton({
    Title = "Fix Lag 100%",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/NomDomOnTop/refs/heads/main/SuperFixLag"))()
    end
})

local Player = tabs.Misc:AddSection("Player")

Player:AddButton({
    Title = "Reset Character",
    Description = "",
    Callback = function()
        local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:FindFirstChildWhichIsA("Humanoid")

if humanoid then
    humanoid.Health = 0
end
    end
})    Player:AddButton({
    Title = "Kick Player",
    Description = "",
    Callback = function()
        game.Players.LocalPlayer:Kick("")
    end
})

local Screen = tabs.Misc:AddSection("Screen")

local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local Buoi = false
local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = Lighting

Screen:AddToggle("BuoiToggle", {
    Title = "Blurry Screen",
    Default = false,
    Callback = function(state)
        Buoi = state
    end
})

-- Liên tục áp dụng hiệu ứng
spawn(function()
    while task.wait() do
        if Buoi then
            blur.Size = 30
        else
            blur.Size = 0
        end
    end
end)
local Buoi = false

Screen:AddToggle("BuoiToggle", {
    Title = "White Screen", -- Tên hiển thị trong UI
    Default = false,
    Callback = function(state)
        Buoi = state
    end
})

-- Chạy ẩn để liên tục kiểm tra trạng thái
spawn(function()
    while task.wait() do
        game:GetService("RunService"):Set3dRenderingEnabled(not Buoi)
    end
end)

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local Buoi = false

-- Tạo ScreenGui + Frame đen nếu chưa có
local gui = Instance.new("ScreenGui")
gui.Name = "BuoiOverlay"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = PlayerGui

local blackOverlay = Instance.new("Frame")
blackOverlay.Size = UDim2.new(1, 0, 1, 0)  -- Lấp đầy toàn bộ màn hình
blackOverlay.BackgroundColor3 = Color3.new(0, 0, 0)  -- Màu đen
blackOverlay.BackgroundTransparency = 0  -- Không trong suốt, đen hoàn toàn
blackOverlay.Visible = false  -- Mặc định là không hiển thị
blackOverlay.Parent = gui

-- Toggle
Screen:AddToggle("BuoiToggle", {
    Title = "Black Screen",
    Default = false,
    Callback = function(state)
        Buoi = state
        blackOverlay.Visible = state  -- Hiển thị hoặc ẩn màn hình đen
    end
})





-- Giao diện Nút Mở UI (đẹp hơn, có particle, xoay, animation)
local TweenService = game:GetService("TweenService")

local gui = Instance.new("ScreenGui")
gui.Name = "ToggleUIFluent"
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = game:GetService("CoreGui")

local button = Instance.new("ImageButton")
button.Size = UDim2.new(0, 50, 0, 50)
button.Position = UDim2.new(0.120833337 - 0.1, 0, 0.0952890813 + 0.01, 0)
button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
button.BorderSizePixel = 0
button.Image = "http://www.roblox.com/asset/?id=138569547227924"
button.Draggable = true
button.Parent = gui

-- Bo góc
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = button

-- Particle hiệu ứng
local particle = Instance.new("ParticleEmitter")
particle.Parent = button
particle.LightEmission = 1
particle.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(1, 0) })
particle.Lifetime = NumberRange.new(0.5, 1)
particle.Rate = 0
particle.Speed = NumberRange.new(5, 10)
particle.SpreadAngle = Vector2.new(360, 360)
particle.Color = ColorSequence.new(Color3.fromRGB(255, 85, 255), Color3.fromRGB(85, 255, 255))

-- Khi bấm nút
button.MouseButton1Down:Connect(function()
    particle.Rate = 100

    -- Reset sau 1s
    task.delay(1, function()
        particle.Rate = 0
    end)


    -- Gửi phím End để bật/tắt UI
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.End, false, game)
end)

-- Xoá hiệu ứng chết/respawn nếu có
local effectContainer = game:GetService("ReplicatedStorage"):FindFirstChild("Effect") and game:GetService("ReplicatedStorage").Effect:FindFirstChild("Container")
if effectContainer then
    if effectContainer:FindFirstChild("Death") then
        effectContainer.Death:Destroy()
    end
    if effectContainer:FindFirstChild("Respawn") then
        effectContainer.Respawn:Destroy()
    end
end


-- Thông báo chào người chơi
Fluent:Notify({
    Title = "Welcome, " .. game.Players.LocalPlayer.Name,
    Content = "Use script fun",
    Duration = 5
})

wait(1)

-- Thông báo khi tải xong
Fluent:Notify({
    Title = "Script By NomCak Team",
    Content = "Partner with us?",
    Duration = 5
})

Wait(0.5)

-- Thông báo Discord
Fluent:Notify({
    Title = "If you want then go to discord",
    Content = "https://discord.gg/3PpjA9Ts",
    Duration = 5
})
