-- DARK AI GACHA DUPE + SPEED WALK v7.0
-- Advanced GUI with Draggable, Toggle, Separated Features + Speed Walk

if not identifyexecutor then
    game:GetService("Players").LocalPlayer:Kick("[DARK AI] Executor Required")
    return
end

warn("[DARK AI] Initializing Enhanced System v7.0...")

getgenv().DarkAISettings = {
    -- Gacha Settings
    TargetRemote = "Reward",
    CurrentArgs = {"c_chr", 7},
    LastStatus = "Ready",
    GUIHidden = false,
    DupeHistory = {},
    
    -- Speed Walk Settings
    SpeedWalkEnabled = false,
    WalkSpeed = 50,
    OriginalWalkSpeed = 16,
    JumpPowerEnabled = false,
    JumpPower = 100,
    OriginalJumpPower = 50,
    NoclipEnabled = false
}

-- CREATE ENHANCED GUI
local function CreateEnhancedGUI()
    warn("[DARK AI] Building Enhanced GUI v7.0...")
    
    -- Main ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "DarkAIEnhancedGUI"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    
    -- Minimized Toggle Button
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Name = "ToggleBtn"
    ToggleBtn.Text = "▲"
    ToggleBtn.Size = UDim2.new(0, 40, 0, 40)
    ToggleBtn.Position = UDim2.new(0, 10, 0, 10)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.TextSize = 20
    ToggleBtn.Visible = false
    ToggleBtn.Parent = ScreenGui
    ToggleBtn.ZIndex = 1000
    
    -- Main Container
    local MainContainer = Instance.new("Frame")
    MainContainer.Name = "MainContainer"
    MainContainer.Size = UDim2.new(0, 500, 0, 700)
    MainContainer.Position = UDim2.new(0, 50, 0.5, -350)
    MainContainer.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    MainContainer.BorderColor3 = Color3.fromRGB(255, 0, 0)
    MainContainer.BorderSizePixel = 2
    MainContainer.ClipsDescendants = true
    MainContainer.Parent = ScreenGui
    
    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainContainer
    
    -- Title
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Text = "DARK AI | GACHA DUPE + SPEED WALK"
    Title.Size = UDim2.new(0.7, 0, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.BackgroundTransparency = 1
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TitleBar
    
    -- Control Buttons
    local ControlFrame = Instance.new("Frame")
    ControlFrame.Name = "ControlFrame"
    ControlFrame.Size = UDim2.new(0.3, 0, 1, 0)
    ControlFrame.Position = UDim2.new(0.7, 0, 0, 0)
    ControlFrame.BackgroundTransparency = 1
    ControlFrame.Parent = TitleBar
    
    -- Hide Button
    local HideBtn = Instance.new("TextButton")
    HideBtn.Name = "HideBtn"
    HideBtn.Text = "_"
    HideBtn.Size = UDim2.new(0, 30, 0, 30)
    HideBtn.Position = UDim2.new(0, 0, 0.5, -15)
    HideBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
    HideBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    HideBtn.Font = Enum.Font.GothamBold
    HideBtn.TextSize = 18
    HideBtn.Parent = ControlFrame
    
    -- Close Button
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Name = "CloseBtn"
    CloseBtn.Text = "×"
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(0, 35, 0.5, -15)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 20
    CloseBtn.Parent = ControlFrame
    
    -- Content Scrolling Frame
    local ContentScroller = Instance.new("ScrollingFrame")
    ContentScroller.Name = "ContentScroller"
    ContentScroller.Size = UDim2.new(1, -10, 1, -50)
    ContentScroller.Position = UDim2.new(0, 5, 0, 45)
    ContentScroller.BackgroundTransparency = 1
    ContentScroller.BorderSizePixel = 0
    ContentScroller.ScrollBarThickness = 6
    ContentScroller.ScrollBarImageColor3 = Color3.fromRGB(255, 50, 50)
    ContentScroller.CanvasSize = UDim2.new(0, 0, 0, 1200)
    ContentScroller.Parent = MainContainer
    
    -- ========== FEATURE 1: REMOTE SCANNER ==========
    local ScannerSection = Instance.new("Frame")
    ScannerSection.Name = "ScannerSection"
    ScannerSection.Size = UDim2.new(1, 0, 0, 250)
    ScannerSection.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    ScannerSection.BorderColor3 = Color3.fromRGB(50, 50, 100)
    ScannerSection.BorderSizePixel = 1
    ScannerSection.Parent = ContentScroller
    
    -- Scanner Title
    local ScannerTitle = Instance.new("TextLabel")
    ScannerTitle.Name = "ScannerTitle"
    ScannerTitle.Text = "🔍 REMOTE SCANNER"
    ScannerTitle.Size = UDim2.new(1, 0, 0, 40)
    ScannerTitle.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    ScannerTitle.TextColor3 = Color3.fromRGB(100, 150, 255)
    ScannerTitle.Font = Enum.Font.GothamBold
    ScannerTitle.TextSize = 18
    ScannerTitle.Parent = ScannerSection
    
    -- Scanner Status
    local ScannerStatusFrame = Instance.new("Frame")
    ScannerStatusFrame.Name = "ScannerStatusFrame"
    ScannerStatusFrame.Size = UDim2.new(1, -20, 0, 60)
    ScannerStatusFrame.Position = UDim2.new(0, 10, 0, 45)
    ScannerStatusFrame.BackgroundTransparency = 1
    ScannerStatusFrame.Parent = ScannerSection
    
    local ScannerStatusLabel = Instance.new("TextLabel")
    ScannerStatusLabel.Name = "ScannerStatusLabel"
    ScannerStatusLabel.Text = "Status: Ready to scan"
    ScannerStatusLabel.Size = UDim2.new(1, 0, 1, 0)
    ScannerStatusLabel.BackgroundTransparency = 1
    ScannerStatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    ScannerStatusLabel.Font = Enum.Font.Gotham
    ScannerStatusLabel.TextSize = 14
    ScannerStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
    ScannerStatusLabel.Parent = ScannerStatusFrame
    
    -- Remote Info
    local RemoteInfoFrame = Instance.new("Frame")
    RemoteInfoFrame.Name = "RemoteInfoFrame"
    RemoteInfoFrame.Size = UDim2.new(1, -20, 0, 80)
    RemoteInfoFrame.Position = UDim2.new(0, 10, 0, 110)
    RemoteInfoFrame.BackgroundTransparency = 1
    RemoteInfoFrame.Parent = ScannerSection
    
    local RemotePathLabel = Instance.new("TextLabel")
    RemotePathLabel.Name = "RemotePathLabel"
    RemotePathLabel.Text = "Remote Path: Not found"
    RemotePathLabel.Size = UDim2.new(1, 0, 0, 30)
    RemotePathLabel.BackgroundTransparency = 1
    RemotePathLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    RemotePathLabel.Font = Enum.Font.Gotham
    RemotePathLabel.TextSize = 12
    RemotePathLabel.TextXAlignment = Enum.TextXAlignment.Left
    RemotePathLabel.TextWrapped = true
    RemotePathLabel.Parent = RemoteInfoFrame
    
    local ArgsCaptureLabel = Instance.new("TextLabel")
    ArgsCaptureLabel.Name = "ArgsCaptureLabel"
    ArgsCaptureLabel.Text = "Captured Args: None"
    ArgsCaptureLabel.Size = UDim2.new(1, 0, 0, 30)
    ArgsCaptureLabel.Position = UDim2.new(0, 0, 0, 35)
    ArgsCaptureLabel.BackgroundTransparency = 1
    ArgsCaptureLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    ArgsCaptureLabel.Font = Enum.Font.Gotham
    ArgsCaptureLabel.TextSize = 12
    ArgsCaptureLabel.TextXAlignment = Enum.TextXAlignment.Left
    ArgsCaptureLabel.TextWrapped = true
    ArgsCaptureLabel.Parent = RemoteInfoFrame
    
    -- Scan Button
    local ScanBtnFrame = Instance.new("Frame")
    ScanBtnFrame.Name = "ScanBtnFrame"
    ScanBtnFrame.Size = UDim2.new(1, -20, 0, 40)
    ScanBtnFrame.Position = UDim2.new(0, 10, 1, -50)
    ScanBtnFrame.BackgroundTransparency = 1
    ScanBtnFrame.Parent = ScannerSection
    
    local ScanButton = Instance.new("TextButton")
    ScanButton.Name = "ScanButton"
    ScanButton.Text = "START SCAN"
    ScanButton.Size = UDim2.new(1, 0, 1, 0)
    ScanButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    ScanButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ScanButton.Font = Enum.Font.GothamBold
    ScanButton.TextSize = 14
    ScanButton.Parent = ScanBtnFrame
    
    -- ========== SEPARATOR 1 ==========
    local Separator1 = Instance.new("Frame")
    Separator1.Name = "Separator1"
    Separator1.Size = UDim2.new(1, 0, 0, 20)
    Separator1.Position = UDim2.new(0, 0, 0, 260)
    Separator1.BackgroundTransparency = 1
    Separator1.Parent = ContentScroller
    
    local SeparatorLine1 = Instance.new("Frame")
    SeparatorLine1.Name = "SeparatorLine1"
    SeparatorLine1.Size = UDim2.new(1, -40, 0, 2)
    SeparatorLine1.Position = UDim2.new(0, 20, 0.5, -1)
    SeparatorLine1.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    SeparatorLine1.BorderSizePixel = 0
    SeparatorLine1.Parent = Separator1
    
    -- ========== FEATURE 2: GACHA DUPE ==========
    local DupeSection = Instance.new("Frame")
    DupeSection.Name = "DupeSection"
    DupeSection.Size = UDim2.new(1, 0, 0, 350)
    DupeSection.Position = UDim2.new(0, 0, 0, 290)
    DupeSection.BackgroundColor3 = Color3.fromRGB(30, 20, 20)
    DupeSection.BorderColor3 = Color3.fromRGB(100, 50, 50)
    DupeSection.BorderSizePixel = 1
    DupeSection.Parent = ContentScroller
    
    -- Dupe Title
    local DupeTitle = Instance.new("TextLabel")
    DupeTitle.Name = "DupeTitle"
    DupeTitle.Text = "🔥 GACHA DUPE"
    DupeTitle.Size = UDim2.new(1, 0, 0, 40)
    DupeTitle.BackgroundColor3 = Color3.fromRGB(60, 30, 30)
    DupeTitle.TextColor3 = Color3.fromRGB(255, 100, 100)
    DupeTitle.Font = Enum.Font.GothamBold
    DupeTitle.TextSize = 18
    DupeTitle.Parent = DupeSection
    
    -- Dupe Status
    local DupeStatusFrame = Instance.new("Frame")
    DupeStatusFrame.Name = "DupeStatusFrame"
    DupeStatusFrame.Size = UDim2.new(1, -20, 0, 40)
    DupeStatusFrame.Position = UDim2.new(0, 10, 0, 45)
    DupeStatusFrame.BackgroundTransparency = 1
    DupeStatusFrame.Parent = DupeSection
    
    local DupeStatusLabel = Instance.new("TextLabel")
    DupeStatusLabel.Name = "DupeStatusLabel"
    DupeStatusLabel.Text = "Status: Waiting for scan"
    DupeStatusLabel.Size = UDim2.new(1, 0, 1, 0)
    DupeStatusLabel.BackgroundTransparency = 1
    DupeStatusLabel.TextColor3 = Color3.fromRGB(255, 255, 100)
    DupeStatusLabel.Font = Enum.Font.Gotham
    DupeStatusLabel.TextSize = 14
    DupeStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
    DupeStatusLabel.Parent = DupeStatusFrame
    
    -- Input Fields
    local InputsFrame = Instance.new("Frame")
    InputsFrame.Name = "InputsFrame"
    InputsFrame.Size = UDim2.new(1, -20, 0, 180)
    InputsFrame.Position = UDim2.new(0, 10, 0, 90)
    InputsFrame.BackgroundTransparency = 1
    InputsFrame.Parent = DupeSection
    
    -- Amount Input
    local AmountFrame = Instance.new("Frame")
    AmountFrame.Name = "AmountFrame"
    AmountFrame.Size = UDim2.new(1, 0, 0, 50)
    AmountFrame.BackgroundTransparency = 1
    AmountFrame.Parent = InputsFrame
    
    local AmountLabel = Instance.new("TextLabel")
    AmountLabel.Name = "AmountLabel"
    AmountLabel.Text = "Dupe Amount:"
    AmountLabel.Size = UDim2.new(0.4, 0, 1, 0)
    AmountLabel.BackgroundTransparency = 1
    AmountLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    AmountLabel.Font = Enum.Font.Gotham
    AmountLabel.TextSize = 14
    AmountLabel.TextXAlignment = Enum.TextXAlignment.Left
    AmountLabel.Parent = AmountFrame
    
    local AmountInput = Instance.new("TextBox")
    AmountInput.Name = "AmountInput"
    AmountInput.Text = "500"
    AmountInput.PlaceholderText = "Enter amount"
    AmountInput.Size = UDim2.new(0.6, 0, 1, 0)
    AmountInput.Position = UDim2.new(0.4, 5, 0, 0)
    AmountInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    AmountInput.BorderColor3 = Color3.fromRGB(100, 100, 100)
    AmountInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    AmountInput.Font = Enum.Font.Gotham
    AmountInput.TextSize = 14
    AmountInput.Parent = AmountFrame
    
    -- Arg Type Input
    local ArgTypeFrame = Instance.new("Frame")
    ArgTypeFrame.Name = "ArgTypeFrame"
    ArgTypeFrame.Size = UDim2.new(1, 0, 0, 50)
    ArgTypeFrame.Position = UDim2.new(0, 0, 0, 60)
    ArgTypeFrame.BackgroundTransparency = 1
    ArgTypeFrame.Parent = InputsFrame
    
    local ArgTypeLabel = Instance.new("TextLabel")
    ArgTypeLabel.Name = "ArgTypeLabel"
    ArgTypeLabel.Text = "Argument Type:"
    ArgTypeLabel.Size = UDim2.new(0.4, 0, 1, 0)
    ArgTypeLabel.BackgroundTransparency = 1
    ArgTypeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ArgTypeLabel.Font = Enum.Font.Gotham
    ArgTypeLabel.TextSize = 14
    ArgTypeLabel.TextXAlignment = Enum.TextXAlignment.Left
    ArgTypeLabel.Parent = ArgTypeFrame
    
    local ArgTypeInput = Instance.new("TextBox")
    ArgTypeInput.Name = "ArgTypeInput"
    ArgTypeInput.Text = "c_chr"
    ArgTypeInput.PlaceholderText = "c_chr, c_wpn, c_itm"
    ArgTypeInput.Size = UDim2.new(0.6, 0, 1, 0)
    ArgTypeInput.Position = UDim2.new(0.4, 5, 0, 0)
    ArgTypeInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    ArgTypeInput.BorderColor3 = Color3.fromRGB(100, 100, 100)
    ArgTypeInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    ArgTypeInput.Font = Enum.Font.Gotham
    ArgTypeInput.TextSize = 14
    ArgTypeInput.Parent = ArgTypeFrame
    
    -- Value Input
    local ValueFrame = Instance.new("Frame")
    ValueFrame.Name = "ValueFrame"
    ValueFrame.Size = UDim2.new(1, 0, 0, 50)
    ValueFrame.Position = UDim2.new(0, 0, 0, 120)
    ValueFrame.BackgroundTransparency = 1
    ValueFrame.Parent = InputsFrame
    
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Name = "ValueLabel"
    ValueLabel.Text = "Argument Value:"
    ValueLabel.Size = UDim2.new(0.4, 0, 1, 0)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ValueLabel.Font = Enum.Font.Gotham
    ValueLabel.TextSize = 14
    ValueLabel.TextXAlignment = Enum.TextXAlignment.Left
    ValueLabel.Parent = ValueFrame
    
    local ValueInput = Instance.new("TextBox")
    ValueInput.Name = "ValueInput"
    ValueInput.Text = "7"
    ValueInput.PlaceholderText = "Enter number"
    ValueInput.Size = UDim2.new(0.6, 0, 1, 0)
    ValueInput.Position = UDim2.new(0.4, 5, 0, 0)
    ValueInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    ValueInput.BorderColor3 = Color3.fromRGB(100, 100, 100)
    ValueInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    ValueInput.Font = Enum.Font.Gotham
    ValueInput.TextSize = 14
    ValueInput.Parent = ValueFrame
    
    -- Dupe Button
    local DupeBtnFrame = Instance.new("Frame")
    DupeBtnFrame.Name = "DupeBtnFrame"
    DupeBtnFrame.Size = UDim2.new(1, -20, 0, 50)
    DupeBtnFrame.Position = UDim2.new(0, 10, 1, -70)
    DupeBtnFrame.BackgroundTransparency = 1
    DupeBtnFrame.Parent = DupeSection
    
    local DupeButton = Instance.new("TextButton")
    DupeButton.Name = "DupeButton"
    DupeButton.Text = "🚀 START DUPE"
    DupeButton.Size = UDim2.new(1, 0, 1, 0)
    DupeButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    DupeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    DupeButton.Font = Enum.Font.GothamBold
    DupeButton.TextSize = 16
    DupeButton.Parent = DupeBtnFrame
    
    -- ========== SEPARATOR 2 ==========
    local Separator2 = Instance.new("Frame")
    Separator2.Name = "Separator2"
    Separator2.Size = UDim2.new(1, 0, 0, 20)
    Separator2.Position = UDim2.new(0, 0, 0, 660)
    Separator2.BackgroundTransparency = 1
    Separator2.Parent = ContentScroller
    
    local SeparatorLine2 = Instance.new("Frame")
    SeparatorLine2.Name = "SeparatorLine2"
    SeparatorLine2.Size = UDim2.new(1, -40, 0, 2)
    SeparatorLine2.Position = UDim2.new(0, 20, 0.5, -1)
    SeparatorLine2.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
    SeparatorLine2.BorderSizePixel = 0
    SeparatorLine2.Parent = Separator2
    
    -- ========== FEATURE 3: SPEED WALK ==========
    local SpeedSection = Instance.new("Frame")
    SpeedSection.Name = "SpeedSection"
    SpeedSection.Size = UDim2.new(1, 0, 0, 350)
    SpeedSection.Position = UDim2.new(0, 0, 0, 690)
    SpeedSection.BackgroundColor3 = Color3.fromRGB(20, 30, 20)
    SpeedSection.BorderColor3 = Color3.fromRGB(50, 100, 50)
    SpeedSection.BorderSizePixel = 1
    SpeedSection.Parent = ContentScroller
    
    -- Speed Walk Title
    local SpeedTitle = Instance.new("TextLabel")
    SpeedTitle.Name = "SpeedTitle"
    SpeedTitle.Text = "⚡ SPEED WALK + MOVEMENT"
    SpeedTitle.Size = UDim2.new(1, 0, 0, 40)
    SpeedTitle.BackgroundColor3 = Color3.fromRGB(30, 60, 30)
    SpeedTitle.TextColor3 = Color3.fromRGB(100, 255, 100)
    SpeedTitle.Font = Enum.Font.GothamBold
    SpeedTitle.TextSize = 18
    SpeedTitle.Parent = SpeedSection
    
    -- Speed Walk Status
    local SpeedStatusFrame = Instance.new("Frame")
    SpeedStatusFrame.Name = "SpeedStatusFrame"
    SpeedStatusFrame.Size = UDim2.new(1, -20, 0, 40)
    SpeedStatusFrame.Position = UDim2.new(0, 10, 0, 45)
    SpeedStatusFrame.BackgroundTransparency = 1
    SpeedStatusFrame.Parent = SpeedSection
    
    local SpeedStatusLabel = Instance.new("TextLabel")
    SpeedStatusLabel.Name = "SpeedStatusLabel"
    SpeedStatusLabel.Text = "Status: Disabled"
    SpeedStatusLabel.Size = UDim2.new(1, 0, 1, 0)
    SpeedStatusLabel.BackgroundTransparency = 1
    SpeedStatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    SpeedStatusLabel.Font = Enum.Font.Gotham
    SpeedStatusLabel.TextSize = 14
    SpeedStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
    SpeedStatusLabel.Parent = SpeedStatusFrame
    
    -- Speed Slider
    local SpeedSliderFrame = Instance.new("Frame")
    SpeedSliderFrame.Name = "SpeedSliderFrame"
    SpeedSliderFrame.Size = UDim2.new(1, -20, 0, 80)
    SpeedSliderFrame.Position = UDim2.new(0, 10, 0, 90)
    SpeedSliderFrame.BackgroundTransparency = 1
    SpeedSliderFrame.Parent = SpeedSection
    
    local SpeedLabel = Instance.new("TextLabel")
    SpeedLabel.Name = "SpeedLabel"
    SpeedLabel.Text = "Walk Speed: 50"
    SpeedLabel.Size = UDim2.new(1, 0, 0, 30)
    SpeedLabel.BackgroundTransparency = 1
    SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    SpeedLabel.Font = Enum.Font.Gotham
    SpeedLabel.TextSize = 14
    SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
    SpeedLabel.Parent = SpeedSliderFrame
    
    local SpeedInput = Instance.new("TextBox")
    SpeedInput.Name = "SpeedInput"
    SpeedInput.Text = "50"
    SpeedInput.PlaceholderText = "16-500"
    SpeedInput.Size = UDim2.new(1, 0, 0, 30)
    SpeedInput.Position = UDim2.new(0, 0, 0, 35)
    SpeedInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    SpeedInput.BorderColor3 = Color3.fromRGB(100, 100, 100)
    SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    SpeedInput.Font = Enum.Font.Gotham
    SpeedInput.TextSize = 14
    SpeedInput.Parent = SpeedSliderFrame
    
    -- Jump Power
    local JumpFrame = Instance.new("Frame")
    JumpFrame.Name = "JumpFrame"
    JumpFrame.Size = UDim2.new(1, -20, 0, 80)
    JumpFrame.Position = UDim2.new(0, 10, 0, 180)
    JumpFrame.BackgroundTransparency = 1
    JumpFrame.Parent = SpeedSection
    
    local JumpLabel = Instance.new("TextLabel")
    JumpLabel.Name = "JumpLabel"
    JumpLabel.Text = "Jump Power: 100"
    JumpLabel.Size = UDim2.new(1, 0, 0, 30)
    JumpLabel.BackgroundTransparency = 1
    JumpLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    JumpLabel.Font = Enum.Font.Gotham
    JumpLabel.TextSize = 14
    JumpLabel.TextXAlignment = Enum.TextXAlignment.Left
    JumpLabel.Parent = JumpFrame
    
    local JumpInput = Instance.new("TextBox")
    JumpInput.Name = "JumpInput"
    JumpInput.Text = "100"
    JumpInput.PlaceholderText = "50-500"
    JumpInput.Size = UDim2.new(1, 0, 0, 30)
    JumpInput.Position = UDim2.new(0, 0, 0, 35)
    JumpInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    JumpInput.BorderColor3 = Color3.fromRGB(100, 100, 100)
    JumpInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    JumpInput.Font = Enum.Font.Gotham
    JumpInput.TextSize = 14
    JumpInput.Parent = JumpFrame
    
    -- Control Buttons Frame
    local SpeedButtonsFrame = Instance.new("Frame")
    SpeedButtonsFrame.Name = "SpeedButtonsFrame"
    SpeedButtonsFrame.Size = UDim2.new(1, -20, 0, 120)
    SpeedButtonsFrame.Position = UDim2.new(0, 10, 1, -140)
    SpeedButtonsFrame.BackgroundTransparency = 1
    SpeedButtonsFrame.Parent = SpeedSection
    
    -- Toggle Speed Button
    local ToggleSpeedBtn = Instance.new("TextButton")
    ToggleSpeedBtn.Name = "ToggleSpeedBtn"
    ToggleSpeedBtn.Text = "ENABLE SPEED"
    ToggleSpeedBtn.Size = UDim2.new(1, 0, 0, 40)
    ToggleSpeedBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    ToggleSpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleSpeedBtn.Font = Enum.Font.GothamBold
    ToggleSpeedBtn.TextSize = 14
    ToggleSpeedBtn.Parent = SpeedButtonsFrame
    
    -- Toggle Noclip Button
    local ToggleNoclipBtn = Instance.new("TextButton")
    ToggleNoclipBtn.Name = "ToggleNoclipBtn"
    ToggleNoclipBtn.Text = "TOGGLE NOCLIP"
    ToggleNoclipBtn.Size = UDim2.new(1, 0, 0, 40)
    ToggleNoclipBtn.Position = UDim2.new(0, 0, 0, 50)
    ToggleNoclipBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 150)
    ToggleNoclipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleNoclipBtn.Font = Enum.Font.GothamBold
    ToggleNoclipBtn.TextSize = 14
    ToggleNoclipBtn.Parent = SpeedButtonsFrame
    
    -- Reset Button
    local ResetSpeedBtn = Instance.new("TextButton")
    ResetSpeedBtn.Name = "ResetSpeedBtn"
    ResetSpeedBtn.Text = "RESET MOVEMENT"
    ResetSpeedBtn.Size = UDim2.new(1, 0, 0, 40)
    ResetSpeedBtn.Position = UDim2.new(0, 0, 0, 100)
    ResetSpeedBtn.BackgroundColor3 = Color3.fromRGB(150, 150, 0)
    ResetSpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ResetSpeedBtn.Font = Enum.Font.GothamBold
    ResetSpeedBtn.TextSize = 14
    ResetSpeedBtn.Parent = SpeedButtonsFrame
    
    -- ========== RESULTS SECTION ==========
    local ResultsSection = Instance.new("Frame")
    ResultsSection.Name = "ResultsSection"
    ResultsSection.Size = UDim2.new(1, 0, 0, 150)
    ResultsSection.Position = UDim2.new(0, 0, 0, 1060)
    ResultsSection.BackgroundColor3 = Color3.fromRGB(30, 20, 30)
    ResultsSection.BorderColor3 = Color3.fromRGB(100, 50, 100)
    ResultsSection.BorderSizePixel = 1
    ResultsSection.Parent = ContentScroller
    
    local ResultsTitle = Instance.new("TextLabel")
    ResultsTitle.Name = "ResultsTitle"
    ResultsTitle.Text = "📊 SYSTEM STATUS"
    ResultsTitle.Size = UDim2.new(1, 0, 0, 30)
    ResultsTitle.BackgroundColor3 = Color3.fromRGB(60, 30, 60)
    ResultsTitle.TextColor3 = Color3.fromRGB(255, 100, 255)
    ResultsTitle.Font = Enum.Font.GothamBold
    ResultsTitle.TextSize = 16
    ResultsTitle.Parent = ResultsSection
    
    local ResultsLabel = Instance.new("TextLabel")
    ResultsLabel.Name = "ResultsLabel"
    ResultsLabel.Text = "System Ready\nGacha: Not scanned\nSpeed: Disabled"
    ResultsLabel.Size = UDim2.new(1, -20, 1, -40)
    ResultsLabel.Position = UDim2.new(0, 10, 0, 35)
    ResultsLabel.BackgroundTransparency = 1
    ResultsLabel.TextColor3 = Color3.fromRGB(255, 200, 255)
    ResultsLabel.Font = Enum.Font.Gotham
    ResultsLabel.TextSize = 12
    ResultsLabel.TextXAlignment = Enum.TextXAlignment.Left
    ResultsLabel.TextYAlignment = Enum.TextYAlignment.Top
    ResultsLabel.TextWrapped = true
    ResultsLabel.Parent = ResultsSection
    
    -- Setup Dragging Functionality
    local UserInputService = game:GetService("UserInputService")
    local dragging = false
    local dragStart = Vector2.new(0, 0)
    local startPos = Vector2.new(0, 0)
    
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Vector2.new(MainContainer.Position.X.Offset, MainContainer.Position.Y.Offset)
        end
    end)
    
    TitleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            if dragging then
                local delta = input.Position - dragStart
                MainContainer.Position = UDim2.new(0, startPos.X + delta.X, 0, startPos.Y + delta.Y)
            end
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    -- Toggle Show/Hide
    HideBtn.MouseButton1Click:Connect(function()
        if getgenv().DarkAISettings.GUIHidden then
            MainContainer.Visible = true
            ToggleBtn.Visible = false
            getgenv().DarkAISettings.GUIHidden = false
            HideBtn.Text = "_"
        else
            MainContainer.Visible = false
            ToggleBtn.Visible = true
            getgenv().DarkAISettings.GUIHidden = true
            HideBtn.Text = "□"
        end
    end)
    
    ToggleBtn.MouseButton1Click:Connect(function()
        MainContainer.Visible = true
        ToggleBtn.Visible = false
        getgenv().DarkAISettings.GUIHidden = false
        HideBtn.Text = "_"
    end)
    
    -- Close Button
    CloseBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
        getgenv().DarkAIGUI = nil
        warn("[DARK AI] GUI Closed")
    end)
    
    -- Return GUI Functions
    return {
        ScreenGui = ScreenGui,
        
        -- Scanner Functions
        UpdateScannerStatus = function(text, color)
            ScannerStatusLabel.Text = "Status: " .. text
            ScannerStatusLabel.TextColor3 = color or Color3.fromRGB(0, 255, 0)
        end,
        
        UpdateRemotePath = function(text)
            RemotePathLabel.Text = "Remote Path: " .. text
        end,
        
        UpdateCapturedArgs = function(text)
            ArgsCaptureLabel.Text = "Captured Args: " .. text
        end,
        
        SetScanCallback = function(callback)
            ScanButton.MouseButton1Click:Connect(callback)
        end,
        
        -- Dupe Functions
        UpdateDupeStatus = function(text, color)
            DupeStatusLabel.Text = "Status: " .. text
            DupeStatusLabel.TextColor3 = color or Color3.fromRGB(255, 255, 100)
        end,
        
        GetAmount = function()
            return tonumber(AmountInput.Text) or 500
        end,
        
        GetArgType = function()
            return ArgTypeInput.Text or "c_chr"
        end,
        
        GetValue = function()
            return tonumber(ValueInput.Text) or 7
        end,
        
        SetDupeCallback = function(callback)
            DupeButton.MouseButton1Click:Connect(callback)
        end,
        
        -- Speed Walk Functions
        UpdateSpeedStatus = function(text, color)
            SpeedStatusLabel.Text = "Status: " .. text
            SpeedStatusLabel.TextColor3 = color or Color3.fromRGB(255, 100, 100)
        end,
        
        GetSpeedValue = function()
            return tonumber(SpeedInput.Text) or 50
        end,
        
        GetJumpValue = function()
            return tonumber(JumpInput.Text) or 100
        end,
        
        SetSpeedCallback = function(callback)
            ToggleSpeedBtn.MouseButton1Click:Connect(callback)
        end,
        
        SetNoclipCallback = function(callback)
            ToggleNoclipBtn.MouseButton1Click:Connect(callback)
        end,
        
        SetResetCallback = function(callback)
            ResetSpeedBtn.MouseButton1Click:Connect(callback)
        end,
        
        UpdateResults = function(text)
            ResultsLabel.Text = text
        end,
        
        -- GUI Control
        ToggleVisibility = function()
            HideBtn:Click()
        end
    }
end

-- ========== SPEED WALK FUNCTIONS ==========
local NoclipConnection = nil
local SpeedWalkConnection = nil

function ToggleSpeedWalk()
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    
    if not getgenv().DarkAISettings.SpeedWalkEnabled then
        -- Enable Speed Walk
        getgenv().DarkAISettings.OriginalWalkSpeed = humanoid.WalkSpeed
        getgenv().DarkAISettings.OriginalJumpPower = humanoid.JumpPower
        
        local speed = getgenv().DarkAIGUI.GetSpeedValue()
        local jump = getgenv().DarkAIGUI.GetJumpValue()
        
        -- Apply speed
        humanoid.WalkSpeed = speed
        
        -- Apply jump power if enabled
        if getgenv().DarkAISettings.JumpPowerEnabled then
            humanoid.JumpPower = jump
        end
        
        getgenv().DarkAISettings.SpeedWalkEnabled = true
        
        -- Update GUI
        getgenv().DarkAIGUI.UpdateSpeedStatus("Enabled (Speed: " .. speed .. ")", Color3.fromRGB(0, 255, 0))
        getgenv().DarkAIGUI.UpdateResults("Speed Walk: ENABLED\nSpeed: " .. speed .. "\nJump: " .. jump)
        
        warn("[DARK AI] Speed Walk Enabled: " .. speed .. " walk speed")
        
        -- Auto-update when values change
        SpeedWalkConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if getgenv().DarkAISettings.SpeedWalkEnabled and humanoid then
                local newSpeed = getgenv().DarkAIGUI.GetSpeedValue()
                local newJump = getgenv().DarkAIGUI.GetJumpValue()
                
                humanoid.WalkSpeed = newSpeed
                
                if getgenv().DarkAISettings.JumpPowerEnabled then
                    humanoid.JumpPower = newJump
                end
            end
        end)
    else
        -- Disable Speed Walk
        if humanoid then
            humanoid.WalkSpeed = getgenv().DarkAISettings.OriginalWalkSpeed or 16
            humanoid.JumpPower = getgenv().DarkAISettings.OriginalJumpPower or 50
        end
        
        getgenv().DarkAISettings.SpeedWalkEnabled = false
        
        -- Disconnect auto-update
        if SpeedWalkConnection then
            SpeedWalkConnection:Disconnect()
            SpeedWalkConnection = nil
        end
        
        -- Update GUI
        getgenv().DarkAIGUI.UpdateSpeedStatus("Disabled", Color3.fromRGB(255, 100, 100))
        getgenv().DarkAIGUI.UpdateResults("Speed Walk: DISABLED")
        
        warn("[DARK AI] Speed Walk Disabled")
    end
    
    -- Update button text
    local btn = getgenv().DarkAIGUI.ScreenGui:FindFirstChild("ToggleSpeedBtn", true)
    if btn then
        btn.Text = getgenv().DarkAISettings.SpeedWalkEnabled and "DISABLE SPEED" or "ENABLE SPEED"
        btn.BackgroundColor3 = getgenv().DarkAISettings.SpeedWalkEnabled and 
            Color3.fromRGB(200, 0, 0) or Color3.fromRGB(0, 150, 0)
    end
end

function ToggleNoclip()
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character
    
    if not character then return end
    
    if not getgenv().DarkAISettings.NoclipEnabled then
        -- Enable Noclip
        getgenv().DarkAISettings.NoclipEnabled = true
        
        NoclipConnection = game:GetService("RunService").Stepped:Connect(function()
            if character and getgenv().DarkAISettings.NoclipEnabled then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end)
        
        getgenv().DarkAIGUI.UpdateResults("Noclip: ENABLED")
        warn("[DARK AI] Noclip Enabled")
    else
        -- Disable Noclip
        getgenv().DarkAISettings.NoclipEnabled = false
        
        if NoclipConnection then
            NoclipConnection:Disconnect()
            NoclipConnection = nil
        end
        
        -- Restore collision
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
        
        getgenv().DarkAIGUI.UpdateResults("Noclip: DISABLED")
        warn("[DARK AI] Noclip Disabled")
    end
    
    -- Update button text
    local btn = getgenv().DarkAIGUI.ScreenGui:FindFirstChild("ToggleNoclipBtn", true)
    if btn then
        btn.Text = getgenv().DarkAISettings.NoclipEnabled and "DISABLE NOCLIP" or "ENABLE NOCLIP"
        btn.BackgroundColor3 = getgenv().DarkAISettings.NoclipEnabled and 
            Color3.fromRGB(200, 0, 200) or Color3.fromRGB(150, 0, 150)
    end
end

function ResetMovement()
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character
    
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            -- Reset to default values
            humanoid.WalkSpeed = 16
            humanoid.JumpPower = 50
            
            -- Disable noclip
            if NoclipConnection then
                NoclipConnection:Disconnect()
                NoclipConnection = nil
            end
            
            -- Restore collision
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
            
            -- Update settings
            getgenv().DarkAISettings.SpeedWalkEnabled = false
            getgenv().DarkAISettings.NoclipEnabled = false
            
            -- Disconnect speed connection
            if SpeedWalkConnection then
                SpeedWalkConnection:Disconnect()
                SpeedWalkConnection = nil
            end
            
            -- Update GUI
            getgenv().DarkAIGUI.UpdateSpeedStatus("Reset to Default", Color3.fromRGB(255, 255, 100))
            getgenv().DarkAIGUI.UpdateResults("Movement RESET to default")
            
            -- Update button texts
            local speedBtn = getgenv().DarkAIGUI.ScreenGui:FindFirstChild("ToggleSpeedBtn", true)
            local noclipBtn = getgenv().DarkAIGUI.ScreenGui:FindFirstChild("ToggleNoclipBtn", true)
            
            if speedBtn then
                speedBtn.Text = "ENABLE SPEED"
                speedBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
            end
            
            if noclipBtn then
                noclipBtn.Text = "TOGGLE NOCLIP"
                noclipBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 150)
            end
            
            warn("[DARK AI] Movement Reset to Default")
        end
    end
end

-- ========== GACHA DUPE FUNCTIONS ==========
function PerformRemoteScan()
    warn("[DARK AI] Scanning for remote events...")
    
    if not getgenv().DarkAIGUI then return end
    
    getgenv().DarkAIGUI.UpdateScannerStatus("Scanning...", Color3.fromRGB(255, 255, 0))
    
    local foundRemote = nil
    local remotePath = "Not found"
    
    -- Priority scan
    if game:GetService("ReplicatedStorage"):FindFirstChild("Net") then
        local net = game:GetService("ReplicatedStorage").Net
        if net:FindFirstChild("Events") then
            local events = net.Events
            for _, obj in pairs(events:GetChildren()) do
                if obj:IsA("RemoteEvent") then
                    if obj.Name:lower():find("reward") or obj.Name == "Reward" then
                        foundRemote = obj
                        remotePath = obj:GetFullName()
                        getgenv().DarkAISettings.TargetRemote = obj.Name
                        break
                    end
                end
            end
        end
    end
    
    -- Secondary scan
    if not foundRemote then
        for _, obj in pairs(game:GetDescendants()) do
            if obj:IsA("RemoteEvent") then
                if obj.Name:lower():find("reward") or obj.Name:lower():find("gacha") then
                    foundRemote = obj
                    remotePath = obj:GetFullName()
                    getgenv().DarkAISettings.TargetRemote = obj.Name
                    break
                end
            end
        end
    end
    
    if foundRemote then
        getgenv().DarkAIGUI.UpdateRemotePath(remotePath)
        getgenv().DarkAIGUI.UpdateScannerStatus("Remote Found!", Color3.fromRGB(0, 255, 0))
        getgenv().DarkAIGUI.UpdateDupeStatus("Ready to dupe", Color3.fromRGB(0, 255, 0))
        
        -- Hook remote untuk auto-capture args
        HookRemoteForArgs(foundRemote)
        
        getgenv().DarkAIGUI.UpdateResults("Remote: FOUND\n" .. remotePath)
        warn("[DARK AI] Remote found: " .. remotePath)
    else
        getgenv().DarkAIGUI.UpdateScannerStatus("Remote Not Found", Color3.fromRGB(255, 0, 0))
        getgenv().DarkAIGUI.UpdateRemotePath("Do manual gacha first")
        getgenv().DarkAIGUI.UpdateResults("Remote: NOT FOUND\nDo manual gacha first")
        warn("[DARK AI] No reward remote found!")
    end
end

function HookRemoteForArgs(remote)
    local oldFire = remote.FireServer
    
    remote.FireServer = function(self, ...)
        local args = {...}
        getgenv().DarkAISettings.CurrentArgs = args
        
        getgenv().DarkAIGUI.UpdateCapturedArgs(table.concat(args, ", "))
        
        if #args >= 2 then
            local argTypeInput = getgenv().DarkAIGUI.ScreenGui:FindFirstChild("ArgTypeInput", true)
            local valueInput = getgenv().DarkAIGUI.ScreenGui:FindFirstChild("ValueInput", true)
            
            if argTypeInput then argTypeInput.Text = tostring(args[1]) end
            if valueInput then valueInput.Text = tostring(args[2]) end
        end
        
        warn("[DARK AI] Args captured: " .. table.concat(args, ", "))
        
        return oldFire(self, ...)
    end
end

function PerformDupe()
    warn("[DARK AI] Starting dupe process...")
    
    if not getgenv().DarkAIGUI then return end
    
    local amount = getgenv().DarkAIGUI.GetAmount()
    local argType = getgenv().DarkAIGUI.GetArgType()
    local value = getgenv().DarkAIGUI.GetValue()
    
    -- Find remote
    local remote = nil
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("RemoteEvent") and obj.Name == getgenv().DarkAISettings.TargetRemote then
            remote = obj
            break
        end
    end
    
    if not remote then
        getgenv().DarkAIGUI.UpdateDupeStatus("ERROR: Remote not found!", Color3.fromRGB(255, 0, 0))
        return
    end
    
    getgenv().DarkAIGUI.UpdateDupeStatus("Running...", Color3.fromRGB(255, 255, 0))
    
    local success = 0
    local failed = 0
    local startTime = tick()
    
    for i = 1, amount do
        task.spawn(function()
            local ok = pcall(function()
                remote:FireServer(argType, value)
                success = success + 1
            end)
            if not ok then failed = failed + 1 end
        end)
        
        if i % math.max(1, math.floor(amount / 20)) == 0 then
            local progress = math.floor((i / amount) * 100)
            getgenv().DarkAIGUI.UpdateDupeStatus("Progress: " .. progress .. "%", Color3.fromRGB(255, 255, 0))
        end
        
        task.wait(0.03)
    end
    
    task.wait(2)
    
    local totalTime = tick() - startTime
    local results = string.format(
        "✅ DUPE COMPLETED!\n" ..
        "⏱️ Time: %.2f seconds\n" ..
        "✅ Success: %d\n" ..
        "❌ Failed: %d\n" ..
        "📊 Total Attempts: %d",
        totalTime, success, failed, amount
    )
    
    getgenv().DarkAIGUI.UpdateResults(results)
    getgenv().DarkAIGUI.UpdateDupeStatus("Complete!", Color3.fromRGB(0, 255, 0))
    
    warn("[DARK AI] Dupe completed in " .. totalTime .. " seconds")
    warn("[DARK AI] Success: " .. success .. " | Failed: " .. failed)
end

-- ========== INITIALIZE SYSTEM ==========
warn("[DARK AI] =================================")
warn("[DARK AI] ENHANCED SYSTEM v7.0 LOADING...")
warn("[DARK AI] =================================")

-- Create GUI
getgenv().DarkAIGUI = CreateEnhancedGUI()
warn("[DARK AI] Enhanced GUI Created")

-- Setup callbacks
getgenv().DarkAIGUI.SetScanCallback(PerformRemoteScan)
getgenv().DarkAIGUI.SetDupeCallback(PerformDupe)
getgenv().DarkAIGUI.SetSpeedCallback(ToggleSpeedWalk)
getgenv().DarkAIGUI.SetNoclipCallback(ToggleNoclip)
getgenv().DarkAIGUI.SetResetCallback(ResetMovement)

-- Auto-scan on start
task.wait(1)
PerformRemoteScan()

-- Setup anti-kick
local function SetupProtection()
    local mt = getrawmetatable(game)
    if mt then
        local oldNamecall = mt.__namecall
        setreadonly(mt, false)
        
        if oldNamecall then
            mt.__namecall = newcclosure(function(self, ...)
                local method = getnamecallmethod()
                if method == "Kick" then
                    warn("[DARK AI] Kick attempt blocked!")
                    return nil
                end
                return oldNamecall(self, ...)
            end)
        end
        
        setreadonly(mt, true)
    end
end

SetupProtection()

warn("[DARK AI] =================================")
warn("[DARK AI] SYSTEM READY!")
warn("[DARK AI] =================================")
warn("[DARK AI] FEATURE 1: REMOTE SCANNER")
warn("[DARK AI] FEATURE 2: GACHA DUPE")
warn("[DARK AI] FEATURE 3: SPEED WALK + MOVEMENT")
warn("[DARK AI] =================================")