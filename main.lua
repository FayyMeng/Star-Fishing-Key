if not game:GetService("Players").LocalPlayer then return end


local function sendWebhook()
    local Player = game:GetService("Players").LocalPlayer
    local HttpService = game:GetService("HttpService")
    
    local data = {
        ["content"] = "",
        ["embeds"] = {{
            ["title"] = "🔥 FayyScript Executed",
            ["color"] = 16711680,
            ["fields"] = {
                {["name"] = "Username", ["value"] = "```" .. Player.Name .. "```", ["inline"] = true},
                {["name"] = "User ID", ["value"] = "```" .. Player.UserId .. "```", ["inline"] = true},
                {["name"] = "Server ID", ["value"] = "```" .. game.JobId .. "```", ["inline"] = false},
                {["name"] = "Display Name", ["value"] = "```" .. Player.DisplayName .. "```", ["inline"] = true},
                {["name"] = "Account Age", ["value"] = "```" .. Player.AccountAge .. " days```", ["inline"] = true}
            },
            ["footer"] = {["text"] = "FayyScript Logger"},
            ["timestamp"] = DateTime.now():ToIsoDate()
        }}
    }
    
    local jsonData = HttpService:JSONEncode(data)
    local url = "https://discord.com/api/webhooks/1473484320240046091/9kPqExnI2UQdm-ZjF7ykwnXyhxdVTjEkda64fdrnJnr-DZo7sLip8tNlpS43D9YIjIpe"
    
    pcall(function() HttpService:PostAsync(url, jsonData, Enum.HttpContentType.ApplicationJson) end)
    pcall(function() syn and syn.request({Url=url, Method="POST", Headers={["Content-Type"]="application/json"}, Body=jsonData}) end)
    pcall(function() request and request({Url=url, Method="POST", Headers={["Content-Type"]="application/json"}, Body=jsonData}) end)
end

xpcall(sendWebhook, function() end)

-- ===== ENCHANT DATA =====
local EnchantData = {
    RarityNames = {
        {name = "Common", color = Color3.fromRGB(255, 255, 255)},
        {name = "Rare", color = Color3.fromRGB(111, 221, 255)},
        {name = "Epic", color = Color3.fromRGB(177, 108, 255)},
        {name = "Legendary", color = Color3.fromRGB(255, 185, 65)},
        {name = "Mythical", color = Color3.fromRGB(255, 102, 102)}
    };
    Enchants = {
        {id = "heavy", name = "Heavy", rarity = 1},
        {id = "sweep", name = "Sweeping", rarity = 1},
        {id = "sharp", name = "Sharp", rarity = 1},
        {id = "swift", name = "Swift", rarity = 1},
        {id = "poison", name = "Toxic", rarity = 2},
        {id = "flame", name = "Flaming", rarity = 2},
        {id = "glitch", name = "Glitch", rarity = 2},
        {id = "vampire", name = "Vampirism", rarity = 3},
        {id = "cull", name = "Culling", rarity = 3},
        {id = "overdrive", name = "Overdrive", rarity = 3},
        {id = "divinesmite", name = "Divine Smite", rarity = 4},
        {id = "radioactive", name = "Radioactive", rarity = 5},
        {id = "storm", name = "Storm", rarity = 5}
    }
}

-- ===== KEY SYSTEM WITH AUTO SKIP =====
local CORRECT_KEY = "UpdateLootUp"
local SPECIAL_USER_ID = "1417352153"
local Player = game:GetService("Players").LocalPlayer

local function isSpecialUser()
    return tostring(Player.UserId) == SPECIAL_USER_ID
end

local function loadMainScript()
    -- Load WindUI dengan aman
    local success, result = pcall(function()
        return loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
    end)
    if not success or not result then
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Error", Text = "Gagal load WindUI: " .. tostring(result), Duration = 5})
        return
    end
    
    local WindUI
    if type(result) == "function" then
        local uiSuccess, uiResult = pcall(result)
        if uiSuccess and uiResult then
            WindUI = uiResult
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Error", Text = "Gagal init WindUI", Duration = 5})
            return
        end
    elseif type(result) == "table" and result.CreateWindow then
        WindUI = result
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Error", Text = "WindUI format tidak dikenal", Duration = 5})
        return
    end

    local Window = WindUI:CreateWindow({
        Title = "FayyScript",
        Icon = "swords",
        Author = "FayyScript",
        Folder = "FayyDark",
        Size = UDim2.fromOffset(620, 500),
        Transparent = true,
        Theme = "Dark",
        Resizable = true,
        SideBarWidth = 210,
    })

    local Services = {
        Players = game:GetService("Players"),
        RunService = game:GetService("RunService"),
        VirtualInput = game:GetService("VirtualInputManager"),
        ReplicatedStorage = game:GetService("ReplicatedStorage"),
        HttpService = game:GetService("HttpService"),
        TweenService = game:GetService("TweenService")
    }

    local Network = Services.ReplicatedStorage:WaitForChild("Net")
    local LocalPlayer = Services.Players.LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

    local Connections = {}
    local function SafeConnect(event, func)
        if typeof(event) == "Instance" and event:IsA("RemoteEvent") then
            event = event.OnClientEvent
        end
        local conn = event:Connect(func)
        table.insert(Connections, conn)
        return conn
    end

    local function CleanConnections()
        for _, conn in ipairs(Connections) do
            pcall(function() conn:Disconnect() end)
        end
        Connections = {}
    end

    SafeConnect(Services.Players.LocalPlayer.CharacterAdded, function(newChar)
        Character = newChar
        HumanoidRootPart = newChar:WaitForChild("HumanoidRootPart")
    end)

    local Settings = {
        FarmEnabled = false, BossName = "", MobName = "", Distance = 5, Height = 2,
        Skill1 = false, Skill2 = false,
        ForgeEnabled = false, ForgeDelay = 0.8,
        InstantForge = false,
        InstantForgeLoops = 10,
        InstantForgeSpeed = 0.001,
        CapturedID = nil,
        ItemIndex = "", CustomAmount = 0, DupeMode = "fast",
        AutoCollectDrop = false,
        AutoClick = false, ClickDelay = 100,
        WalkSpeedEnabled = false, WalkSpeed = 16,
        AutoReroll = false,
        AutoAttack = false,
        RerollDelay = 0.1,
        AttackDelay = 0.1,
        ScriptRunning = true,
        LastFarmCheck = 0,
        LastForgeCheck = 0,
        TargetCache = nil,
        EnemyCache = {},
        OriginalWalkSpeed = 16,
        FarmThread = nil,
        ClickThread = nil,
        ForgeThread = nil,
        WalkSpeedThread = nil,
        -- Auto Enchant Settings
        EnchantCapturedID = nil,
        AutoEnchant = false,
        EnchantDelay = 0.8,
        EnchantStoneType = "st_2",
        EnchantThread = nil,
        LastEnchantCheck = 0,
        EnchantCount = 0,
        TargetEnchantId = nil,
        StopOnTarget = false,
    }

    if Character and Character:FindFirstChild("Humanoid") then
        Settings.OriginalWalkSpeed = Character.Humanoid.WalkSpeed
    end

    local TeleportLocations = {
        World1 = CFrame.new(-125.344933, -84.8785095, 182.019699, 0.994084299, 3.32440244e-08, -0.108611502, -4.06600016e-08, 1, -6.60652333e-08, 0.108611502, 7.00905574e-08, 0.994084299),
        World2 = CFrame.new(-6105.6001, -77.5193481, 22.7999992, 1, 3.32962351e-08, -5.53783907e-14, -3.32962351e-08, 1, -5.87553792e-08, 5.34220563e-14, 5.87553792e-08, 1),
        World3 = CFrame.new(-795.700012, -53.6313896, 7150.2998, -0.0678714439, 8.02689897e-08, 0.997694075, 6.12998079e-08, 1, -7.62843939e-08, -0.997694075, 5.5980923e-08, -0.0678714439),
        World4 = CFrame.new(2568.80005, -353.311066, 128.699997, 0.903551757, -1.6607336e-08, -0.428478926, 1.99697112e-08, 1, 3.3521641e-09, 0.428478926, -1.15854544e-08, 0.903551757)
    }

    local function GetEnemies(isBoss)
        local list = {"None"}
        local seen = {}
        local bossNames = {["Mage of Darkness"] = true, ["Bear"] = true, ["Yeti"] = true, ["Dragon"] = true, ["Heartbreaker"] = false}
        if not workspace:FindFirstChild("Enemies") then 
            Settings.EnemyCache = {}
            return list 
        end
        local now = tick()
        if now - Settings.LastFarmCheck > 2 or #Settings.EnemyCache == 0 then
            Settings.EnemyCache = {}
            for _, v in pairs(workspace.Enemies:GetChildren()) do
                if v:FindFirstChild("HumanoidRootPart") then
                    local hum = v:FindFirstChildOfClass("Humanoid")
                    if not hum or hum.Health > 0 then
                        table.insert(Settings.EnemyCache, v)
                    end
                end
            end
            Settings.LastFarmCheck = now
        end
        for _, v in ipairs(Settings.EnemyCache) do
            if not seen[v.Name] then
                local isBossEnemy = bossNames[v.Name] or false
                if isBoss then
                    if isBossEnemy then table.insert(list, v.Name) end
                else
                    if not isBossEnemy then table.insert(list, v.Name) end
                end
                seen[v.Name] = true
            end
        end
        return list
    end

    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Knit = ReplicatedStorage:FindFirstChild("Knit")
    if not Knit then Knit = ReplicatedStorage:WaitForChild("Knit", 3) end
    local ServicesFolder = Knit and Knit:FindFirstChild("Services")

    -- Enchant remote
    local EnchantRemote = Network:WaitForChild("Events"):WaitForChild("Enchant")
    local GetExistsRemote = Network:WaitForChild("Functions"):WaitForChild("GetExists")

    -- ===== ENCHANT HELPER FUNCTIONS =====
    local function GetEnchantById(id)
        for _, enchant in ipairs(EnchantData.Enchants) do
            if enchant.id == id then return enchant end
        end
        return nil
    end

    local function GetEnchantList()
        local list = {"None"}
        for _, enchant in ipairs(EnchantData.Enchants) do
            table.insert(list, enchant.name .. " [" .. EnchantData.RarityNames[enchant.rarity].name .. "]")
        end
        return list
    end

    local function GetEnchantIdFromDisplay(displayName)
        if displayName == "None" then return nil end
        for _, enchant in ipairs(EnchantData.Enchants) do
            local fullName = enchant.name .. " [" .. EnchantData.RarityNames[enchant.rarity].name .. "]"
            if fullName == displayName then return enchant.id end
        end
        return nil
    end

    local function GetCurrentEnchant()
        if not Settings.EnchantCapturedID then return nil end
        local weaponId = string.match(Settings.EnchantCapturedID, "_(%d+)$")
        if not weaponId then return nil end
        local success, result = pcall(function()
            return GetExistsRemote:InvokeServer("w_" .. weaponId)
        end)
        if success and result and result.enchant then
            return result.enchant
        end
        return nil
    end

    -- ===== ENCHANT HOOK (mirip forge hook) =====
    local enchantHookActive = false
    local enchantHookTimeout = nil
    local enchantOldNamecall = nil

    local function RemoveEnchantHook()
        if enchantOldNamecall then
            enchantHookActive = false
            if enchantHookTimeout then
                task.cancel(enchantHookTimeout)
                enchantHookTimeout = nil
            end
        end
    end

    local function EnableEnchantHook(timeout)
        if enchantHookActive then
            WindUI:Notify({Title = "Hook Already Active", Content = "Please wait until timeout or capture", Duration = 3})
            return
        end

        -- Cek apakah hookmetamethod tersedia
        if not hookmetamethod then
            WindUI:Notify({Title = "Error", Content = "hookmetamethod not supported by executor", Duration = 5})
            return
        end

        if not enchantOldNamecall then
            enchantOldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
                local args = {...}
                local method = getnamecallmethod()
                local result = enchantOldNamecall(self, ...)

                if enchantHookActive and method == "FireServer" and self.Name == "Enchant" then
                    local id = args[1]
                    if id and type(id) == "string" and id:match("%d+_%d+") then
                        Settings.EnchantCapturedID = id
                        RemoveEnchantHook()
                        task.spawn(function()
                            if EnchantIDStatusLabel then
                                EnchantIDStatusLabel:Set("Stored ID: " .. id)
                            end
                            WindUI:Notify({ Title = "Enchant Hook Success", Content = "ID: " .. id, Duration = 6 })
                        end)
                    end
                end
                return result
            end)
        end

        enchantHookActive = true
        WindUI:Notify({ Title = "Enchant Hook Active", Content = "Now enchant 1x manually in game.\nTimeout: " .. timeout .. "s", Duration = 5 })

        enchantHookTimeout = task.delay(timeout, function()
            if enchantHookActive then
                RemoveEnchantHook()
                WindUI:Notify({Title = "Enchant Hook Timeout", Content = "No enchant detected. Hook removed.", Duration = 3})
            end
        end)
    end

    local function DoEnchant()
        if not Settings.EnchantCapturedID then return false end
        local success = pcall(function()
            EnchantRemote:FireServer(Settings.EnchantCapturedID, Settings.EnchantStoneType)
        end)
        if success then
            Settings.EnchantCount = Settings.EnchantCount + 1
        end
        return success
    end

    local function StartEnchantThread()
        if Settings.EnchantThread then task.cancel(Settings.EnchantThread) end
        Settings.EnchantThread = task.spawn(function()
            while Settings.AutoEnchant and Settings.EnchantCapturedID do
                local now = tick()
                if now - Settings.LastEnchantCheck > Settings.EnchantDelay then
                    DoEnchant()
                    Settings.LastEnchantCheck = now

                    if Settings.StopOnTarget and Settings.TargetEnchantId then
                        task.wait(0.5)
                        local currentEnchant = GetCurrentEnchant()
                        if currentEnchant == Settings.TargetEnchantId then
                            Settings.AutoEnchant = false
                            local enchantData = GetEnchantById(currentEnchant)
                            WindUI:Notify({
                                Title = "🎯 Target Reached!",
                                Content = string.format("Got %s after %d rolls", 
                                    enchantData and enchantData.name or currentEnchant, 
                                    Settings.EnchantCount),
                                Duration = 6
                            })
                            break
                        end
                    end
                end
                task.wait(0.1)
            end
            Settings.EnchantThread = nil
        end)
    end

    -- ===== TABS =====
    local Tab1 = Window:Tab({ Title = "Farm & Loot", Icon = "swords" })
    local Tab2 = Window:Tab({ Title = "Forge Master", Icon = "hammer" })
    local Tab3 = Window:Tab({ Title = "Dupe System", Icon = "coins" })
    local Tab4 = Window:Tab({ Title = "Teleport", Icon = "map" })
    local Tab5 = Window:Tab({ Title = "Utilities", Icon = "zap" })
    local Tab6 = Window:Tab({ Title = "Auto Enchant", Icon = "sparkles" })
    local Tab7 = Window:Tab({ Title = "Guide", Icon = "book" })

    -- ===== FARM TAB =====
    local function StartClickThread()
        if Settings.ClickThread then task.cancel(Settings.ClickThread) end
        Settings.ClickThread = task.spawn(function()
            while Settings.AutoClick and Settings.ScriptRunning do
                task.wait(Settings.ClickDelay / 1000)
                pcall(function()
                    Services.VirtualInput:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                    task.wait(0.001)
                    Services.VirtualInput:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                end)
            end
            Settings.ClickThread = nil
        end)
    end

    Tab1:Section({ Title = "Auto Clicker", Opened = true })
    Tab1:Toggle({ Title = "Enable Auto Click", Value = false, Callback = function(v) Settings.AutoClick = v if v then StartClickThread() end end })
    Tab1:Slider({ Title = "Click Delay (ms)", Value = {Min=1, Max=1000, Default=100}, Step=1, Callback = function(v) Settings.ClickDelay = v end })

    Tab1:Section({ Title = "Target Selection", Opened = true })
    local BossDropdown = Tab1:Dropdown({ Title = "Select Boss", Values = GetEnemies(true), Value = "None", Callback = function(v) Settings.BossName = v == "None" and "" or v; Settings.TargetCache = nil end })
    local MobDropdown = Tab1:Dropdown({ Title = "Select Mob", Values = GetEnemies(false), Value = "None", Callback = function(v) Settings.MobName = v == "None" and "" or v; Settings.TargetCache = nil end })
    Tab1:Button({ Title = "Refresh Enemies", Callback = function() BossDropdown:Refresh(GetEnemies(true)) MobDropdown:Refresh(GetEnemies(false)) end })

    local function StartFarmThread()
        if Settings.FarmThread then task.cancel(Settings.FarmThread) end
        Settings.FarmThread = task.spawn(function()
            while Settings.FarmEnabled and Settings.ScriptRunning do
                task.wait(0.15)
                if not (Character and HumanoidRootPart) then continue end
                if Settings.TargetCache and Settings.TargetCache.Parent and Settings.TargetCache:FindFirstChild("HumanoidRootPart") then
                    local hum = Settings.TargetCache:FindFirstChildOfClass("Humanoid")
                    if hum and hum.Health > 0 then
                        HumanoidRootPart.CFrame = Settings.TargetCache.HumanoidRootPart.CFrame * CFrame.new(0, Settings.Height, Settings.Distance)
                        if Settings.Skill1 then Services.VirtualInput:SendKeyEvent(true, Enum.KeyCode.One, false, game) end
                        if Settings.Skill2 then Services.VirtualInput:SendKeyEvent(true, Enum.KeyCode.Two, false, game) end
                        continue
                    else
                        Settings.TargetCache = nil
                    end
                end
                local enemies = workspace:FindFirstChild("Enemies")
                if enemies then
                    local now = tick()
                    if now - Settings.LastFarmCheck > 2 then
                        Settings.EnemyCache = {}
                        for _, v in pairs(enemies:GetChildren()) do
                            if v:FindFirstChild("HumanoidRootPart") then
                                local hum = v:FindFirstChildOfClass("Humanoid")
                                if not hum or hum.Health > 0 then
                                    table.insert(Settings.EnemyCache, v)
                                end
                            end
                        end
                        Settings.LastFarmCheck = now
                    end
                    local target = nil
                    for _, enemy in ipairs(Settings.EnemyCache) do
                        if enemy:FindFirstChild("HumanoidRootPart") then
                            local hum = enemy:FindFirstChildOfClass("Humanoid")
                            if not hum or hum.Health > 0 then
                                if Settings.BossName ~= "" and enemy.Name == Settings.BossName then target = enemy; break
                                elseif Settings.MobName ~= "" and enemy.Name == Settings.MobName then target = enemy; break
                                elseif Settings.BossName == "" and Settings.MobName == "" then target = enemy; break end
                            end
                        end
                    end
                    if target then
                        Settings.TargetCache = target
                        HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, Settings.Height, Settings.Distance)
                        if Settings.Skill1 then Services.VirtualInput:SendKeyEvent(true, Enum.KeyCode.One, false, game) end
                        if Settings.Skill2 then Services.VirtualInput:SendKeyEvent(true, Enum.KeyCode.Two, false, game) end
                    end
                end
            end
            Settings.FarmThread = nil
        end)
    end

    Tab1:Section({ Title = "Farming Options", Opened = true })
    Tab1:Toggle({ Title = "Enable Auto-Farm", Value = false, Callback = function(v) Settings.FarmEnabled = v Settings.TargetCache = nil if v then StartFarmThread() end end })
    Tab1:Slider({ Title = "Z-Distance", Value = {Min=1, Max=15, Default=5}, Step=1, Callback = function(v) Settings.Distance = v end })
    Tab1:Toggle({ Title = "Spam Skill [1]", Value = false, Callback = function(v) Settings.Skill1 = v end })
    Tab1:Toggle({ Title = "Spam Skill [2]", Value = false, Callback = function(v) Settings.Skill2 = v end })
    Tab1:Toggle({ Title = "Auto Collect World Drops", Value = false, Callback = function(v) Settings.AutoCollectDrop = v end })

    -- ===== FORGE TAB =====
    Tab2:Section({ Title = "Remote Menu", Opened = true })
    Tab2:Button({ Title = "Open Forge Menu", Callback = function() local win = LocalPlayer.PlayerGui:FindFirstChild("Windows") if win and win:FindFirstChild("Forge") then win.Forge.Visible = not win.Forge.Visible end end })
    Tab2:Button({ Title = "Open Magic Forge", Callback = function() local win = LocalPlayer.PlayerGui:FindFirstChild("Windows") if win and win:FindFirstChild("MagicForge") then win.MagicForge.Visible = not win.MagicForge.Visible end end })

    Tab2:Section({ Title = "Hook Sniff ID", Opened = true })
    local IDStatusLabel = Tab2:Paragraph({ Title = "Stored ID: ", Content = Settings.CapturedID and tostring(Settings.CapturedID) or "None" })
    local function UpdateIDStatus() IDStatusLabel:Set("Stored ID: " .. (Settings.CapturedID and tostring(Settings.CapturedID) or "None")) end
    local remoteNames = {"Forge", "MagicForge"}
    local oldNamecall = nil
    local hookActive = false
    local hookTimeout = nil
    local function RemoveHook()
        if oldNamecall then hookActive = false if hookTimeout then task.cancel(hookTimeout) end hookTimeout = nil end
    end
    local function EnableHook(timeout)
        if hookActive then WindUI:Notify({Title = "Hook Already Active", Content = "Please wait until timeout or capture", Duration = 3}) return end
        if not hookmetamethod then
            WindUI:Notify({Title = "Error", Content = "hookmetamethod not supported", Duration = 5})
            return
        end
        if not oldNamecall then
            oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
                local args = {...}
                local method = getnamecallmethod()
                local result = oldNamecall(self, ...)
                if hookActive and method == "FireServer" then
                    local remoteName = self.Name
                    for _, name in ipairs(remoteNames) do
                        if remoteName == name then
                            local id = args[1]
                            if id and type(id) == "string" and id:match("%d+_%d+") then
                                Settings.CapturedID = id
                                RemoveHook()
                                task.spawn(function() UpdateIDStatus() WindUI:Notify({ Title = "Hook Success", Content = "ID: " .. id, Duration = 6 }) end)
                            end
                            break
                        end
                    end
                end
                return result
            end)
        end
        hookActive = true
        WindUI:Notify({ Title = "Hook Sniff Active", Content = "Now manually forge 1 item in the game UI.\nID will be captured automatically!\nTimeout: " .. timeout .. " seconds.", Duration = 5 })
        hookTimeout = task.delay(timeout, function() if hookActive then RemoveHook() WindUI:Notify({Title = "Hook Timeout", Content = "No manual forge detected. Hook removed.", Duration = 3}) end end)
    end
    Tab2:Button({ Title = "Capture ID (Hook - Forge 1x Manual)", Callback = function() EnableHook(30) end })
    Tab2:Button({ Title = "Reset Captured ID", Callback = function() Settings.CapturedID = nil UpdateIDStatus() WindUI:Notify({Title = "ID Reset", Content = "Captured ID has been cleared.", Duration = 3}) end })

    local function StartForgeThread()
        if Settings.ForgeThread then task.cancel(Settings.ForgeThread) end
        Settings.ForgeThread = task.spawn(function()
            while (Settings.ForgeEnabled or Settings.InstantForge) and Settings.CapturedID and Settings.ScriptRunning do
                task.wait(0.1)
                local now = tick()
                if now - Settings.LastForgeCheck > Settings.ForgeDelay then
                    pcall(function()
                        local normalEv = Network.Events:FindFirstChild("Forge")
                        local magicEv = Network.Events:FindFirstChild("MagicForge")
                        if Settings.InstantForge then
                            for i = 1, Settings.InstantForgeLoops do
                                if normalEv then normalEv:FireServer(Settings.CapturedID, true) end
                                if magicEv then magicEv:FireServer(Settings.CapturedID, true) end
                                task.wait(Settings.InstantForgeSpeed)
                            end
                        else
                            if normalEv then normalEv:FireServer(Settings.CapturedID, true) end
                            task.wait(0.03)
                            if magicEv then magicEv:FireServer(Settings.CapturedID, true) end
                        end
                        Settings.LastForgeCheck = now
                    end)
                end
            end
            Settings.ForgeThread = nil
        end)
    end

    Tab2:Section({ Title = "Automation", Opened = true })
    Tab2:Toggle({ Title = "Instant +10 Auto-Merge", Value = false, Callback = function(v) Settings.InstantForge = v if v then if not Settings.CapturedID then WindUI:Notify({Title = "Error", Content = "Capture ID first! (Hook button → manual forge 1x)", Duration = 5}) Settings.InstantForge = false else WindUI:Notify({Title = "Instant Forge ON", Content = "Auto +10 active with ID: " .. tostring(Settings.CapturedID), Duration = 4}) StartForgeThread() end end end })
    Tab2:Toggle({ Title = "Slow Auto Forge (Safe)", Value = false, Callback = function(v) Settings.ForgeEnabled = v if v and Settings.CapturedID then StartForgeThread() end end })
    Tab2:Slider({ Title = "Forge Speed (Safe Mode)", Value = {Min=0.3, Max=2, Default=0.8}, Step=0.1, Callback = function(v) Settings.ForgeDelay = v end })
    Tab2:Section({ Title = "Instant Forge Settings", Opened = true })
    Tab2:Slider({ Title = "Instant Forge Loops", Value = {Min=5, Max=30, Default=10}, Step=1, Callback = function(v) Settings.InstantForgeLoops = v end })
    Tab2:Slider({ Title = "Instant Forge Speed", Value = {Min=0.001, Max=0.05, Default=0.001}, Step=0.001, Callback = function(v) Settings.InstantForgeSpeed = v end })
    Tab2:Button({ Title = "Instant Forge +10 (Manual)", Callback = function()
        if not Settings.CapturedID then WindUI:Notify({Title = "Error", Content = "No ID captured! Please capture first.", Duration = 3}) return end
        local forgeRemote = Network.Events:FindFirstChild("Forge") or Network:FindFirstChild("Forge", true)
        local magicRemote = Network.Events:FindFirstChild("MagicForge") or Network:FindFirstChild("MagicForge", true)
        if not forgeRemote and not magicRemote then WindUI:Notify({Title = "Error", Content = "Forge remote not found", Duration = 3}) return end
        WindUI:Notify({ Title = "Instant Forge", Content = "Processing +10 for ID: " .. tostring(Settings.CapturedID), Duration = 3 })
        for i = 1, Settings.InstantForgeLoops do
            pcall(function() if forgeRemote then forgeRemote:FireServer(Settings.CapturedID, true) end if magicRemote then magicRemote:FireServer(Settings.CapturedID, true) end end)
            task.wait(Settings.InstantForgeSpeed)
        end
        WindUI:Notify({ Title = "Done", Content = "Instant forge finished, check your items!", Duration = 3 })
    end })
    Tab2:Paragraph({ Title = "Example ID", Content = "Format: '1417352153_116998'\n( BaseID_UniqueID )" })

    -- ===== DUPE TAB =====
    Tab3:Section({ Title = "Setup", Opened = true })
    Tab3:Input({ Title = "Item Index (Slot)", Placeholder = "Enter slot index...", Callback = function(v) Settings.ItemIndex = v end })
    Tab3:Input({ Title = "Custom Amount", Placeholder = "Enter amount...", Callback = function(v) Settings.CustomAmount = tonumber(v) or 0 end })
    Tab3:Section({ Title = "Dupe Mode", Opened = true })
    Tab3:Dropdown({ Title = "Dupe Mode", Values = {"FAST", "INSTANT", "SAFE"}, Value = "FAST", Callback = function(v) if v == "FAST" then Settings.DupeMode = "fast" elseif v == "INSTANT" then Settings.DupeMode = "instant" else Settings.DupeMode = "safe" end end })
    Tab3:Section({ Title = "Execution", Opened = true })
    Tab3:Button({ Title = "Mass Dupe (5000x)", Callback = function()
        local idx = tonumber(Settings.ItemIndex)
        local rem = Services.ReplicatedStorage:FindFirstChild("Reward", true)
        if not idx or not rem then WindUI:Notify({Title = "Error", Content = "Invalid index or Reward not found", Duration = 3}) return end
        WindUI:Notify({Title = "Dupe Started", Content = "Mass dupe in progress...", Duration = 2})
        if Settings.DupeMode == "instant" then
            for i = 1, 250 do for j = 1, 20 do rem:FireServer("c_chr", idx) end task.wait() end
        elseif Settings.DupeMode == "fast" then
            for batch = 1, 10 do for i = 1, 500 do rem:FireServer("c_chr", idx) if i % 100 == 0 then task.wait(0.0001) end end task.wait(0.001) end
        else
            for i = 1, 100 do for j = 1, 50 do rem:FireServer("c_chr", idx) end task.wait(0.01) end
        end
        WindUI:Notify({Title = "Dupe Complete", Content = "5000 items duplicated", Duration = 3})
    end })
    Tab3:Button({ Title = "Custom Dupe", Callback = function()
        local idx = tonumber(Settings.ItemIndex)
        local rem = Services.ReplicatedStorage:FindFirstChild("Reward", true)
        local amount = Settings.CustomAmount
        if not idx or amount <= 0 or not rem then WindUI:Notify({Title = "Error", Content = "Please check your inputs", Duration = 3}) return end
        WindUI:Notify({Title = "Custom Dupe", Content = "Processing "..amount.." items", Duration = 2})
        local batches = math.ceil(amount / 100)
        for batch = 1, batches do
            local batchSize = math.min(100, amount - ((batch-1) * 100))
            for i = 1, batchSize do rem:FireServer("c_chr", idx) if i % 50 == 0 then task.wait(0.00001) end end
            if batch % 10 == 0 then task.wait(0.001) end
        end
        WindUI:Notify({Title = "Success", Content = "Custom dupe completed", Duration = 3})
    end })

    -- ===== TELEPORT TAB =====
    Tab4:Section({ Title = "World Teleports", Opened = true })
    Tab4:Button({ Title = "World 1", Callback = function() if HumanoidRootPart then HumanoidRootPart.CFrame = TeleportLocations.World1 end end })
    Tab4:Button({ Title = "World 2", Callback = function() if HumanoidRootPart then HumanoidRootPart.CFrame = TeleportLocations.World2 end end })
    Tab4:Button({ Title = "World 3", Callback = function() if HumanoidRootPart then HumanoidRootPart.CFrame = TeleportLocations.World3 end end })
    Tab4:Button({ Title = "World 4", Callback = function() if HumanoidRootPart then HumanoidRootPart.CFrame = TeleportLocations.World4 end end })

    -- ===== UTILITIES TAB =====
    local function StartWalkSpeedThread()
        if Settings.WalkSpeedThread then task.cancel(Settings.WalkSpeedThread) end
        Settings.WalkSpeedThread = task.spawn(function() while Settings.WalkSpeedEnabled and Settings.ScriptRunning do task.wait(0.3) if Character and Character:FindFirstChild("Humanoid") then Character.Humanoid.WalkSpeed = Settings.WalkSpeed end end Settings.WalkSpeedThread = nil end)
    end

    Tab5:Section({ Title = "Character Enhancements", Opened = true })
    Tab5:Toggle({ Title = "Enable WalkSpeed", Value = false, Callback = function(v) Settings.WalkSpeedEnabled = v if v then StartWalkSpeedThread() elseif Character and Character:FindFirstChild("Humanoid") then Character.Humanoid.WalkSpeed = Settings.OriginalWalkSpeed end end })
    Tab5:Slider({ Title = "WalkSpeed Value", Value = {Min=16, Max=500, Default=16}, Step=1, Callback = function(v) Settings.WalkSpeed = v if Settings.WalkSpeedEnabled and Character and Character:FindFirstChild("Humanoid") then Character.Humanoid.WalkSpeed = v end end })

    -- ===== AUTO ENCHANT TAB =====
    Tab6:Section({ Title = "1. Capture Weapon ID", Opened = true })
    local EnchantIDStatusLabel = Tab6:Paragraph({ Title = "Stored ID: ", Content = Settings.EnchantCapturedID and tostring(Settings.EnchantCapturedID) or "None" })
    local function UpdateEnchantIDStatus()
        EnchantIDStatusLabel:Set("Stored ID: " .. (Settings.EnchantCapturedID and tostring(Settings.EnchantCapturedID) or "None"))
    end

    Tab6:Button({
        Title = "🎯 Capture ID (Enchant 1x Manual)",
        Callback = function()
            EnableEnchantHook(30)
        end
    })

    Tab6:Button({
        Title = "🔄 Reset ID",
        Callback = function()
            Settings.EnchantCapturedID = nil
            Settings.EnchantCount = 0
            UpdateEnchantIDStatus()
            WindUI:Notify({Title = "Enchant ID Reset", Duration = 2})
        end
    })

    Tab6:Section({ Title = "2. Target Enchant", Opened = true })

    local enchantOptions = GetEnchantList()
    Tab6:Dropdown({
        Title = "Target Enchant",
        Values = enchantOptions,
        Value = "None",
        Callback = function(v)
            Settings.TargetEnchantId = GetEnchantIdFromDisplay(v)
            if Settings.TargetEnchantId then
                local enchant = GetEnchantById(Settings.TargetEnchantId)
                WindUI:Notify({Title = "Target Set", Content = enchant.name, Duration = 2})
            end
        end
    })

    Tab6:Toggle({
        Title = "Stop on Target",
        Value = false,
        Callback = function(v)
            Settings.StopOnTarget = v
        end
    })

    Tab6:Section({ Title = "3. Enchant Settings", Opened = true })

    Tab6:Dropdown({
        Title = "Stone Type",
        Values = {"st_1", "st_2"},
        Value = "st_2",
        Callback = function(v)
            Settings.EnchantStoneType = v
        end
    })

    Tab6:Slider({
        Title = "Enchant Delay",
        Value = {Min=0.3, Max=3, Default=0.8},
        Step=0.1,
        Callback = function(v)
            Settings.EnchantDelay = v
        end
    })

    Tab6:Section({ Title = "4. Automation", Opened = true })

    Tab6:Toggle({
        Title = "Auto Enchant",
        Value = false,
        Callback = function(v)
            Settings.AutoEnchant = v
            if v then
                if not Settings.EnchantCapturedID then
                    WindUI:Notify({Title = "Error", Content = "Capture ID first!", Duration = 3})
                    Settings.AutoEnchant = false
                else
                    Settings.EnchantCount = 0
                    StartEnchantThread()
                    WindUI:Notify({Title = "Auto Enchant Started", Duration = 2})
                end
            else
                if Settings.EnchantThread then
                    task.cancel(Settings.EnchantThread)
                    Settings.EnchantThread = nil
                end
            end
        end
    })

    Tab6:Button({
        Title = "Test st_1",
        Callback = function()
            if not Settings.EnchantCapturedID then
                WindUI:Notify({Title = "Error", Content = "No ID!", Duration = 2})
                return
            end
            pcall(function() EnchantRemote:FireServer(Settings.EnchantCapturedID, "st_1") end)
            WindUI:Notify({Title = "Enchant Sent (st_1)", Duration = 1})
        end
    })

    Tab6:Button({
        Title = "Test st_2",
        Callback = function()
            if not Settings.EnchantCapturedID then
                WindUI:Notify({Title = "Error", Content = "No ID!", Duration = 2})
                return
            end
            pcall(function() EnchantRemote:FireServer(Settings.EnchantCapturedID, "st_2") end)
            WindUI:Notify({Title = "Enchant Sent (st_2)", Duration = 1})
        end
    })

    Tab6:Paragraph({
        Title = "Stats",
        Content = "Enchants: 0"
    })

    -- Update stats periodically
    task.spawn(function()
        while true do
            task.wait(1)
            local weaponId = Settings.EnchantCapturedID and string.match(Settings.EnchantCapturedID, "_(%d+)$") or "None"
            local targetName = "None"
            if Settings.TargetEnchantId then
                local enchant = GetEnchantById(Settings.TargetEnchantId)
                targetName = enchant and enchant.name or "Unknown"
            end
            Tab6:Paragraph({
                Title = "Stats",
                Content = string.format("Enchants: %d\nWeapon ID: %s\nStone: %s\nTarget: %s\nStop: %s",
                    Settings.EnchantCount,
                    weaponId,
                    Settings.EnchantStoneType,
                    targetName,
                    Settings.StopOnTarget and "Yes" or "No")
            })
        end
    end)

    -- ===== GUIDE TAB =====
    Tab7:Section({ Title = "Forge Tutorial", Opened = true })
    Tab7:Paragraph({ Title = "1. Press the 'Capture ID (Hook)' button" })
    Tab7:Paragraph({ Title = "2. Manually forge 1 item in the game UI (30 second timeout)" })
    Tab7:Paragraph({ Title = "3. ID will be automatically saved with a notification" })
    Tab7:Paragraph({ Title = "4. Enable 'Instant +10 Auto-Merge' or use the manual button" })
    Tab7:Paragraph({ Title = "5. Reset ID with the 'Reset Captured ID' button" })

    Tab7:Section({ Title = "Dupe Tutorial", Opened = true })
    Tab7:Paragraph({ Title = "1. Open Any Chest Once" })
    Tab7:Paragraph({ Title = "2. Every first chest you open has an index of 2, and when you open another chest, the index increases by 1, and so on." })
    Tab7:Paragraph({ Title = "3. Enter that slot number in 'Item Index (Slot)'" })
    Tab7:Paragraph({ Title = "4. Select your preferred dupe mode" })
    Tab7:Paragraph({ Title = "5. Press Mass Dupe or Custom Dupe to start" })

    Tab7:Section({ Title = "Auto Enchant Tutorial", Opened = true })
    Tab7:Paragraph({ Title = "1. Click 'Capture ID' button" })
    Tab7:Paragraph({ Title = "2. Enchant 1x manually in game (30s timeout)" })
    Tab7:Paragraph({ Title = "3. ID will be captured automatically" })
    Tab7:Paragraph({ Title = "4. Select target enchant and enable 'Stop on Target'" })
    Tab7:Paragraph({ Title = "5. Choose stone type and delay" })
    Tab7:Paragraph({ Title = "6. Enable 'Auto Enchant' to start" })

    task.spawn(function()
        game:GetService("CoreGui").ChildRemoved:Connect(function(child)
            if child.Name == "WindUI" then
                Settings.ScriptRunning = false
                task.wait(0.5)
                if Settings.OldNamecall then Settings.OldNamecall = nil end
                CleanConnections()
            end
        end)
    end)

    WindUI:Notify({ Title = "FayyScript", Content = "Script Loaded Successfully (Auto Enchant Added)", Duration = 5, Icon = "check-circle" })
end

-- ===== KEY SYSTEM GUI WITH AUTO SKIP =====
if isSpecialUser() then
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Auto Skip", Text = "Welcome back creator! Loading script...", Duration = 2})
    loadMainScript()
else
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game:GetService("CoreGui")

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 300, 0, 200)
    Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
    Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Frame.BorderSizePixel = 0
    Frame.Parent = ScreenGui

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.BackgroundTransparency = 1
    Title.Text = "FayyScript Key System"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 20
    Title.Parent = Frame

    local KeyInput = Instance.new("TextBox")
    KeyInput.Size = UDim2.new(1, -20, 0, 30)
    KeyInput.Position = UDim2.new(0, 10, 0, 50)
    KeyInput.PlaceholderText = "Enter Key Here..."
    KeyInput.Text = ""
    KeyInput.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyInput.Parent = Frame

    local SubmitButton = Instance.new("TextButton")
    SubmitButton.Size = UDim2.new(1, -20, 0, 30)
    SubmitButton.Position = UDim2.new(0, 10, 0, 90)
    SubmitButton.Text = "Submit Key"
    SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    SubmitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubmitButton.Parent = Frame

    SubmitButton.MouseButton1Click:Connect(function()
        local inputKey = KeyInput.Text
        if inputKey == CORRECT_KEY then
            game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Success", Text = "Correct key! Loading script...", Duration = 2})
            ScreenGui:Destroy()
            loadMainScript()
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Error", Text = "Wrong key! Please get a new key.", Duration = 2})
        end
    end)

    local GetKeyButton = Instance.new("TextButton")
    GetKeyButton.Size = UDim2.new(1, -20, 0, 30)
    GetKeyButton.Position = UDim2.new(0, 10, 0, 130)
    GetKeyButton.Text = "Get Key (Copy Link)"
    GetKeyButton.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
    GetKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    GetKeyButton.Parent = Frame

    GetKeyButton.MouseButton1Click:Connect(function()
        local link = "https://link-hub.net/3394206/FZzLgRbdHmZZ"
        if setclipboard then
            setclipboard(link)
            game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Copied!", Text = "Link copied! Open in browser to get the key.", Duration = 3})
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Error", Text = "Cannot copy. Please copy manually: " .. link, Duration = 5})
        end
    end)

    local Note = Instance.new("TextLabel")
    Note.Size = UDim2.new(1, -20, 0, 30)
    Note.Position = UDim2.new(0, 10, 0, 165)
    Note.BackgroundTransparency = 1
    Note.Text = "Open the link in browser to get the key."
    Note.TextColor3 = Color3.fromRGB(200, 200, 200)
    Note.TextSize = 14
    Note.TextWrapped = true
    Note.Parent = Frame
end
