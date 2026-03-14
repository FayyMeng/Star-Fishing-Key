local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer or {UserId = 0}

local ENCODED_KEY = {
    349,448,391,442,310,415,445,412,415,430,409,250,244,250,262
}

local function getValidKey()
    local key = ""
    for _, v in ipairs(ENCODED_KEY) do
        local ascii = (v - 100) / 3
        key = key .. string.char(math.floor(ascii))
    end
    return key
end

local VALID_KEY = getValidKey()

local KEY_FILE = "fayy_auth_" .. tostring(LocalPlayer.UserId) .. ".dat"

local function isAlreadyAuthenticated()
    if not isfile or not isfile(KEY_FILE) then return false end
    local success, saved = pcall(readfile, KEY_FILE)
    if not success or not saved or saved == "" then return false end
    return saved:match("^%s*(.-)%s*$") == VALID_KEY
end

local function saveAuthentication(key)
    if writefile then
        pcall(function()
            writefile(KEY_FILE, key)
        end)
    end
end

if isAlreadyAuthenticated() then
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/FayyMeng/Star-Fishing/refs/heads/main/Star%20Fishing%20lua", true))()
    end)
    return
end

local function createSingleKeySystemGUI()
    local CONFIG = {
        LootLabsURL = "https://loot-link.com/s?LAjHExf0&data=7hDViHN3IUApLO81kcTWQkRXb6A%2B3GVKwgACTu5OaqqI757Wy5%2BiBiwU%2BVh7vv8R",
        MainScriptUrl = "https://raw.githubusercontent.com/FayyMeng/Star-Fishing/refs/heads/main/Star%20Fishing%20lua",
        DiscordURL = "https://discord.gg/Dz2BafGg7",
    }
   
    local COLORS = {
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
   
    local isMobile = game:GetService("UserInputService").TouchEnabled
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "FayyKeyGUI"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local guiWidth = isMobile and 320 or 460
    local guiHeight = isMobile and 420 or 520

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

    local Content = Instance.new("Frame")
    Content.Size = UDim2.new(1, isMobile and -55 or -90, 1, -16)
    Content.Position = UDim2.new(0, isMobile and 55 or 85, 0, 8)
    Content.BackgroundTransparency = 1
    Content.Parent = Container

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

    local AnnouncementFrame = Instance.new("Frame")
    AnnouncementFrame.Size = UDim2.new(1, -8, 0, isMobile and 36 or 50)
    AnnouncementFrame.Position = UDim2.new(0, 4, 0, 0)
    AnnouncementFrame.BackgroundColor3 = Color3.fromRGB(25, 35, 60)
    AnnouncementFrame.BackgroundTransparency = 0.1
    AnnouncementFrame.BorderSizePixel = 0
    AnnouncementFrame.Parent = Content

    local AnnouncementCorner = Instance.new("UICorner")
    AnnouncementCorner.CornerRadius = UDim.new(0, isMobile and 6 or 10)
    AnnouncementCorner.Parent = AnnouncementFrame

    local AnnouncementIcon = Instance.new("TextLabel")
    AnnouncementIcon.Size = UDim2.new(0, isMobile and 20 or 26, 0, isMobile and 20 or 26)
    AnnouncementIcon.Position = UDim2.new(0, isMobile and 8 or 12, 0.5, isMobile and -10 or -13)
    AnnouncementIcon.BackgroundTransparency = 1
    AnnouncementIcon.Text = "📢"
    AnnouncementIcon.TextColor3 = Color3.fromRGB(255, 220, 100)
    AnnouncementIcon.Font = Enum.Font.GothamBold
    AnnouncementIcon.TextSize = isMobile and 14 or 20
    AnnouncementIcon.Parent = AnnouncementFrame

    local AnnouncementText = Instance.new("TextLabel")
    AnnouncementText.Size = UDim2.new(1, isMobile and -36 or -46, 1, -4)
    AnnouncementText.Position = UDim2.new(0, isMobile and 36 or 46, 0, 2)
    AnnouncementText.BackgroundTransparency = 1
    AnnouncementText.Text = "Get key using the button below!"
    AnnouncementText.TextColor3 = Color3.fromRGB(255, 255, 255)
    AnnouncementText.Font = Enum.Font.Gotham
    AnnouncementText.TextSize = isMobile and 9 or 11
    AnnouncementText.TextWrapped = true
    AnnouncementText.TextXAlignment = Enum.TextXAlignment.Left
    AnnouncementText.Parent = AnnouncementFrame

    local Welcome = Instance.new("TextLabel")
    Welcome.Size = UDim2.new(1, 0, 0, isMobile and 16 or 22)
    Welcome.Position = UDim2.new(0, 0, 0, isMobile and 50 or 60)
    Welcome.BackgroundTransparency = 1
    Welcome.Text = "Get Key First,"
    Welcome.TextColor3 = Color3.fromRGB(80, 90, 110)
    Welcome.Font = Enum.Font.Gotham
    Welcome.TextSize = isMobile and 10 or 14
    Welcome.TextXAlignment = Enum.TextXAlignment.Left
    Welcome.Parent = Content

    local UserName = Instance.new("TextLabel")
    UserName.Size = UDim2.new(1, 0, 0, isMobile and 22 or 32)
    UserName.Position = UDim2.new(0, 0, 0, isMobile and 68 or 85)
    UserName.BackgroundTransparency = 1
    UserName.Text = "Star Fishing"
    UserName.TextColor3 = Color3.fromRGB(30, 40, 60)
    UserName.Font = Enum.Font.GothamBold
    UserName.TextSize = isMobile and 16 or 24
    UserName.TextXAlignment = Enum.TextXAlignment.Left
    UserName.Parent = Content

    local MethodFrame = Instance.new("Frame")
    MethodFrame.Size = UDim2.new(1, -8, 0, isMobile and 60 or 90)
    MethodFrame.Position = UDim2.new(0, 4, 0, isMobile and 100 or 125)
    MethodFrame.BackgroundColor3 = COLORS.LootLabs.Primary
    MethodFrame.BackgroundTransparency = 0.1
    MethodFrame.BorderSizePixel = 0
    MethodFrame.Parent = Content

    local MethodCorner = Instance.new("UICorner")
    MethodCorner.CornerRadius = UDim.new(0, isMobile and 8 or 12)
    MethodCorner.Parent = MethodFrame

    local MethodGradient = Instance.new("UIGradient")
    MethodGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, COLORS.LootLabs.Primary),
        ColorSequenceKeypoint.new(1, COLORS.LootLabs.Secondary)
    })
    MethodGradient.Rotation = 135
    MethodGradient.Parent = MethodFrame

    local MethodIcon = Instance.new("TextLabel")
    MethodIcon.Size = UDim2.new(0, isMobile and 28 or 44, 0, isMobile and 28 or 44)
    MethodIcon.Position = UDim2.new(0, isMobile and 10 or 16, 0.5, isMobile and -14 or -22)
    MethodIcon.BackgroundTransparency = 1
    MethodIcon.Text = "💎"
    MethodIcon.TextColor3 = COLORS.LootLabs.Text
    MethodIcon.Font = Enum.Font.GothamBold
    MethodIcon.TextSize = isMobile and 20 or 32
    MethodIcon.Parent = MethodFrame

    local MethodTitle = Instance.new("TextLabel")
    MethodTitle.Size = UDim2.new(1, isMobile and -100 or -80, 0, 22)
    MethodTitle.Position = UDim2.new(0, isMobile and 45 or 70, 0, isMobile and 10 or 14)
    MethodTitle.BackgroundTransparency = 1
    MethodTitle.Text = "LootLabs"
    MethodTitle.TextColor3 = COLORS.LootLabs.Text
    MethodTitle.Font = Enum.Font.GothamBold
    MethodTitle.TextSize = isMobile and 13 or 17
    MethodTitle.TextXAlignment = Enum.TextXAlignment.Left
    MethodTitle.Parent = MethodFrame

    local MethodDesc = Instance.new("TextLabel")
    MethodDesc.Size = UDim2.new(1, isMobile and -100 or -80, 0, 18)
    MethodDesc.Position = UDim2.new(0, isMobile and 45 or 70, 0, isMobile and 32 or 42)
    MethodDesc.BackgroundTransparency = 1
    MethodDesc.Text = "Click to copy key link"
    MethodDesc.TextColor3 = COLORS.LootLabs.Desc
    MethodDesc.Font = Enum.Font.Gotham
    MethodDesc.TextSize = isMobile and 9 or 12
    MethodDesc.TextXAlignment = Enum.TextXAlignment.Left
    MethodDesc.TextWrapped = true
    MethodDesc.Parent = MethodFrame

    local MethodBtn = Instance.new("TextButton")
    MethodBtn.Size = UDim2.new(0, isMobile and 70 or 100, 0, isMobile and 30 or 36)
    MethodBtn.Position = UDim2.new(1, isMobile and -78 or -112, 0.5, isMobile and -15 or -18)
    MethodBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MethodBtn.Text = "GET KEY"
    MethodBtn.TextColor3 = COLORS.LootLabs.BtnText
    MethodBtn.Font = Enum.Font.GothamBold
    MethodBtn.TextSize = isMobile and 10 or 13
    MethodBtn.Parent = MethodFrame

    local MethodBtnCorner = Instance.new("UICorner")
    MethodBtnCorner.CornerRadius = UDim.new(0, isMobile and 6 or 8)
    MethodBtnCorner.Parent = MethodBtn

    local KeyFrame = Instance.new("Frame")
    KeyFrame.Size = UDim2.new(1, -8, 0, isMobile and 70 or 95)
    KeyFrame.Position = UDim2.new(0, 4, 0, isMobile and 170 or 230)
    KeyFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    KeyFrame.BackgroundTransparency = 0.3
    KeyFrame.BorderSizePixel = 0
    KeyFrame.Parent = Content

    local KeyFrameCorner = Instance.new("UICorner")
    KeyFrameCorner.CornerRadius = UDim.new(0, isMobile and 8 or 12)
    KeyFrameCorner.Parent = KeyFrame

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

    local BottomRow = Instance.new("Frame")
    BottomRow.Size = UDim2.new(1, -8, 0, isMobile and 60 or 85)
    BottomRow.Position = UDim2.new(0, 4, 0, isMobile and 245 or 335)
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
    StatusLabel.Text = "✨ Click GET KEY to start"
    StatusLabel.TextColor3 = Color3.fromRGB(100, 110, 130)
    StatusLabel.Font = Enum.Font.Gotham
    StatusLabel.TextSize = isMobile and 8 or 11
    StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
    StatusLabel.Parent = BottomRow

    local DiscordFrame = Instance.new("Frame")
    DiscordFrame.Size = UDim2.new(1, -8, 0, isMobile and 40 or 60)
    DiscordFrame.Position = UDim2.new(0, 4, 0, isMobile and 315 or 430)
    DiscordFrame.BackgroundColor3 = COLORS.Discord.Primary
    DiscordFrame.BackgroundTransparency = 0.1
    DiscordFrame.BorderSizePixel = 0
    DiscordFrame.Parent = Content

    local DiscordCorner = Instance.new("UICorner")
    DiscordCorner.CornerRadius = UDim.new(0, isMobile and 8 or 12)
    DiscordCorner.Parent = DiscordFrame

    local DiscordIcon = Instance.new("TextLabel")
    DiscordIcon.Size = UDim2.new(0, isMobile and 24 or 36, 0, isMobile and 24 or 36)
    DiscordIcon.Position = UDim2.new(0, isMobile and 10 or 15, 0.5, isMobile and -12 or -18)
    DiscordIcon.BackgroundTransparency = 1
    DiscordIcon.Text = "🎮"
    DiscordIcon.TextColor3 = COLORS.Discord.Text
    DiscordIcon.Font = Enum.Font.GothamBold
    DiscordIcon.TextSize = isMobile and 16 or 24
    DiscordIcon.Parent = DiscordFrame

    local DiscordTitle = Instance.new("TextLabel")
    DiscordTitle.Size = UDim2.new(1, isMobile and -90 or -70, 0, 18)
    DiscordTitle.Position = UDim2.new(0, isMobile and 45 or 65, 0, isMobile and 6 or 10)
    DiscordTitle.BackgroundTransparency = 1
    DiscordTitle.Text = "Join Discord"
    DiscordTitle.TextColor3 = COLORS.Discord.Text
    DiscordTitle.Font = Enum.Font.GothamBold
    DiscordTitle.TextSize = isMobile and 11 or 14
    DiscordTitle.TextXAlignment = Enum.TextXAlignment.Left
    DiscordTitle.Parent = DiscordFrame

    local DiscordBtn = Instance.new("TextButton")
    DiscordBtn.Size = UDim2.new(0, isMobile and 70 or 90, 0, isMobile and 28 or 34)
    DiscordBtn.Position = UDim2.new(1, isMobile and -78 or -102, 0.5, isMobile and -14 or -17)
    DiscordBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    DiscordBtn.Text = "JOIN"
    DiscordBtn.TextColor3 = COLORS.Discord.BtnText
    DiscordBtn.Font = Enum.Font.GothamBold
    DiscordBtn.TextSize = isMobile and 10 or 12
    DiscordBtn.Parent = DiscordFrame

    local DiscordBtnCorner = Instance.new("UICorner")
    DiscordBtnCorner.CornerRadius = UDim.new(0, isMobile and 6 or 8)
    DiscordBtnCorner.Parent = DiscordBtn

    local function copyToClipboard(text, btn, originalText, successColor)
        if setclipboard then
            setclipboard(text)
            btn.Text = "✓ COPIED"
            btn.BackgroundColor3 = successColor
            StatusLabel.Text = "✅ Link copied! Open in your browser"
            StatusLabel.TextColor3 = Color3.fromRGB(30, 140, 100)
            task.wait(2)
            btn.Text = originalText
            btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            StatusLabel.Text = "✨ Click GET KEY to start"
            StatusLabel.TextColor3 = Color3.fromRGB(100, 110, 130)
        else
            StatusLabel.Text = "❌ Clipboard not supported on this device"
            StatusLabel.TextColor3 = Color3.fromRGB(200, 70, 70)
        end
    end

    MethodBtn.MouseButton1Click:Connect(function()
        copyToClipboard(CONFIG.LootLabsURL, MethodBtn, "GET KEY", COLORS.LootLabs.Primary)
    end)

    DiscordBtn.MouseButton1Click:Connect(function()
        copyToClipboard(CONFIG.DiscordURL, DiscordBtn, "JOIN", COLORS.Discord.Primary)
        StatusLabel.Text = "🎮 Discord link copied!"
        StatusLabel.TextColor3 = Color3.fromRGB(88, 101, 242)
        task.wait(2.5)
        StatusLabel.Text = "✨ Click GET KEY to start"
        StatusLabel.TextColor3 = Color3.fromRGB(100, 110, 130)
    end)

    ClearBtn.MouseButton1Click:Connect(function()
        KeyInput.Text = ""
        StatusLabel.Text = "🗑️ Input cleared"
        StatusLabel.TextColor3 = Color3.fromRGB(200, 130, 50)
        task.wait(1.5)
        StatusLabel.Text = "✨ Click GET KEY to start"
        StatusLabel.TextColor3 = Color3.fromRGB(100, 110, 130)
    end)

    task.spawn(function()
        if isfile and isfile(KEY_FILE) then
            local success, content = pcall(readfile, KEY_FILE)
            if success and content and content ~= "" then
                KeyInput.Text = content
                StatusLabel.Text = "🔄 Saved Key Deteck"
                StatusLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
            end
        end
    end)

    SubmitBtn.MouseButton1Click:Connect(function()
        local userKey = KeyInput.Text:gsub("%s+", "")
        if userKey == "" then
            StatusLabel.Text = "❌ Input Key!"
            StatusLabel.TextColor3 = Color3.fromRGB(200, 70, 70)
            return
        end
        StatusLabel.Text = "🔍 Memverifikasi key..."
        StatusLabel.TextColor3 = Color3.fromRGB(240, 180, 50)
        task.spawn(function()
            if userKey == VALID_KEY then
                StatusLabel.Text = "✅ Key Valid!"
                StatusLabel.TextColor3 = Color3.fromRGB(30, 140, 100)
                saveAuthentication(userKey)
                task.wait(1)
                ScreenGui:Destroy()
                pcall(function()
                    loadstring(game:HttpGet(CONFIG.MainScriptUrl, true))()
                end)
            else
                StatusLabel.Text = "❌ Wrong Key"
                StatusLabel.TextColor3 = Color3.fromRGB(200, 70, 70)
                if isfile and isfile(KEY_FILE) then pcall(delfile, KEY_FILE) end
                task.wait(2)
                StatusLabel.Text = "✨ Click GET KEY to start"
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

createSingleKeySystemGUI()
