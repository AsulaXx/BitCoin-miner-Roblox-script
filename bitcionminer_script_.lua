if game.PlaceId == 2629642516 then
    local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
    local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
    local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
    
    
    --Windows
    
    local Window = Fluent:CreateWindow({
        Title = "Asula Bitcoin Miner " .. Fluent.Version,
        SubTitle = "By Asula",
        TabWidth = 160,
        Size = UDim2.fromOffset(580, 460),
        Acrylic = true,
        Theme = "Dark",
        MinimizeKey = Enum.KeyCode.LeftControl
    })
    
    --Tabs
    
    local Tabs = {
        Main = Window:AddTab({ Title = "Main", Icon = "home" }),
        AutoSell = Window:AddTab({ Title = "Auto Sell", Icon = "bitcoin" }),
        Visuals = Window:AddTab({ Title = "Visuals", Icon = "cog" }),
        Player = Window:AddTab({ Title = "Player", Icon = "scan-face" }),
        Crystal = Window:AddTab({ Title = "Crystal" , Icon = "gem"}),
        Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
    
    }
    
    --Main
    
    Tabs.Main:AddParagraph({
        Title = "Bitcoin Miner Script!!",
        Content = "Remake By Asula !!"
    })
    
    --Auto Sell
    
    local ToggleAutoSellBTC = Tabs.AutoSell:AddToggle("Auto Sell BTC", { Title = "Auto Sell Bitcoin", Default = false })
    local isRunningBTC = false
    ToggleAutoSellBTC:OnChanged(function()
        isRunningBTC = ToggleAutoSellBTC.Value
        if isRunningBTC then
            while isRunningBTC do
                wait(5)
                local args = { [1] = true }
                game:GetService("ReplicatedStorage").Events.ExchangeMoney:FireServer(unpack(args))
            end
        end
    end)
    
    
    local ToggleAutoSellSLR = Tabs.AutoSell:AddToggle("Auto Sell SLR", { Title = "Auto Sell Solaris", Default = false })
    local isRunningSLR = false
    ToggleAutoSellSLR:OnChanged(function()
        isRunningSLR = ToggleAutoSellSLR.Value
        if isRunningSLR then
            while isRunningSLR do
                wait(5)
                local args = { [1] = false }
                game:GetService("ReplicatedStorage").Events.ExchangeMoney:FireServer(unpack(args))
            end
        end
    end)
    
    
    local ToggleAutoSellQSR = Tabs.AutoSell:AddToggle("Auto Sell QSR", { Title = "Auto Sell Quasar", Default = false })
    local isRunningQSR = false
    ToggleAutoSellQSR:OnChanged(function()
        isRunningQSR = ToggleAutoSellQSR.Value
        if isRunningQSR then
            while isRunningQSR do
                wait(5)
                local args = { [1] = "Qsr" }
                game:GetService("ReplicatedStorage").Events.ExchangeMoney:FireServer(unpack(args))
            end
        end
    end)
    
    --Visuals
    
    local ToggleAutoCBSTR = Tabs.Visuals:AddToggle("Auto Claim CBSTR", { Title = "Auto Claim Free BoostStar", Default = false })
    ToggleAutoCBSTR:OnChanged(function()
        local isRunningCBSTR = ToggleAutoCBSTR.Value
        if isRunningCBSTR then
            while isRunningCBSTR do
                wait(60)
                game:GetService("ReplicatedStorage").Events.ClaimFreeBoostStar:FireServer()
            end
        end
    end)
    
    
    local ToggleAutoCLMCHS = Tabs.Visuals:AddToggle("Auto Claim Chest", { Title = "Auto Claim Chest", Default = false })
    ToggleAutoCLMCHS:OnChanged(function()
        local isRunningCLMCHS = ToggleAutoCLMCHS.Value
        if isRunningCLMCHS then
            game:GetService("ReplicatedStorage").Events.ClmFrCrt:FireServer(false)
            game:GetService("ReplicatedStorage").Events.ClmFrCrt:FireServer(true)
        end
    end)
    
    
    local ToggleAutoOverclock = Tabs.Visuals:AddToggle("Auto Overclock", { Title = "Auto Overclock", Default = false })
    ToggleAutoOverclock:OnChanged(function()
        local isRunningAutoOverclock = ToggleAutoOverclock.Value
        while isRunningAutoOverclock do
            game:GetService("ReplicatedStorage").Events.ActivateOverclock:FireServer()
            wait(10) 
            isRunningAutoOverclock = ToggleAutoOverclock.Value 
        end
    end)
    
    
    local ToggleALG = Tabs.Visuals:AddToggle("Auto Change Algorithm", { Title = "Auto Change Algorithm", Default = false })
    
    local loopRunning = false
    ToggleALG:OnChanged(function()
        if ToggleALG.Value then
            loopRunning = true
            while loopRunning do
                -- Fetch the highest rate
                local Algs = game.Players.LocalPlayer.PlayerGui.NewUi.UiButtons.SubButtonsContainer.SubButtonsMenu.Algorithms.AlgStore
                local rates = {}
                local ratesname = {}
                for i, v in pairs(Algs:GetChildren()) do
                    if v.ClassName == "TextButton" then
                        rates[v.Name:sub(1, 1)] = v.Rate.Text:sub(1, #v.Rate.Text - 1)
                        ratesname[v.Name:sub(1, 1)] = v.Name:sub(2, #v.Name)
                    end
                end
    
                local highestNumber = 0
                local newRate = 1
                for i, v in pairs(rates) do
                    local number = tonumber(v)
                    if number > highestNumber then
                        highestNumber = number
                        newRate = i
                    end
                end
    
                game:GetService("ReplicatedStorage").Events.AlgoChang:FireServer(newRate)
    
                wait(5) -- Wait for 5 seconds
            end
        else
            loopRunning = false
        end
    end)
    
    --Player
    
    local Slider = Tabs.Player:AddSlider("Set Walk Speed", {
        Title = "Set Walk Speed",
        Description = "Slider to set walk speed",
        Default = 16,
        Min = 16,
        Max = 250,
        Rounding = 10,
        Callback = function(Value)
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end,
    })
    
    
    local AntiAFKToggle = Tabs.Player:AddToggle("Anti AFK", { Title = "Anti AFK", Default = false })
    local antiAFK
    local function CheckAFK()
        if AntiAFKToggle.Value then
            if not antiAFK then
                antiAFK = game:GetService("Players").LocalPlayer.Idled:Connect(function()
                    game:GetService("VirtualUser"):CaptureController()
                    game:GetService("VirtualUser"):ClickButton2(Vector2.new())
                end)
            end
        else
            if antiAFK then
                antiAFK:Disconnect()
                antiAFK = nil
            end
        end
    end
    AntiAFKToggle:OnChanged(CheckAFK)
    
    Tabs.Player:AddButton({
        Title = "Rejoin server",
        Description = "Rejoin this server",
        Callback = function()
            Window:Dialog({
                Title = "Are you sure to rejoin ?",
                Content = "Wanna re join ?",
                Buttons = {
                    {
                        Title = "Confirm",
                        Callback = function()
                            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
                        end
                    },
                    {
                        Title = "Cancel",
                        Callback = function()
                            print("Cancelled the dialog.")
                        end
                    }
                }
            })
        end
    })
    
    --Craystal
    
    local ToggleAutoClaimCrystal = Tabs.Crystal:AddToggle("Auto Claim Crystal", { Title = "Auto Claim Crystal", Default = false })
    local isRunningAutoClaimCrystal = false
    
    local function AutoClaimCrystalLoop()
        while isRunningAutoClaimCrystal do
            for i, v in pairs(game:GetService("Workspace").GemsSpawned:GetDescendants()) do
                if v.Name == "ProximityPrompt" then
                    local humanoidRootPart = game.Players.LocalPlayer.Character.HumanoidRootPart
                    humanoidRootPart.CFrame = v.Parent.CFrame
                    wait(1)
                    fireproximityprompt(v, 20)
                end
            end
            wait(5) 
        end
    end
    
    ToggleAutoClaimCrystal:OnChanged(function()
        isRunningAutoClaimCrystal = ToggleAutoClaimCrystal.Value
        if isRunningAutoClaimCrystal then
            AutoClaimCrystalLoop()
        end
    end)
    
    game:GetService("ReplicatedStorage").Events.PlaceCrystaliser:InvokeServer()
    
    
    --Setting
    
    SaveManager:SetLibrary(Fluent)
    InterfaceManager:SetLibrary(Fluent)
    SaveManager:IgnoreThemeSettings()
    SaveManager:SetIgnoreIndexes({})
    InterfaceManager:SetFolder("AsulaScripts")
    SaveManager:SetFolder("AsulaScripts/bitcoin miner")
    InterfaceManager:BuildInterfaceSection(Tabs.Settings)
    SaveManager:BuildConfigSection(Tabs.Settings)
    Window:SelectTab(1)
    Fluent:Notify({
        Title = "Fluent",
        Content = "The script has been loaded.",
        Duration = 8
    })
    SaveManager:LoadAutoloadConfig()
    
    
    print("all done")


end