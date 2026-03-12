local function createDualKeySystemGUI()
    local ENCODED_KEY = {
       349,448,391,442,310,415,445,412,415,430,409,310,391,463,463
    }
    
    local function getValidKey()
        local key = ""
        for _, v in ipairs(ENCODED_KEY) do
            local ascii = (v - 100) / 3
            key = key .. string.char(ascii)
        end
        return key
    end

    local CONFIG = {
        LinkvertiseURL = "https://direct-link.net/3394206/Cskv8E28PbMY",
        LootLabsURL = "https://loot-link.com/s?3OL95Zns&data=7hDViHN3IUApLO81kcTWQvHhXlcGJbAaG6AHN%2BNM8%2Bu1mGCrlJzgWppe1cD/tzvY",
        MainScriptUrl = "https://raw.githubusercontent.com/FayyMeng/Star-Fishing/refs/heads/main/Star%20Fishing%20lua",
        DiscordURL = "https://discord.gg/Dz2BafGg7",
    }
    
    local COLORS = {
        Linkvertise = {
            Primary = Color3.fromRGB(255, 140, 0),
            Secondary = Color3.fromRGB(255, 165, 0),
            Text = Color3.fromRGB(255, 255, 255),
            Desc = Color3.fromRGB(255, 235, 200),
            BtnText = Color3.fromRGB(255, 140, 0),
        },
        LootLabs = {
            Primary = Color3.fromRGB(75, 0, 130),
            Secondary = Color3.fromRGB(106, 90, 205),
            Text = Color3.fromRGB(255, 255, 255),
            Desc = Color3.fromRGB(230, 220, 250),
            BtnText = Color3.fromRGB(75, 0, 130),
        },
        Discord = {
            Primary = Color3.fromRGB(88, 101, 242),
            Secondary = Color3.fromRGB(71, 82, 196),
            Text = Color3.fromRGB(255, 255, 255),
            Desc = Color3.fromRGB(210, 215, 255),
            BtnText = Color3.fromRGB(88, 101, 242),
        }
    }
    
    local VALID_KEY = getValidKey()
    local isMobile = game:GetService("UserInputService").TouchEnabled
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "FayyDualKeyGUI"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- ✅ UKURAN YANG LEBIH COMPACT UNTUK MOBILE
    local guiWidth = isMobile and 320 or 520
    local guiHeight = isMobile and 420 or 610

    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(0, guiWidth, 0, guiHeight)
    Container.Position = UDim2.new(0.5, -guiWidth/2, 0.5, -guiHeight/2)
    Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Container.BackgroundTransparency = 0.05
    Container.BorderSizePixel = 0
    Container.ClipsDescendants = true
    Container.Parent = ScreenGui

    local ContainerGradient = Instance.new("UIGradient")
    ContainerGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(250, 250, 255)),
        ColorSequenceKeypoint.new(0.7, Color3.fromRGB(235, 240, 250)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 225, 240))
    })
    ContainerGradient.Rotation = 135
    ContainerGradient.Parent = Container

    local Shadow = Instance.new("ImageLabel")
    Shadow.Size = UDim2.new(1, 20, 1, 20)
    Shadow.Position = UDim2.new(0, -10, 0, -10)
    Shadow.BackgroundTransparency = 1
    Shadow.Image = "rbxassetid://6014261993"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.6
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(10, 10, 10, 10)
    Shadow.Parent = Container

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, isMobile and 12 or 16)
    Corner.Parent = Container

    -- LEFT PANEL (SIDEBAR) - DIKECILKAN UNTUK MOBILE
    local LeftPanel = Instance.new("Frame")
    LeftPanel.Size = UDim2.new(0, isMobile and 50 or 80, 1, 0)
    LeftPanel.BackgroundColor3 = Color3.fromRGB(10, 20, 40)
    LeftPanel.BorderSizePixel = 0
    LeftPanel.Parent = Container

    local LeftPanelCorner = Instance.new("UICorner")
    LeftPanelCorner.CornerRadius = UDim.new(0, isMobile and 12 or 16)
    LeftPanelCorner.Parent = LeftPanel

    local LeftPanelGradient = Instance.new("UIGradient")
    LeftPanelGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 25, 45)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 35, 60))
    })
    LeftPanelGradient.Rotation = 180
    LeftPanelGradient.Parent = LeftPanel

    local LogoFrame = Instance.new("Frame")
    LogoFrame.Size = UDim2.new(0, isMobile and 30 or 50, 0, isMobile and 30 or 50)
    LogoFrame.Position = UDim2.new(0.5, isMobile and -15 or -25, 0, isMobile and 10 or 15)
    LogoFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    LogoFrame.BackgroundTransparency = 0.1
    LogoFrame.BorderSizePixel = 0
    LogoFrame.Parent = LeftPanel

    local LogoCorner = Instance.new("UICorner")
    LogoCorner.CornerRadius = UDim.new(0, isMobile and 15 or 25)
    LogoCorner.Parent = LogoFrame

    local LogoGradient = Instance.new("UIGradient")
    LogoGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(220, 225, 240)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
    })
    LogoGradient.Rotation = 45
    LogoGradient.Parent = LogoFrame

    local LogoText = Instance.new("TextLabel")
    LogoText.Size = UDim2.new(1, 0, 1, 0)
    LogoText.BackgroundTransparency = 1
    LogoText.Text = "🔑"
    LogoText.TextColor3 = Color3.fromRGB(20, 30, 50)
    LogoText.Font = Enum.Font.GothamBold
    LogoText.TextSize = isMobile and 16 or 28
    LogoText.Parent = LogoFrame

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, isMobile and 12 or 20)
    Title.Position = UDim2.new(0, 0, 0, isMobile and 45 or 70)
    Title.BackgroundTransparency = 1
    Title.Text = "FAYY"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = isMobile and 10 or 16
    Title.Parent = LeftPanel

    local Title2 = Instance.new("TextLabel")
    Title2.Size = UDim2.new(1, 0, 0, isMobile and 12 or 20)
    Title2.Position = UDim2.new(0, 0, 0, isMobile and 56 or 88)
    Title2.BackgroundTransparency = 1
    Title2.Text = "SCRIPT"
    Title2.TextColor3 = Color3.fromRGB(180, 200, 230)
    Title2.Font = Enum.Font.GothamBold
    Title2.TextSize = isMobile and 9 or 14
    Title2.Parent = LeftPanel

    local Version = Instance.new("TextLabel")
    Version.Size = UDim2.new(1, 0, 0, 15)
    Version.Position = UDim2.new(0, 0, 1, isMobile and -18 or -25)
    Version.BackgroundTransparency = 1
    Version.Text = "v3.0"
    Version.TextColor3 = Color3.fromRGB(150, 170, 200)
    Version.Font = Enum.Font.Gotham
    Version.TextSize = isMobile and 8 or 10
    Version.Parent = LeftPanel

    -- CONTENT AREA - LEBIH LEBAR UNTUK MOBILE
    local Content = Instance.new("Frame")
    Content.Size = UDim2.new(1, isMobile and -55 or -90, 1, -16)
    Content.Position = UDim2.new(0, isMobile and 55 or 85, 0, 8)
    Content.BackgroundTransparency = 1
    Content.Parent = Container

    -- CLOSE BUTTON
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, isMobile and 22 or 30, 0, isMobile and 22 or 30)
    CloseBtn.Position = UDim2.new(1, isMobile and -26 or -35, 0, -4)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.BackgroundTransparency = 0.2
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(20, 30, 50)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = isMobile and 11 or 16
    CloseBtn.Parent = Content

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, isMobile and 6 or 8)
    CloseCorner.Parent = CloseBtn

    CloseBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- ANNOUNCEMENT BANNER - LEBIH PENDEK UNTUK MOBILE
    local AnnouncementFrame = Instance.new("Frame")
    AnnouncementFrame.Size = UDim2.new(1, -8, 0, isMobile and 36 or 60)
    AnnouncementFrame.Position = UDim2.new(0, 4, 0, 0)
    AnnouncementFrame.BackgroundColor3 = Color3.fromRGB(25, 35, 60)
    AnnouncementFrame.BackgroundTransparency = 0.1
    AnnouncementFrame.BorderSizePixel = 0
    AnnouncementFrame.Parent = Content

    local AnnouncementCorner = Instance.new("UICorner")
    AnnouncementCorner.CornerRadius = UDim.new(0, isMobile and 6 or 10)
    AnnouncementCorner.Parent = AnnouncementFrame

    local AnnouncementGradient = Instance.new("UIGradient")
    AnnouncementGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 55, 90)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 35, 65))
    })
    AnnouncementGradient.Rotation = 90
    AnnouncementGradient.Parent = AnnouncementFrame

    local AnnouncementIcon = Instance.new("TextLabel")
    AnnouncementIcon.Size = UDim2.new(0, isMobile and 20 or 30, 0, isMobile and 20 or 30)
    AnnouncementIcon.Position = UDim2.new(0, isMobile and 6 or 12, 0.5, isMobile and -10 or -15)
    AnnouncementIcon.BackgroundTransparency = 1
    AnnouncementIcon.Text = "📢"
    AnnouncementIcon.TextColor3 = Color3.fromRGB(255, 220, 100)
    AnnouncementIcon.Font = Enum.Font.GothamBold
    AnnouncementIcon.TextSize = isMobile and 14 or 22
    AnnouncementIcon.Parent = AnnouncementFrame

    local AnnouncementText = Instance.new("TextLabel")
    AnnouncementText.Size = UDim2.new(1, isMobile and -28 or -45, 1, -4)
    AnnouncementText.Position = UDim2.new(0, isMobile and 28 or 45, 0, 2)
    AnnouncementText.BackgroundTransparency = 1
    AnnouncementText.Text = "Choose your preferred method to get the key!"
    AnnouncementText.TextColor3 = Color3.fromRGB(255, 255, 255)
    AnnouncementText.Font = Enum.Font.Gotham
    AnnouncementText.TextSize = isMobile and 8 or 11
    AnnouncementText.TextWrapped = true
    AnnouncementText.TextXAlignment = Enum.TextXAlignment.Left
    AnnouncementText.TextYAlignment = Enum.TextYAlignment.Center
    AnnouncementText.Parent = AnnouncementFrame

    -- WELCOME TEXT - LEBIH COMPACT
    local Welcome = Instance.new("TextLabel")
    Welcome.Size = UDim2.new(1, 0, 0, isMobile and 14 or 20)
    Welcome.Position = UDim2.new(0, 0, 0, isMobile and 40 or 70)
    Welcome.BackgroundTransparency = 1
    Welcome.Text = "Get Key First,"
    Welcome.TextColor3 = Color3.fromRGB(80, 90, 110)
    Welcome.Font = Enum.Font.Gotham
    Welcome.TextSize = isMobile and 9 or 13
    Welcome.TextXAlignment = Enum.TextXAlignment.Left
    Welcome.Parent = Content

    -- USERNAME
    local UserName = Instance.new("TextLabel")
    UserName.Size = UDim2.new(1, 0, 0, isMobile and 18 or 28)
    UserName.Position = UDim2.new(0, 0, 0, isMobile and 52 or 88)
    UserName.BackgroundTransparency = 1
    UserName.Text = "Star Fishing"
    UserName.TextColor3 = Color3.fromRGB(30, 40, 60)
    UserName.Font = Enum.Font.GothamBold
    UserName.TextSize = isMobile and 14 or 22
    UserName.TextXAlignment = Enum.TextXAlignment.Left
    UserName.Parent = Content

    -- METHOD 1: LINKVERTISE - UKURAN DIKECILKAN
    local Method1Frame = Instance.new("Frame")
    Method1Frame.Size = UDim2.new(1, -8, 0, isMobile and 55 or 85)
    Method1Frame.Position = UDim2.new(0, 4, 0, isMobile and 72 or 120)
    Method1Frame.BackgroundColor3 = COLORS.Linkvertise.Primary
    Method1Frame.BackgroundTransparency = 0.1
    Method1Frame.BorderSizePixel = 0
    Method1Frame.Parent = Content

    local Method1Corner = Instance.new("UICorner")
    Method1Corner.CornerRadius = UDim.new(0, isMobile and 8 or 12)
    Method1Corner.Parent = Method1Frame

    local Method1Gradient = Instance.new("UIGradient")
    Method1Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, COLORS.Linkvertise.Primary),
        ColorSequenceKeypoint.new(1, COLORS.Linkvertise.Secondary)
    })
    Method1Gradient.Rotation = 135
    Method1Gradient.Parent = Method1Frame

    local Method1Icon = Instance.new("TextLabel")
    Method1Icon.Size = UDim2.new(0, isMobile and 24 or 40, 0, isMobile and 24 or 40)
    Method1Icon.Position = UDim2.new(0, isMobile and 8 or 15, 0.5, isMobile and -12 or -20)
    Method1Icon.BackgroundTransparency = 1
    Method1Icon.Text = "🔗"
    Method1Icon.TextColor3 = COLORS.Linkvertise.Text
    Method1Icon.Font = Enum.Font.GothamBold
    Method1Icon.TextSize = isMobile and 16 or 28
    Method1Icon.Parent = Method1Frame

    local Method1Title = Instance.new("TextLabel")
    Method1Title.Size = UDim2.new(1, isMobile and -90 or -65, 0, 18)
    Method1Title.Position = UDim2.new(0, isMobile and 36 or 60, 0, isMobile and 8 or 12)
    Method1Title.BackgroundTransparency = 1
    Method1Title.Text = "Linkvertise"
    Method1Title.TextColor3 = COLORS.Linkvertise.Text
    Method1Title.Font = Enum.Font.GothamBold
    Method1Title.TextSize = isMobile and 11 or 15
    Method1Title.TextXAlignment = Enum.TextXAlignment.Left
    Method1Title.Parent = Method1Frame

    local Method1Desc = Instance.new("TextLabel")
    Method1Desc.Size = UDim2.new(1, isMobile and -90 or -65, 0, 16)
    Method1Desc.Position = UDim2.new(0, isMobile and 36 or 60, 0, isMobile and 24 or 35)
    Method1Desc.BackgroundTransparency = 1
    Method1Desc.Text = "Get key via Linkvertise"
    Method1Desc.TextColor3 = COLORS.Linkvertise.Desc
    Method1Desc.Font = Enum.Font.Gotham
    Method1Desc.TextSize = isMobile and 8 or 11
    Method1Desc.TextXAlignment = Enum.TextXAlignment.Left
    Method1Desc.TextWrapped = true
    Method1Desc.Parent = Method1Frame

    local Method1Btn = Instance.new("TextButton")
    Method1Btn.Size = UDim2.new(0, isMobile and 60 or 90, 0, isMobile and 26 or 32)
    Method1Btn.Position = UDim2.new(1, isMobile and -68 or -105, 0.5, isMobile and -13 or -16)
    Method1Btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Method1Btn.Text = "GET KEY"
    Method1Btn.TextColor3 = COLORS.Linkvertise.BtnText
    Method1Btn.Font = Enum.Font.GothamBold
    Method1Btn.TextSize = isMobile and 9 or 12
    Method1Btn.Parent = Method1Frame

    local Method1BtnCorner = Instance.new("UICorner")
    Method1BtnCorner.CornerRadius = UDim.new(0, isMobile and 6 or 8)
    Method1BtnCorner.Parent = Method1Btn

    -- METHOD 2: LOOTLABS - UKURAN DIKECILKAN
    local Method2Frame = Instance.new("Frame")
    Method2Frame.Size = UDim2.new(1, -8, 0, isMobile and 55 or 85)
    Method2Frame.Position = UDim2.new(0, 4, 0, isMobile and 130 or 210)
    Method2Frame.BackgroundColor3 = COLORS.LootLabs.Primary
    Method2Frame.BackgroundTransparency = 0.1
    Method2Frame.BorderSizePixel = 0
    Method2Frame.Parent = Content

    local Method2Corner = Instance.new("UICorner")
    Method2Corner.CornerRadius = UDim.new(0, isMobile and 8 or 12)
    Method2Corner.Parent = Method2Frame

    local Method2Gradient = Instance.new("UIGradient")
    Method2Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, COLORS.LootLabs.Primary),
        ColorSequenceKeypoint.new(1, COLORS.LootLabs.Secondary)
    })
    Method2Gradient.Rotation = 135
    Method2Gradient.Parent = Method2Frame

    local Method2Icon = Instance.new("TextLabel")
    Method2Icon.Size = UDim2.new(0, isMobile and 24 or 40, 0, isMobile and 24 or 40)
    Method2Icon.Position = UDim2.new(0, isMobile and 8 or 15, 0.5, isMobile and -12 or -20)
    Method2Icon.BackgroundTransparency = 1
    Method2Icon.Text = "💎"
    Method2Icon.TextColor3 = COLORS.LootLabs.Text
    Method2Icon.Font = Enum.Font.GothamBold
    Method2Icon.TextSize = isMobile and 16 or 28
    Method2Icon.Parent = Method2Frame

    local Method2Title = Instance.new("TextLabel")
    Method2Title.Size = UDim2.new(1, isMobile and -90 or -65, 0, 18)
    Method2Title.Position = UDim2.new(0, isMobile and 36 or 60, 0, isMobile and 8 or 12)
    Method2Title.BackgroundTransparency = 1
    Method2Title.Text = "LootLabs"
    Method2Title.TextColor3 = COLORS.LootLabs.Text
    Method2Title.Font = Enum.Font.GothamBold
    Method2Title.TextSize = isMobile and 11 or 15
    Method2Title.TextXAlignment = Enum.TextXAlignment.Left
    Method2Title.Parent = Method2Frame

    local Method2Desc = Instance.new("TextLabel")
    Method2Desc.Size = UDim2.new(1, isMobile and -90 or -65, 0, 16)
    Method2Desc.Position = UDim2.new(0, isMobile and 36 or 60, 0, isMobile and 24 or 35)
    Method2Desc.BackgroundTransparency = 1
    Method2Desc.Text = "Get key via LootLabs"
    Method2Desc.TextColor3 = COLORS.LootLabs.Desc
    Method2Desc.Font = Enum.Font.Gotham
    Method2Desc.TextSize = isMobile and 8 or 11
    Method2Desc.TextXAlignment = Enum.TextXAlignment.Left
    Method2Desc.TextWrapped = true
    Method2Desc.Parent = Method2Frame

    local Method2Btn = Instance.new("TextButton")
    Method2Btn.Size = UDim2.new(0, isMobile and 60 or 90, 0, isMobile and 26 or 32)
    Method2Btn.Position = UDim2.new(1, isMobile and -68 or -105, 0.5, isMobile and -13 or -16)
    Method2Btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Method2Btn.Text = "GET KEY"
    Method2Btn.TextColor3 = COLORS.LootLabs.BtnText
    Method2Btn.Font = Enum.Font.GothamBold
    Method2Btn.TextSize = isMobile and 9 or 12
    Method2Btn.Parent = Method2Frame

    local Method2BtnCorner = Instance.new("UICorner")
    Method2BtnCorner.CornerRadius = UDim.new(0, isMobile and 6 or 8)
    Method2BtnCorner.Parent = Method2Btn

    -- METHOD 3: DISCORD - UKURAN DIKECILKAN
    local DiscordFrame = Instance.new("Frame")
    DiscordFrame.Size = UDim2.new(1, -8, 0, isMobile and 40 or 65)
    DiscordFrame.Position = UDim2.new(0, 4, 0, isMobile and 188 or 300)
    DiscordFrame.BackgroundColor3 = COLORS.Discord.Primary
    DiscordFrame.BackgroundTransparency = 0.1
    DiscordFrame.BorderSizePixel = 0
    DiscordFrame.Parent = Content

    local DiscordCorner = Instance.new("UICorner")
    DiscordCorner.CornerRadius = UDim.new(0, isMobile and 8 or 12)
    DiscordCorner.Parent = DiscordFrame

    local DiscordGradient = Instance.new("UIGradient")
    DiscordGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, COLORS.Discord.Primary),
        ColorSequenceKeypoint.new(1, COLORS.Discord.Secondary)
    })
    DiscordGradient.Rotation = 135
    DiscordGradient.Parent = DiscordFrame

    local DiscordIcon = Instance.new("TextLabel")
    DiscordIcon.Size = UDim2.new(0, isMobile and 24 or 40, 0, isMobile and 24 or 40)
    DiscordIcon.Position = UDim2.new(0, isMobile and 8 or 15, 0.5, isMobile and -12 or -20)
    DiscordIcon.BackgroundTransparency = 1
    DiscordIcon.Text = "🎮"
    DiscordIcon.TextColor3 = COLORS.Discord.Text
    DiscordIcon.Font = Enum.Font.GothamBold
    DiscordIcon.TextSize = isMobile and 16 or 28
    DiscordIcon.Parent = DiscordFrame

    local DiscordTitle = Instance.new("TextLabel")
    DiscordTitle.Size = UDim2.new(1, isMobile and -90 or -65, 0, 16)
    DiscordTitle.Position = UDim2.new(0, isMobile and 36 or 60, 0, isMobile and 4 or 10)
    DiscordTitle.BackgroundTransparency = 1
    DiscordTitle.Text = "Join Discord"
    DiscordTitle.TextColor3 = COLORS.Discord.Text
    DiscordTitle.Font = Enum.Font.GothamBold
    DiscordTitle.TextSize = isMobile and 11 or 15
    DiscordTitle.TextXAlignment = Enum.TextXAlignment.Left
    DiscordTitle.Parent = DiscordFrame

    local DiscordDesc = Instance.new("TextLabel")
    DiscordDesc.Size = UDim2.new(1, isMobile and -90 or -65, 0, 14)
    DiscordDesc.Position = UDim2.new(0, isMobile and 36 or 60, 0, isMobile and 20 or 32)
    DiscordDesc.BackgroundTransparency = 1
    DiscordDesc.Text = "Updates & support!"
    DiscordDesc.TextColor3 = COLORS.Discord.Desc
    DiscordDesc.Font = Enum.Font.Gotham
    DiscordDesc.TextSize = isMobile and 8 or 11
    DiscordDesc.TextXAlignment = Enum.TextXAlignment.Left
    DiscordDesc.TextWrapped = true
    DiscordDesc.Parent = DiscordFrame

    local DiscordBtn = Instance.new("TextButton")
    DiscordBtn.Size = UDim2.new(0, isMobile and 60 or 90, 0, isMobile and 26 or 32)
    DiscordBtn.Position = UDim2.new(1, isMobile and -68 or -105, 0.5, isMobile and -13 or -16)
    DiscordBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    DiscordBtn.Text = "JOIN"
    DiscordBtn.TextColor3 = COLORS.Discord.BtnText
    DiscordBtn.Font = Enum.Font.GothamBold
    DiscordBtn.TextSize = isMobile and 9 or 12
    DiscordBtn.Parent = DiscordFrame

    local DiscordBtnCorner = Instance.new("UICorner")
    DiscordBtnCorner.CornerRadius = UDim.new(0, isMobile and 6 or 8)
    DiscordBtnCorner.Parent = DiscordBtn

    -- KEY INPUT SECTION - LEBIH COMPACT
    local KeyFrame = Instance.new("Frame")
    KeyFrame.Size = UDim2.new(1, -8, 0, isMobile and 70 or 95)
    KeyFrame.Position = UDim2.new(0, 4, 0, isMobile and 232 or 370)
    KeyFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    KeyFrame.BackgroundTransparency = 0.3
    KeyFrame.BorderSizePixel = 0
    KeyFrame.Parent = Content

    local KeyFrameCorner = Instance.new("UICorner")
    KeyFrameCorner.CornerRadius = UDim.new(0, isMobile and 8 or 12)
    KeyFrameCorner.Parent = KeyFrame

    local KeyFrameGradient = Instance.new("UIGradient")
    KeyFrameGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(250, 250, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(235, 240, 250))
    })
    KeyFrameGradient.Rotation = 90
    KeyFrameGradient.Parent = KeyFrame

    local KeyIcon = Instance.new("TextLabel")
    KeyIcon.Size = UDim2.new(0, isMobile and 18 or 25, 0, isMobile and 18 or 25)
    KeyIcon.Position = UDim2.new(0, isMobile and 8 or 12, 0, isMobile and 6 or 10)
    KeyIcon.BackgroundTransparency = 1
    KeyIcon.Text = "🔐"
    KeyIcon.TextColor3 = Color3.fromRGB(30, 40, 60)
    KeyIcon.Font = Enum.Font.Gotham
    KeyIcon.TextSize = isMobile and 14 or 20
    KeyIcon.Parent = KeyFrame

    local KeyLabel = Instance.new("TextLabel")
    KeyLabel.Size = UDim2.new(1, -30, 0, 16)
    KeyLabel.Position = UDim2.new(0, isMobile and 30 or 42, 0, isMobile and 4 or 8)
    KeyLabel.BackgroundTransparency = 1
    KeyLabel.Text = "ENTER YOUR KEY"
    KeyLabel.TextColor3 = Color3.fromRGB(80, 90, 110)
    KeyLabel.Font = Enum.Font.GothamBold
    KeyLabel.TextSize = isMobile and 9 or 12
    KeyLabel.TextXAlignment = Enum.TextXAlignment.Left
    KeyLabel.Parent = KeyFrame

    local KeyInput = Instance.new("TextBox")
    KeyInput.Size = UDim2.new(1, -16, 0, isMobile and 28 or 38)
    KeyInput.Position = UDim2.new(0, 8, 0, isMobile and 32 or 45)
    KeyInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    KeyInput.BackgroundTransparency = 0.5
    KeyInput.PlaceholderText = "Paste your key here..."
    KeyInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 160)
    KeyInput.Text = ""
    KeyInput.TextColor3 = Color3.fromRGB(20, 30, 50)
    KeyInput.Font = Enum.Font.Gotham
    KeyInput.TextSize = isMobile and 10 or 13
    KeyInput.ClearTextOnFocus = false
    KeyInput.Parent = KeyFrame

    local KeyInputCorner = Instance.new("UICorner")
    KeyInputCorner.CornerRadius = UDim.new(0, isMobile and 6 or 8)
    KeyInputCorner.Parent = KeyInput

    -- BUTTONS ROW - LEBIH COMPACT
    local BottomRow = Instance.new("Frame")
    BottomRow.Size = UDim2.new(1, -8, 0, isMobile and 60 or 85)
    BottomRow.Position = UDim2.new(0, 4, 0, isMobile and 306 or 470)
    BottomRow.BackgroundTransparency = 1
    BottomRow.Parent = Content

    local SubmitBtn = Instance.new("TextButton")
    SubmitBtn.Size = UDim2.new(0.5, -3, 0, isMobile and 32 or 40)
    SubmitBtn.Position = UDim2.new(0, 0, 0, 0)
    SubmitBtn.BackgroundColor3 = Color3.fromRGB(25, 35, 60)
    SubmitBtn.Text = "SUBMIT KEY"
    SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubmitBtn.Font = Enum.Font.GothamBold
    SubmitBtn.TextSize = isMobile and 10 or 13
    SubmitBtn.Parent = BottomRow

    local SubmitCorner = Instance.new("UICorner")
    SubmitCorner.CornerRadius = UDim.new(0, isMobile and 6 or 10)
    SubmitCorner.Parent = SubmitBtn

    local ClearBtn = Instance.new("TextButton")
    ClearBtn.Size = UDim2.new(0.5, -3, 0, isMobile and 32 or 40)
    ClearBtn.Position = UDim2.new(0.5, 3, 0, 0)
    ClearBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ClearBtn.BackgroundTransparency = 0.3
    ClearBtn.Text = "CLEAR"
    ClearBtn.TextColor3 = Color3.fromRGB(100, 80, 80)
    ClearBtn.Font = Enum.Font.Gotham
    ClearBtn.TextSize = isMobile and 10 or 13
    ClearBtn.Parent = BottomRow

    local ClearCorner = Instance.new("UICorner")
    ClearCorner.CornerRadius = UDim.new(0, isMobile and 6 or 10)
    ClearCorner.Parent = ClearBtn

    local StatusLabel = Instance.new("TextLabel")
    StatusLabel.Size = UDim2.new(1, 0, 0, 20)
    StatusLabel.Position = UDim2.new(0, 0, 0, isMobile and 38 or 48)
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.Text = "✨ Choose method above to get key"
    StatusLabel.TextColor3 = Color3.fromRGB(100, 110, 130)
    StatusLabel.Font = Enum.Font.Gotham
    StatusLabel.TextSize = isMobile and 8 or 11
    StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
    StatusLabel.Parent = BottomRow

    -- FUNCTIONS
    local function copyToClipboard(text, btn, originalText, successColor)
        if setclipboard then
            setclipboard(text)
            btn.Text = "✓ COPIED"
            btn.BackgroundColor3 = successColor
            StatusLabel.Text = "✅ Link copied! Paste in browser"
            StatusLabel.TextColor3 = Color3.fromRGB(30, 140, 100)
            
            task.wait(2)
            btn.Text = originalText
            btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            StatusLabel.Text = "✨ Choose method above to get key"
            StatusLabel.TextColor3 = Color3.fromRGB(100, 110, 130)
        else
            StatusLabel.Text = "❌ Clipboard not supported!"
            StatusLabel.TextColor3 = Color3.fromRGB(200, 70, 70)
        end
    end

    -- Method 1: Linkvertise
    Method1Btn.MouseButton1Click:Connect(function()
        copyToClipboard(CONFIG.LinkvertiseURL, Method1Btn, "GET KEY", COLORS.Linkvertise.Primary)
    end)

    -- Method 2: LootLabs
    Method2Btn.MouseButton1Click:Connect(function()
        copyToClipboard(CONFIG.LootLabsURL, Method2Btn, "GET KEY", COLORS.LootLabs.Primary)
    end)

    -- Method 3: Discord
    DiscordBtn.MouseButton1Click:Connect(function()
        copyToClipboard(CONFIG.DiscordURL, DiscordBtn, "JOIN", COLORS.Discord.Primary)
        StatusLabel.Text = "🎮 Discord link copied! Paste in browser"
        StatusLabel.TextColor3 = Color3.fromRGB(88, 101, 242)
    end)

    ClearBtn.MouseButton1Click:Connect(function()
        KeyInput.Text = ""
        StatusLabel.Text = "🗑️ Input cleared"
        StatusLabel.TextColor3 = Color3.fromRGB(200, 130, 50)
        
        task.wait(1.5)
        StatusLabel.Text = "✨ Choose method above to get key"
        StatusLabel.TextColor3 = Color3.fromRGB(100, 110, 130)
    end)

    SubmitBtn.MouseButton1Click:Connect(function()
        local userKey = KeyInput.Text:gsub("%s+", "")
        
        if userKey == "" then
            StatusLabel.Text = "❌ Key cannot be empty!"
            StatusLabel.TextColor3 = Color3.fromRGB(200, 70, 70)
            return
        end
        
        StatusLabel.Text = "🔍 Verifying key..."
        StatusLabel.TextColor3 = Color3.fromRGB(240, 180, 50)
        
        task.spawn(function()
            if userKey == VALID_KEY then
                StatusLabel.Text = "✅ Key valid! Loading..."
                StatusLabel.TextColor3 = Color3.fromRGB(30, 140, 100)
                
                task.wait(1)
                ScreenGui:Destroy()
                
                local success, err = pcall(function()
                    loadstring(game:HttpGet(CONFIG.MainScriptUrl, true))()
                end)
                
                if not success then
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "Error",
                        Text = "Failed to load main script!",
                        Duration = 3
                    })
                end
            else
                StatusLabel.Text = "❌ Invalid key!"
                StatusLabel.TextColor3 = Color3.fromRGB(200, 70, 70)
                
                task.wait(2)
                StatusLabel.Text = "✨ Choose method above to get key"
                StatusLabel.TextColor3 = Color3.fromRGB(100, 110, 130)
            end
        end)
    end)

    KeyInput.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            SubmitBtn.MouseButton1Click:Fire()
        end
    end)
end

createDualKeySystemGUI()
