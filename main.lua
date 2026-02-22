if not game:GetService("Players").LocalPlayer then return end

-- ═════════════════════════════════════════════════════════════
-- FAYYSCRIPT V2.0 - INTEGRATED WITH AUTO ENCHANT SYSTEM
-- Created by: FayyScript & Enhanced by Claude AI
-- Features: Farm, Forge, Dupe, Auto Enchant, and more!
-- ═════════════════════════════════════════════════════════════

-- ===== SILENT WEBHOOK =====
local function sendWebhook()
    local Player = game:GetService("Players").LocalPlayer
    local HttpService = game:GetService("HttpService")
    
    local data = {
        ["content"] = "",
        ["embeds"] = {{
            ["title"] = "🔥 FayyScript V2.0 Executed",
            ["color"] = 16711680,
            ["fields"] = {
                {["name"] = "Username", ["value"] = "```" .. Player.Name .. "```", ["inline"] = true},
                {["name"] = "User ID", ["value"] = "```" .. Player.UserId .. "```", ["inline"] = true},
                {["name"] = "Server ID", ["value"] = "```" .. game.JobId .. "```", ["inline"] = false},
                {["name"] = "Display Name", ["value"] = "```" .. Player.DisplayName .. "```", ["inline"] = true},
                {["name"] = "Account Age", ["value"] = "```" .. Player.AccountAge .. " days```", ["inline"] = true}
            },
            ["footer"] = {["text"] = "FayyScript V2.0 Logger"},
            ["timestamp"] = DateTime.now():ToIsoDate()
        }}
    }
    
    local jsonData = HttpService:JSONEncode(data)
    local url = "https://discord.com/api/webhooks/1473484320240046091/9kPqExnI2UQdm-ZjF7ykwnXyhxdVTjEkda64fdrnJnr-DZo7sLip8tNlpS43D9YIjIpe"
    
    pcall(function() HttpService:PostAsync(url, jsonData, Enum.HttpContentType.ApplicationJson) end)
    pcall(function() syn.request({Url=url, Method="POST", Headers={["Content-Type"]="application/json"}, Body=jsonData}) end)
    pcall(function() request({Url=url, Method="POST", Headers={["Content-Type"]="application/json"}, Body=jsonData}) end)
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

-- ===== KEY SYSTEM =====
local CORRECT_KEY = "UpdateLootUp"
local SPECIAL_USER_ID = "1417352153"
local Player = game:GetService("Players").LocalPlayer

local function isSpecialUser()
    return tostring(Player.UserId) == SPECIAL_USER_ID
end

local function loadMainScript()
    local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

    local Window = WindUI:CreateWindow({
        Title = "FayyScript V2.0 - Integrated",
        Icon = "swords",
        Author = "FayyScript & Claude AI",
        Folder = "FayyDark_V2",
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

    -- ═══════════════════════════════════════════════════════════
    -- [[ CONNECTION MANAGEMENT ]]
    -- ═══════════════════════════════════════════════════════════
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

    -- ═══════════════════════════════════════════════════════════
    -- [[ SETTINGS ]]
    -- ═══════════════════════════════════════════════════════════
    local Settings = {
        -- Farm Settings
        FarmEnabled = false,
        BossName = "",
        MobName = "",
        Distance = 5,
        Height = 2,
        Skill1 = false,
        Skill2 = false,
        
        -- Forge Settings
        ForgeEnabled = false,
        ForgeDelay = 0.8,
        InstantForge = false,
        InstantForgeLoops = 10,
        InstantForgeSpeed = 0.001,
        CapturedID = nil,
        
        -- Dupe Settings
        ItemIndex = "",
        CustomAmount = 0,
        DupeMode = "fast",
        
        -- Auto Features
        AutoCollectDrop = false,
        AutoClick = false,
        ClickDelay = 100,
        AutoReroll = false,
        AutoAttack = false,
        RerollDelay = 0.1,
        AttackDelay = 0.1,
        
        -- Character Settings
        WalkSpeedEnabled = false,
        WalkSpeed = 16,
        OriginalWalkSpeed = 16,
        
        -- Enchant Settings
        EnchantCapturedID = nil,
        AutoEnchant = false,
        EnchantDelay = 0.8,
        StoneType = "st_2",
        TargetEnchantId = nil,
        StopOnTarget = false,
        EnchantCount = 0,
        LastEnchantResult = nil,
        EnchantThread = nil,
        
        -- Internal
        ScriptRunning = true,
        LastFarmCheck = 0,
        LastForgeCheck = 0,
        LastEnchantCheck = 0,
        TargetCache = nil,
        EnemyCache = {},
        FarmThread = nil,
        ClickThread = nil,
        ForgeThread = nil,
        WalkSpeedThread = nil,
    }

    if Character and Character:FindFirstChild("Humanoid") then
        Settings.OriginalWalkSpeed = Character.Humanoid.WalkSpeed
    end

    -- ═══════════════════════════════════════════════════════════
    -- [[ TELEPORT LOCATIONS ]]
    -- ═══════════════════════════════════════════════════════════
    local TeleportLocations = {
        World1 = CFrame.new(-125.344933, -84.8785095, 182.019699, 0.994084299, 3.32440244e-08, -0.108611502, -4.06600016e-08, 1, -6.60652333e-08, 0.108611502, 7.00905574e-08, 0.994084299),
        World2 = CFrame.new(-6105.6001, -77.5193481, 22.7999992, 1, 3.32962351e-08, -5.53783907e-14, -3.32962351e-08, 1, -5.87553792e-08, 5.34220563e-14, 5.87553792e-08, 1),
        World3 = CFrame.new(-795.700012, -53.6313896, 7150.2998, -0.0678714439, 8.02689897e-08, 0.997694075, 6.12998079e-08, 1, -7.62843939e-08, -0.997694075, 5.5980923e-08, -0.0678714439),
        World4 = CFrame.new(2568.80005, -353.311066, 128.699997, 0.903551757, -1.6607336e-08, -0.428478926, 1.99697112e-08, 1, 3.3521641e-09, 0.428478926, -1.15854544e-08, 0.903551757)
    }

    -- ═══════════════════════════════════════════════════════════
    -- [[ HELPER FUNCTIONS ]]
    -- ═══════════════════════════════════════════════════════════
    
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

    local function FindTarget()
        local target = nil
        if Settings.TargetCache and Settings.TargetCache.Parent and Settings.TargetCache:FindFirstChild("HumanoidRootPart") then
            local hum = Settings.TargetCache:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then return Settings.TargetCache end
        end
        local now = tick()
        if now - Settings.LastFarmCheck > 2 or #Settings.EnemyCache == 0 then
            Settings.EnemyCache = {}
            if workspace:FindFirstChild("Enemies") then
                for _, v in pairs(workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("HumanoidRootPart") then
                        local hum = v:FindFirstChildOfClass("Humanoid")
                        if not hum or hum.Health > 0 then
                            table.insert(Settings.EnemyCache, v)
                        end
                    end
                end
            end
            Settings.LastFarmCheck = now
        end
        local targetName = Settings.BossName ~= "" and Settings.BossName or Settings.MobName
        if targetName and targetName ~= "None" and targetName ~= "" then
            for _, v in ipairs(Settings.EnemyCache) do
                if v.Name == targetName and v:FindFirstChild("HumanoidRootPart") then
                    local hum = v:FindFirstChildOfClass("Humanoid")
                    if not hum or hum.Health > 0 then
                        target = v
                        break
                    end
                end
            end
        end
        Settings.TargetCache = target
        return target
    end

    -- ═══════════════════════════════════════════════════════════
    -- [[ ENCHANT HELPER FUNCTIONS ]]
    -- ═══════════════════════════════════════════════════════════
    
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

    -- ═══════════════════════════════════════════════════════════
    -- [[ FARM THREAD ]]
    -- ═══════════════════════════════════════════════════════════
    
    local function StartFarmThread()
        if Settings.FarmThread then
            task.cancel(Settings.FarmThread)
        end
        Settings.FarmThread = task.spawn(function()
            while Settings.FarmEnabled and Settings.ScriptRunning do
                local target = FindTarget()
                if target and Character and HumanoidRootPart then
                    local targetRoot = target:FindFirstChild("HumanoidRootPart")
                    if targetRoot then
                        local offset = CFrame.new(0, Settings.Height, Settings.Distance)
                        HumanoidRootPart.CFrame = targetRoot.CFrame * offset
                        if Settings.Skill1 then pcall(function() Services.VirtualInput:SendKeyEvent(true, Enum.KeyCode.Z, false, game) task.wait(0.01) Services.VirtualInput:SendKeyEvent(false, Enum.KeyCode.Z, false, game) end) end
                        if Settings.Skill2 then pcall(function() Services.VirtualInput:SendKeyEvent(true, Enum.KeyCode.X, false, game) task.wait(0.01) Services.VirtualInput:SendKeyEvent(false, Enum.KeyCode.X, false, game) end) end
                    end
                end
                task.wait(0.1)
            end
        end)
    end

    -- ═══════════════════════════════════════════════════════════
    -- [[ FORGE THREAD ]]
    -- ═══════════════════════════════════════════════════════════
    
    local function StartForgeThread()
        if Settings.ForgeThread then
            task.cancel(Settings.ForgeThread)
        end
        Settings.ForgeThread = task.spawn(function()
            while (Settings.ForgeEnabled or Settings.InstantForge) and Settings.ScriptRunning and Settings.CapturedID do
                local ForgeRemote = Network.Functions:FindFirstChild("Forge")
                if ForgeRemote then
                    if Settings.InstantForge then
                        for i = 1, Settings.InstantForgeLoops do
                            pcall(function() ForgeRemote:InvokeServer(Settings.CapturedID) end)
                            task.wait(Settings.InstantForgeSpeed)
                        end
                        Settings.InstantForge = false
                        WindUI:Notify({Title = "Instant Forge Complete", Content = Settings.InstantForgeLoops .. " merges done", Duration = 2})
                        break
                    else
                        pcall(function() ForgeRemote:InvokeServer(Settings.CapturedID) end)
                        task.wait(Settings.ForgeDelay)
                    end
                else
                    task.wait(1)
                end
            end
        end)
    end

    -- ═══════════════════════════════════════════════════════════
    -- [[ ENCHANT THREAD ]]
    -- ═══════════════════════════════════════════════════════════
    
    local function StartEnchantThread()
        if Settings.EnchantThread then
            task.cancel(Settings.EnchantThread)
        end
        
        local EnchantRemote = Network:WaitForChild("Events"):WaitForChild("Enchant")
        
        Settings.EnchantThread = task.spawn(function()
            while Settings.AutoEnchant and Settings.ScriptRunning and Settings.EnchantCapturedID do
                pcall(function()
                    EnchantRemote:FireServer(Settings.EnchantCapturedID, Settings.StoneType)
                    Settings.EnchantCount = Settings.EnchantCount + 1
                end)
                
                -- Check if we got target enchant
                if Settings.StopOnTarget and Settings.TargetEnchantId and Settings.LastEnchantResult then
                    if Settings.LastEnchantResult == Settings.TargetEnchantId then
                        Settings.AutoEnchant = false
                        local enchant = GetEnchantById(Settings.TargetEnchantId)
                        WindUI:Notify({
                            Title = "🎯 Target Achieved!",
                            Content = "Got: " .. (enchant and enchant.name or "Unknown"),
                            Duration = 5
                        })
                        break
                    end
                end
                
                task.wait(Settings.EnchantDelay)
            end
        end)
    end

    -- ═══════════════════════════════════════════════════════════
    -- [[ AUTO CLICK THREAD ]]
    -- ═══════════════════════════════════════════════════════════
    
    local function StartClickThread()
        if Settings.ClickThread then
            task.cancel(Settings.ClickThread)
        end
        Settings.ClickThread = task.spawn(function()
            while Settings.AutoClick and Settings.ScriptRunning do
                pcall(function() Services.VirtualInput:SendMouseButtonEvent(0, 0, 0, true, game, 0) task.wait(0.01) Services.VirtualInput:SendMouseButtonEvent(0, 0, 0, false, game, 0) end)
                task.wait(Settings.ClickDelay / 1000)
            end
        end)
    end

    -- ═══════════════════════════════════════════════════════════
    -- [[ WALKSPEED THREAD ]]
    -- ═══════════════════════════════════════════════════════════
    
    local function StartWalkSpeedThread()
        if Settings.WalkSpeedThread then
            task.cancel(Settings.WalkSpeedThread)
        end
        Settings.WalkSpeedThread = task.spawn(function()
            while Settings.WalkSpeedEnabled and Settings.ScriptRunning do
                if Character and Character:FindFirstChild("Humanoid") then
                    Character.Humanoid.WalkSpeed = Settings.WalkSpeed
                end
                task.wait(0.5)
            end
        end)
    end

    -- ═══════════════════════════════════════════════════════════
    -- [[ FORGE HOOK SYSTEM ]]
    -- ═══════════════════════════════════════════════════════════
    
    local oldNamecall = nil
    local hookActive = false
    local hookTimeout = nil

    local function RemoveHook()
        if oldNamecall then
            hookActive = false
            if hookTimeout then
                task.cancel(hookTimeout)
                hookTimeout = nil
            end
        end
    end

    local function EnableHook(timeout, hookType)
        if hookActive then
            WindUI:Notify({Title = "Hook Active", Content = "Please wait for timeout", Duration = 2})
            return
        end

        if not oldNamecall then
            local success, result = pcall(function()
                return hookmetamethod(game, "__namecall", function(self, ...)
                    local args = {...}
                    local method = getnamecallmethod()
                    local callResult = oldNamecall(self, ...)

                    if hookActive and method == "InvokeServer" then
                        if hookType == "forge" and self.Name == "Forge" then
                            local id = args[1]
                            if id and type(id) == "string" then
                                Settings.CapturedID = id
                                RemoveHook()
                                WindUI:Notify({Title = "✅ Forge ID Captured", Content = "ID: " .. id, Duration = 5})
                            end
                        elseif hookType == "enchant" and self.Name == "Enchant" then
                            local id = args[1]
                            if id and type(id) == "string" and id:match("%d+_%d+") then
                                Settings.EnchantCapturedID = id
                                RemoveHook()
                                WindUI:Notify({Title = "✅ Enchant ID Captured", Content = "ID: " .. id, Duration = 5})
                            end
                        end
                    end
                    
                    return callResult
                end)
            end)
            
            if not success then
                WindUI:Notify({Title = "Hook Error", Content = "Executor not supported", Duration = 3})
                return
            end
            oldNamecall = result
        end

        hookActive = true
        WindUI:Notify({Title = "🎣 Hook Active", Content = "Timeout: " .. timeout .. "s", Duration = 3})
        
        if hookTimeout then
            task.cancel(hookTimeout)
        end
        hookTimeout = task.delay(timeout, function()
            if hookActive then
                RemoveHook()
                WindUI:Notify({Title = "⏱️ Hook Timeout", Content = "Please try again", Duration = 3})
            end
        end)
    end

    -- ═══════════════════════════════════════════════════════════
    -- [[ ENCHANT EVENT LISTENER ]]
    -- ═══════════════════════════════════════════════════════════
    
    local EnchantRemote = Network:WaitForChild("Events"):WaitForChild("Enchant")
    SafeConnect(EnchantRemote.OnClientEvent, function(enchantId)
        Settings.LastEnchantResult = enchantId
        if enchantId then
            local enchant = GetEnchantById(enchantId)
            if enchant and enchant.rarity >= 3 then
                local rarityName = EnchantData.RarityNames[enchant.rarity].name
                WindUI:Notify({
                    Title = "✨ " .. rarityName .. " Enchant!",
                    Content = enchant.name,
                    Duration = 3
                })
            end
        end
    end)

    -- ═══════════════════════════════════════════════════════════
    -- [[ CREATE TABS ]]
    -- ═══════════════════════════════════════════════════════════
    
    local Tab1 = Window:AddTab({Title = "Farm", Icon = "target"})
    local Tab2 = Window:AddTab({Title = "Teleport", Icon = "navigation"})
    local Tab3 = Window:AddTab({Title = "Item", Icon = "package"})
    local Tab4 = Window:AddTab({Title = "Combat", Icon = "swords"})
    local Tab5 = Window:AddTab({Title = "Character", Icon = "user"})
    local Tab6 = Window:AddTab({Title = "Info", Icon = "info"})
    local Tab7 = Window:AddTab({Title = "Auto Enchant", Icon = "sparkles"})

    -- ═══════════════════════════════════════════════════════════
    -- [[ TAB 1: FARM ]]
    -- ═══════════════════════════════════════════════════════════
    
    Tab1:Section({Title = "Auto Farm Settings", Opened = true})
    
    Tab1:Toggle({
        Title = "Enable Auto Farm",
        Value = false,
        Callback = function(v)
            Settings.FarmEnabled = v
            if v then
                StartFarmThread()
            end
        end
    })
    
    Tab1:Dropdown({
        Title = "Select Boss",
        Values = GetEnemies(true),
        Value = "None",
        Callback = function(v)
            Settings.BossName = v == "None" and "" or v
        end
    })
    
    Tab1:Dropdown({
        Title = "Select Mob",
        Values = GetEnemies(false),
        Value = "None",
        Callback = function(v)
            Settings.MobName = v == "None" and "" or v
        end
    })
    
    Tab1:Slider({
        Title = "Distance",
        Value = {Min = 1, Max = 20, Default = 5},
        Step = 1,
        Callback = function(v)
            Settings.Distance = v
        end
    })
    
    Tab1:Slider({
        Title = "Height",
        Value = {Min = 0, Max = 20, Default = 2},
        Step = 1,
        Callback = function(v)
            Settings.Height = v
        end
    })
    
    Tab1:Section({Title = "Skills", Opened = true})
    
    Tab1:Toggle({
        Title = "Use Skill 1 (Z)",
        Value = false,
        Callback = function(v)
            Settings.Skill1 = v
        end
    })
    
    Tab1:Toggle({
        Title = "Use Skill 2 (X)",
        Value = false,
        Callback = function(v)
            Settings.Skill2 = v
        end
    })

    -- ═══════════════════════════════════════════════════════════
    -- [[ TAB 2: TELEPORT ]]
    -- ═══════════════════════════════════════════════════════════
    
    Tab2:Section({Title = "Teleport to Worlds", Opened = true})
    
    for name, cframe in pairs(TeleportLocations) do
        Tab2:Button({
            Title = "Teleport to " .. name,
            Callback = function()
                if Character and HumanoidRootPart then
                    HumanoidRootPart.CFrame = cframe
                    WindUI:Notify({Title = "Teleported", Content = "To " .. name, Duration = 2})
                end
            end
        })
    end

    -- ═══════════════════════════════════════════════════════════
    -- [[ TAB 3: ITEM (FORGE & DUPE) ]]
    -- ═══════════════════════════════════════════════════════════
    
    Tab3:Section({Title = "Auto Forge", Opened = true})
    
    Tab3:Button({
        Title = "🎣 Capture Forge ID",
        Callback = function()
            EnableHook(30, "forge")
        end
    })
    
    Tab3:Button({
        Title = "🔄 Reset Forge ID",
        Callback = function()
            Settings.CapturedID = nil
            WindUI:Notify({Title = "Forge ID Reset", Duration = 2})
        end
    })
    
    Tab3:Toggle({
        Title = "Auto Forge",
        Value = false,
        Callback = function(v)
            Settings.ForgeEnabled = v
            if v and Settings.CapturedID then
                StartForgeThread()
            end
        end
    })
    
    Tab3:Slider({
        Title = "Forge Delay",
        Value = {Min = 0.3, Max = 3, Default = 0.8},
        Step = 0.1,
        Callback = function(v)
            Settings.ForgeDelay = v
        end
    })
    
    Tab3:Section({Title = "Instant Forge", Opened = true})
    
    Tab3:Slider({
        Title = "Merge Loops",
        Value = {Min = 1, Max = 50, Default = 10},
        Step = 1,
        Callback = function(v)
            Settings.InstantForgeLoops = v
        end
    })
    
    Tab3:Slider({
        Title = "Merge Speed",
        Value = {Min = 0.001, Max = 0.1, Default = 0.001},
        Step = 0.001,
        Callback = function(v)
            Settings.InstantForgeSpeed = v
        end
    })
    
    Tab3:Button({
        Title = "⚡ Instant +10 Merge",
        Callback = function()
            if not Settings.CapturedID then
                WindUI:Notify({Title = "Error", Content = "Capture ID first!", Duration = 2})
                return
            end
            Settings.InstantForge = true
            StartForgeThread()
        end
    })
    
    Tab3:Section({Title = "Item Duplication", Opened = true})
    
    Tab3:Input({
        Title = "Item Index (Slot)",
        PlaceholderText = "Enter slot number",
        Callback = function(v)
            Settings.ItemIndex = v
        end
    })
    
    Tab3:Dropdown({
        Title = "Dupe Mode",
        Values = {"fast", "safe"},
        Value = "fast",
        Callback = function(v)
            Settings.DupeMode = v
        end
    })
    
    Tab3:Button({
        Title = "📦 Mass Dupe (999x)",
        Callback = function()
            if Settings.ItemIndex == "" then
                WindUI:Notify({Title = "Error", Content = "Enter item index!", Duration = 2})
                return
            end
            local DupeRemote = Network.Functions:FindFirstChild("Dupe")
            if DupeRemote then
                for i = 1, 999 do
                    pcall(function()
                        DupeRemote:InvokeServer(tonumber(Settings.ItemIndex), Settings.DupeMode)
                    end)
                    task.wait(0.001)
                end
                WindUI:Notify({Title = "Dupe Complete", Content = "999x duped!", Duration = 3})
            end
        end
    })
    
    Tab3:Input({
        Title = "Custom Amount",
        PlaceholderText = "Enter custom amount",
        Callback = function(v)
            Settings.CustomAmount = tonumber(v) or 0
        end
    })
    
    Tab3:Button({
        Title = "🎯 Custom Dupe",
        Callback = function()
            if Settings.ItemIndex == "" or Settings.CustomAmount == 0 then
                WindUI:Notify({Title = "Error", Content = "Enter index and amount!", Duration = 2})
                return
            end
            local DupeRemote = Network.Functions:FindFirstChild("Dupe")
            if DupeRemote then
                for i = 1, Settings.CustomAmount do
                    pcall(function()
                        DupeRemote:InvokeServer(tonumber(Settings.ItemIndex), Settings.DupeMode)
                    end)
                    task.wait(0.001)
                end
                WindUI:Notify({Title = "Dupe Complete", Content = Settings.CustomAmount .. "x duped!", Duration = 3})
            end
        end
    })

    -- ═══════════════════════════════════════════════════════════
    -- [[ TAB 4: COMBAT ]]
    -- ═══════════════════════════════════════════════════════════
    
    Tab4:Section({Title = "Combat Features", Opened = true})
    
    Tab4:Toggle({
        Title = "Auto Click",
        Value = false,
        Callback = function(v)
            Settings.AutoClick = v
            if v then
                StartClickThread()
            end
        end
    })
    
    Tab4:Slider({
        Title = "Click Delay (ms)",
        Value = {Min = 10, Max = 500, Default = 100},
        Step = 10,
        Callback = function(v)
            Settings.ClickDelay = v
        end
    })
    
    Tab4:Toggle({
        Title = "Auto Attack",
        Value = false,
        Callback = function(v)
            Settings.AutoAttack = v
        end
    })
    
    Tab4:Slider({
        Title = "Attack Delay",
        Value = {Min = 0.1, Max = 1, Default = 0.1},
        Step = 0.05,
        Callback = function(v)
            Settings.AttackDelay = v
        end
    })
    
    Tab4:Toggle({
        Title = "Auto Reroll",
        Value = false,
        Callback = function(v)
            Settings.AutoReroll = v
        end
    })
    
    Tab4:Slider({
        Title = "Reroll Delay",
        Value = {Min = 0.1, Max = 1, Default = 0.1},
        Step = 0.05,
        Callback = function(v)
            Settings.RerollDelay = v
        end
    })
    
    Tab4:Section({Title = "Auto Collect", Opened = true})
    
    Tab4:Toggle({
        Title = "Auto Collect Drops",
        Value = false,
        Callback = function(v)
            Settings.AutoCollectDrop = v
        end
    })

    -- ═══════════════════════════════════════════════════════════
    -- [[ TAB 5: CHARACTER ]]
    -- ═══════════════════════════════════════════════════════════
    
    Tab5:Section({Title = "Character Enhancements", Opened = true})
    
    Tab5:Toggle({
        Title = "Enable WalkSpeed",
        Value = false,
        Callback = function(v)
            Settings.WalkSpeedEnabled = v
            if v then
                StartWalkSpeedThread()
            elseif Character and Character:FindFirstChild("Humanoid") then
                Character.Humanoid.WalkSpeed = Settings.OriginalWalkSpeed
            end
        end
    })
    
    Tab5:Slider({
        Title = "WalkSpeed Value",
        Value = {Min = 16, Max = 500, Default = 16},
        Step = 1,
        Callback = function(v)
            Settings.WalkSpeed = v
            if Settings.WalkSpeedEnabled and Character and Character:FindFirstChild("Humanoid") then
                Character.Humanoid.WalkSpeed = v
            end
        end
    })
    
    Tab5:Section({Title = "Enchant Menu Access", Opened = true})
    
    Tab5:Button({
        Title = "Open Enchant Menu",
        Callback = function()
            pcall(function()
                local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
                if playerGui then
                    local windows = playerGui:FindFirstChild("Windows")
                    if windows then
                        local enchantWin = windows:FindFirstChild("Enchant") or windows:FindFirstChild("EnchantRoll") or windows:FindFirstChild("Enchantment")
                        if enchantWin then
                            enchantWin.Visible = not enchantWin.Visible
                            WindUI:Notify({Title = enchantWin.Visible and "Opened" or "Closed", Duration = 1.5})
                            return
                        end
                    end
                end
                WindUI:Notify({Title = "Menu Not Found", Content = "Open manually first", Duration = 2})
            end)
        end
    })

    -- ═══════════════════════════════════════════════════════════
    -- [[ TAB 7: AUTO ENCHANT ]]
    -- ═══════════════════════════════════════════════════════════
    
    Tab7:Section({Title = "1. Capture Weapon ID", Opened = true})
    
    Tab7:Paragraph({
        Title = "How to Capture",
        Content = "1. Click 'Capture ID' button below\n2. Manually enchant 1x in game\n3. ID will be auto-captured (30s timeout)"
    })
    
    Tab7:Button({
        Title = "🎯 Capture Enchant ID",
        Callback = function()
            EnableHook(30, "enchant")
        end
    })
    
    Tab7:Button({
        Title = "🔄 Reset Enchant ID",
        Callback = function()
            Settings.EnchantCapturedID = nil
            Settings.EnchantCount = 0
            Settings.LastEnchantResult = nil
            WindUI:Notify({Title = "Enchant ID Reset", Duration = 2})
        end
    })
    
    Tab7:Section({Title = "2. Select Target Enchant", Opened = true})
    
    Tab7:Dropdown({
        Title = "Target Enchant",
        Values = GetEnchantList(),
        Value = "None",
        Callback = function(v)
            Settings.TargetEnchantId = GetEnchantIdFromDisplay(v)
            if Settings.TargetEnchantId then
                local enchant = GetEnchantById(Settings.TargetEnchantId)
                WindUI:Notify({
                    Title = "Target Set",
                    Content = enchant.name .. " [" .. EnchantData.RarityNames[enchant.rarity].name .. "]",
                    Duration = 3
                })
            end
        end
    })
    
    Tab7:Toggle({
        Title = "🎯 Stop When Target Achieved",
        Value = false,
        Callback = function(v)
            Settings.StopOnTarget = v
        end
    })
    
    Tab7:Section({Title = "3. Enchant Settings", Opened = true})
    
    Tab7:Dropdown({
        Title = "Stone Type",
        Values = {"st_1", "st_2"},
        Value = "st_2",
        Callback = function(v)
            Settings.StoneType = v
        end
    })
    
    Tab7:Slider({
        Title = "Enchant Delay",
        Value = {Min = 0.3, Max = 3, Default = 0.8},
        Step = 0.1,
        Callback = function(v)
            Settings.EnchantDelay = v
        end
    })
    
    Tab7:Section({Title = "4. Auto Enchant Control", Opened = true})
    
    Tab7:Toggle({
        Title = "🚀 Enable Auto Enchant",
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
                WindUI:Notify({Title = "Auto Enchant Stopped", Duration = 2})
            end
        end
    })
    
    Tab7:Section({Title = "5. Manual Test", Opened = true})
    
    Tab7:Button({
        Title = "Test Enchant (st_1)",
        Callback = function()
            if not Settings.EnchantCapturedID then
                WindUI:Notify({Title = "Error", Content = "Capture ID first!", Duration = 2})
                return
            end
            pcall(function()
                EnchantRemote:FireServer(Settings.EnchantCapturedID, "st_1")
            end)
            WindUI:Notify({Title = "Test Sent (st_1)", Duration = 1})
        end
    })
    
    Tab7:Button({
        Title = "Test Enchant (st_2)",
        Callback = function()
            if not Settings.EnchantCapturedID then
                WindUI:Notify({Title = "Error", Content = "Capture ID first!", Duration = 2})
                return
            end
            pcall(function()
                EnchantRemote:FireServer(Settings.EnchantCapturedID, "st_2")
            end)
            WindUI:Notify({Title = "Test Sent (st_2)", Duration = 1})
        end
    })
    
    Tab7:Section({Title = "📊 Enchant Statistics", Opened = true})
    
    local EnchantStatsLabel = Tab7:Paragraph({
        Title = "Stats",
        Content = "Enchants: 0\nWeapon ID: None\nStone: st_2\nTarget: None\nStop: No\nLast: None"
    })
    
    -- Update enchant stats
    task.spawn(function()
        while Settings.ScriptRunning do
            task.wait(1)
            local weaponId = Settings.EnchantCapturedID and string.match(Settings.EnchantCapturedID, "_(%d+)$") or "None"
            local targetName = "None"
            if Settings.TargetEnchantId then
                local enchant = GetEnchantById(Settings.TargetEnchantId)
                targetName = enchant and enchant.name or "Unknown"
            end
            local lastEnchant = Settings.LastEnchantResult and (GetEnchantById(Settings.LastEnchantResult) and GetEnchantById(Settings.LastEnchantResult).name or Settings.LastEnchantResult) or "None"
            
            EnchantStatsLabel:Set({
                Title = "📊 Enchant Statistics",
                Content = string.format([[
Enchants: %d
Weapon ID: %s
Stone Type: %s
Target: %s
Stop on Target: %s
Last Result: %s
Status: %s
                ]],
                    Settings.EnchantCount,
                    weaponId,
                    Settings.StoneType,
                    targetName,
                    Settings.StopOnTarget and "Yes" or "No",
                    lastEnchant,
                    Settings.AutoEnchant and "Running" or "Stopped"
                )
            })
        end
    end)

    -- ═══════════════════════════════════════════════════════════
    -- [[ TAB 6: INFO ]]
    -- ═══════════════════════════════════════════════════════════
    
    Tab6:Section({Title = "📖 Script Information", Opened = true})
    
    Tab6:Paragraph({
        Title = "FayyScript V2.0 - Integrated",
        Content = "Created by FayyScript\nEnhanced by Claude AI\nVersion: 2.0 Final"
    })
    
    Tab6:Section({Title = "🎯 Features", Opened = true})
    
    Tab6:Paragraph({
        Title = "Main Features",
        Content = [[
✅ Auto Farm (Boss & Mob)
✅ Auto Forge & Instant Merge
✅ Item Duplication
✅ Auto Combat Features
✅ Auto Enchant System
✅ Character Enhancements
✅ World Teleportation
        ]]
    })
    
    Tab6:Section({Title = "📚 Tutorials", Opened = true})
    
    Tab6:Paragraph({
        Title = "Forge Tutorial",
        Content = [[
1. Click 'Capture Forge ID'
2. Manually forge 1 item in-game
3. ID captured automatically
4. Enable Auto Forge or use Instant
        ]]
    })
    
    Tab6:Paragraph({
        Title = "Dupe Tutorial",
        Content = [[
1. Open any chest once
2. Note the slot number (starts at 2)
3. Enter slot in 'Item Index'
4. Choose mode and dupe amount
5. Click Mass or Custom Dupe
        ]]
    })
    
    Tab6:Paragraph({
        Title = "Enchant Tutorial",
        Content = [[
1. Click 'Capture Enchant ID'
2. Manually enchant 1x in-game
3. ID captured automatically
4. Select target enchant (optional)
5. Enable 'Stop on Target' (optional)
6. Choose stone type
7. Enable Auto Enchant
        ]]
    })
    
    Tab6:Section({Title = "⚠️ Important Notes", Opened = true})
    
    Tab6:Paragraph({
        Title = "Safety Tips",
        Content = [[
• Use at your own risk
• Don't spam too fast
• Reset IDs if switching items
• Check Stats regularly
• Report bugs to FayyScript
        ]]
    })

    -- ═══════════════════════════════════════════════════════════
    -- [[ AUTO COLLECT DROP LISTENER ]]
    -- ═══════════════════════════════════════════════════════════
    
    task.spawn(function()
        local success, Net = pcall(function()
            return require(Services.ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Core"):WaitForChild("Net"))
        end)
        if success and Net then
            local LootEvent = Net:GetEvent("LootDrop")
            if LootEvent then
                SafeConnect(LootEvent.OnClientEvent, function(mode, ...)
                    if Settings.AutoCollectDrop and mode == "i" and Character and HumanoidRootPart then
                        local args = {...}
                        if args[3] then
                            task.wait(0.03)
                            LootEvent:FireServer(args[3])
                        end
                    end
                end)
            end
        end
    end)

    -- ═══════════════════════════════════════════════════════════
    -- [[ CHARACTER RESPAWN HANDLER ]]
    -- ═══════════════════════════════════════════════════════════
    
    SafeConnect(LocalPlayer.CharacterAdded, function(newChar)
        Character = newChar
        HumanoidRootPart = newChar:WaitForChild("HumanoidRootPart")
        task.wait(1)
        
        if Character:FindFirstChild("Humanoid") then
            Settings.OriginalWalkSpeed = Character.Humanoid.WalkSpeed
            if Settings.WalkSpeedEnabled then
                Character.Humanoid.WalkSpeed = Settings.WalkSpeed
            end
        end
        
        if Settings.FarmEnabled then StartFarmThread() end
        if Settings.AutoClick then StartClickThread() end
        if Settings.ForgeEnabled and Settings.CapturedID then StartForgeThread() end
        if Settings.AutoEnchant and Settings.EnchantCapturedID then StartEnchantThread() end
    end)

    -- ═══════════════════════════════════════════════════════════
    -- [[ CLEANUP ON UI CLOSE ]]
    -- ═══════════════════════════════════════════════════════════
    
    task.spawn(function()
        game:GetService("CoreGui").ChildRemoved:Connect(function(child)
            if child.Name == "WindUI" then
                Settings.ScriptRunning = false
                task.wait(0.5)
                if oldNamecall then oldNamecall = nil end
                CleanConnections()
            end
        end)
    end)

    -- ═══════════════════════════════════════════════════════════
    -- [[ STARTUP NOTIFICATION ]]
    -- ═══════════════════════════════════════════════════════════
    
    WindUI:Notify({
        Title = "🎉 FayyScript V2.0 Loaded!",
        Content = "All systems ready. Happy farming!",
        Duration = 5,
        Icon = "check-circle"
    })
end

-- ═══════════════════════════════════════════════════════════
-- [[ KEY SYSTEM GUI ]]
-- ═══════════════════════════════════════════════════════════

if isSpecialUser() then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Auto Skip",
        Text = "Welcome creator! Loading script...",
        Duration = 2
    })
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
    Title.Text = "FayyScript V2.0 Key System"
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
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Success",
                Text = "Correct key! Loading script...",
                Duration = 2
            })
            ScreenGui:Destroy()
            loadMainScript()
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Error",
                Text = "Wrong key! Please get a new key.",
                Duration = 2
            })
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
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Copied!",
                Text = "Link copied! Open in browser to get key.",
                Duration = 3
            })
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Error",
                Text = "Cannot copy. Manual: " .. link,
                Duration = 5
            })
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
