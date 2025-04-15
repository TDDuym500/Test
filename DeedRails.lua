-- 🧠 Tải thư viện UI Fluent
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/UiHack/refs/heads/main/Fluent"))()
local window = Fluent:CreateWindow({
    Title = "NomDom | Deed Rails",
    SubTitle = "by Duy",
    TabWidth = 230,
    Theme = "Dark",
    Acrylic = false,
    Size = UDim2.fromOffset(700, 490),
    MinimizeKey = Enum.KeyCode.End
})

-- 🌟 Tạo tab Main
local tabs = {
    Main = window:AddTab({ Title = "Main" }),
}

-----------------------------
-- ✅ Auto TP To Win
-----------------------------
local teleporting = false
local targetCFrame = CFrame.new(-423.95, 27.39, -49039.65)

tabs.Main:AddToggle("AutoTpWin", {
    Title = "Auto TP To Win",
    Description = "Dịch chuyển liên tục để tránh bị giật về",
    Default = false,
    Callback = function(state)
        teleporting = state
        if teleporting then
            task.spawn(function()
                while teleporting do
                    local player = game.Players.LocalPlayer
                    local character = player.Character or player.CharacterAdded:Wait()
                    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                    if humanoidRootPart then
                        humanoidRootPart.CFrame = targetCFrame
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
})

-----------------------------
-- ✅ Tăng Hitbox Quái
-----------------------------
local hitboxEnabled = false
local hitboxSize = Vector3.new(30, 30, 30)

tabs.Main:AddInput("HitboxSizeInput", {
    Title = "Hitbox Quái",
    Default = "30",
    Placeholder = "VD: 100",
    Callback = function(input)
        local number = tonumber(input)
        if number then
            hitboxSize = Vector3.new(number, number, number)
            print("✅ Đặt hitbox: " .. tostring(hitboxSize))
            if hitboxEnabled then
                local enemyFolder = workspace:FindFirstChild("Enemies") or workspace:FindFirstChild("Enemy") or workspace
                for _, enemy in ipairs(enemyFolder:GetChildren()) do
                    if enemy:IsA("Model") and enemy:FindFirstChild("HumanoidRootPart") then
                        enemy.HumanoidRootPart.Size = hitboxSize
                    end
                end
            end
        else
            warn("⛔ Nhập số hợp lệ!")
        end
    end
})

tabs.Main:AddToggle("ToggleHitbox", {
    Title = "Bật/Tắt Hitbox Quái",
    Description = "Tăng size HRP của quái",
    Default = false,
    Callback = function(state)
        hitboxEnabled = state
        local enemyFolder = workspace:FindFirstChild("Enemies") or workspace:FindFirstChild("Enemy") or workspace
        for _, enemy in ipairs(enemyFolder:GetChildren()) do
            if enemy:IsA("Model") and enemy:FindFirstChild("HumanoidRootPart") then
                local hrp = enemy.HumanoidRootPart
                if state then
                    hrp.Size = hitboxSize
                    hrp.Transparency = 0.9
                    hrp.Material = Enum.Material.Neon
                    hrp.BrickColor = BrickColor.new("Really black")
                    hrp.CanCollide = false
                else
                    hrp.Size = Vector3.new(4, 4, 4)
                    hrp.Transparency = 1
                end
            end
        end
    end
})

-----------------------------
-- ✅ Aimbot vào đầu Quái
-----------------------------
local aimbotEnabled = false
local aimbotRadius = 150

tabs.Main:AddInput("AimbotRadius", {
    Title = "Bán kính Aimbot",
    Default = "150",
    Placeholder = "VD: 200",
    Callback = function(input)
        local number = tonumber(input)
        if number then
            aimbotRadius = number
        else
            warn("⛔ Nhập bán kính hợp lệ!")
        end
    end
})

tabs.Main:AddToggle("ToggleAimbot", {
    Title = "Bật/Tắt Aimbot Quái",
    Description = "Tự động xoay camera về đầu quái gần nhất",
    Default = false,
    Callback = function(state)
        aimbotEnabled = state
        if state then
            task.spawn(function()
                while aimbotEnabled do
                    local player = game.Players.LocalPlayer
                    local character = player.Character
                    local camera = workspace.CurrentCamera
                    if not character or not camera then continue end

                    local closestEnemy = nil
                    local shortestDistance = aimbotRadius
                    local enemyFolder = workspace:FindFirstChild("Enemies") or workspace:FindFirstChild("Enemy") or workspace
                    for _, enemy in ipairs(enemyFolder:GetChildren()) do
                        if enemy:IsA("Model") and enemy:FindFirstChild("Head") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                            local distance = (enemy.Head.Position - camera.CFrame.Position).Magnitude
                            if distance < shortestDistance then
                                closestEnemy = enemy
                                shortestDistance = distance
                            end
                        end
                    end

                    if closestEnemy then
                        camera.CFrame = CFrame.new(camera.CFrame.Position, closestEnemy.Head.Position)
                    end
                    task.wait(0.05)
                end
            end)
        end
    end
})
