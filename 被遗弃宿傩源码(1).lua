        local WindUI = loadstring(game:HttpGet("https://pastefy.app/ddceJmmm/raw"))()

        WindUI:Popup({
            Title = "👑尊贵的"..game.Players.LocalPlayer.DisplayName.."用户",
            Icon = "info",
            Content = "欢迎使用宿傩脚本",
            Buttons = {
                {
                    Title = "取消",
                    Callback = function() end,
                    Variant = "Tertiary",
                },
                {
                    Title = "执行",
                    Icon = "arrow-right",
                    Callback = function() 
                        DDZX = true 
                    end,
                    Variant = "Primary",
                }   
            }
        })

        repeat
            wait()
        until DDZX
       
       local Window = WindUI:CreateWindow({
            Title = " 宿傩脚本",
            Icon = "",
            Author = ("" .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name),
            Folder = "Sukuna",
            Size = UDim2.fromOffset(100, 150),
            Transparent = true,
            Theme = "Dark",
            UserEnabled = false,
            SideBarWidth = 200,
            HasOutline = true
        })

        Window:EditOpenButton({
            Title = "宿傩脚本",
            Icon = "sword",
            CornerRadius = UDim.new(0, 16),
            StrokeThickness = 2,
            Color = ColorSequence.new(Color3.fromHex("FF0F7B"), Color3.fromHex("F89B29")),
            Draggable = true
        })

        local Tab = Window:Tab({
            Title = "选项卡",
            Icon = "sword",
            Locked = false,
        })

local Button =
    Tab:Button(
    {
        Title = T("被遗弃"),
        Desc = T("加载被遗弃菜单"),
        Locked = false,
        Callback = function()
            game:GetService("RunService").Heartbeat:Connect(function()
                game.TextChatService.ChatWindowConfiguration.Enabled = true
            end)

            local function modifyPrompt(prompt)
                prompt.HoldDuration = 0
                prompt.RequiresLineOfSight = false
                prompt.MaxActivationDistance = 15
            end
        
            for _, prompt in ipairs(workspace:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") then
                    modifyPrompt(prompt)
                end
            end

            workspace.DescendantAdded:Connect(function(instance)
                if instance:IsA("ProximityPrompt") then
                    modifyPrompt(instance)
                end
            end)

            local Tab = Window:Tab({
                Title = T("被遗弃"),
                Icon = "bird",
                Locked = false,
            })

            local espT
            local textLabels = {}
            local connections = {} 
            local progressConnections = {}
            
            local function createEspText(obj, text, color)
                if textLabels[obj] then return end
                
                local billboard = Instance.new("BillboardGui")
                billboard.Adornee = obj
                billboard.Size = UDim2.new(0, 200, 0, 50)
                billboard.StudsOffset = Vector3.new(0, 3, 0)
                billboard.AlwaysOnTop = true
                
                local textLabel = Instance.new("TextLabel")
                textLabel.Size = UDim2.new(1, 0, 1, 0)
                textLabel.BackgroundTransparency = 1
                textLabel.Text = text
                textLabel.TextColor3 = color
                textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                textLabel.TextStrokeTransparency = 0
                textLabel.TextSize = 20
                textLabel.Font = Enum.Font.SourceSansBold
                textLabel.Parent = billboard
                billboard.Parent = obj
                textLabels[obj] = billboard
            
                table.insert(connections, obj.AncestryChanged:Connect(function(_, parent)
                    if not parent then
                        if textLabels[obj] then
                            textLabels[obj]:Remove()
                            textLabels[obj] = nil
                        end
                    end
                end))
            end
            
            local function setupEsp()
                for obj, label in pairs(textLabels) do
                    label:Remove()
                end
                textLabels = {}
                
                for _, conn in ipairs(progressConnections) do
                    conn:Disconnect()
                end
                progressConnections = {}
            
                local colors = {
                    Survivor = Color3.fromRGB(0, 255, 0),
                    Killer = Color3.fromRGB(255, 0, 0),
                    Generator = Color3.fromRGB(0, 191, 255),
                    Item = Color3.fromRGB(255, 255, 0)
                }
            
                local function setupPlayerEsp(folder, typeName)
                    for _, obj in ipairs(folder:GetChildren()) do
                        if obj:FindFirstChild("HumanoidRootPart") then
                            createEspText(obj.HumanoidRootPart, typeName..": "..obj.Name, colors[typeName])
                        end
                    end
            
                    table.insert(connections, folder.ChildAdded:Connect(function(obj)
                        if obj:FindFirstChild("HumanoidRootPart") then
                            createEspText(obj.HumanoidRootPart, typeName..": "..obj.Name, colors[typeName])
                        end
                    end))
                end
                
                if workspace:FindFirstChild("Players") then
                    if workspace.Players:FindFirstChild("Survivors") then
                        setupPlayerEsp(workspace.Players.Survivors, "Survivor")
                    end
                    if workspace.Players:FindFirstChild("Killers") then
                        setupPlayerEsp(workspace.Players.Killers, "Killer")
                    end
                end
            
                local function setupGeneratorEsp()
                    local ingameFolder = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Ingame")
                    if ingameFolder then
                        local mapFolder = ingameFolder:FindFirstChild("Map")
                        if mapFolder then
                            for _, g in ipairs(mapFolder:GetChildren()) do
                                if g.Name == "Generator" and g:FindFirstChild("Main") then
                                    createEspText(g.Main, T("发电机 进度:") .. g.Progress.Value, colors.Generator)
                                    
                                    local progressConn = g.Progress.Changed:Connect(function()
                                        if textLabels[g.Main] then
                                            textLabels[g.Main].TextLabel.Text = T("发电机 进度:") .. g.Progress.Value
                                        end
                                    end)
                                    table.insert(progressConnections, progressConn)
                                end
                            end
            
                            table.insert(connections, mapFolder.ChildAdded:Connect(function(child)
                                if child.Name == "Generator" and child:FindFirstChild("Main") then
                                    createEspText(child.Main, T("发电机 进度:") .. child.Progress.Value, colors.Generator)
                                    
                                    local progressConn = child.Progress.Changed:Connect(function()
                                        if textLabels[child.Main] then
                                            textLabels[child.Main].TextLabel.Text = T("发电机 进度:") .. child.Progress.Value
                                        end
                                    end)
                                    table.insert(progressConnections, progressConn)
                                end
                            end))
                        end
                    end
                end
                
                setupGeneratorEsp()
            
                local Items = {"Medkit", "BloxyCola"}
                local function setupItemEsp()
                    for _, item in ipairs(Items) do
                        for _, obj in ipairs(workspace.Map.Ingame:GetDescendants()) do
                            if obj:IsA("Model") and obj.Name == item then
                                for _, child in ipairs(obj:GetChildren()) do
                                    if child:IsA("BasePart") then
                                        createEspText(child, T("物品:")..obj.Name, colors.Item)
                                        break
                                    end
                                end
                            end
                        end
                        
                        table.insert(connections, workspace.Map.Ingame.DescendantAdded:Connect(function(descendant)
                            if descendant:IsA("Model") and table.find(Items, descendant.Name) then
                                for _, child in ipairs(descendant:GetChildren()) do
                                    if child:IsA("BasePart") then
                                        createEspText(child, T("物品:")..descendant.Name, colors.Item)
                                        break
                                    end
                                end
                            end
                        end))
                    end
                end
                
                setupItemEsp()
            end
            
            local function cleanup()
                for _, conn in ipairs(connections) do
                    conn:Disconnect()
                end
                connections = {}
                
                for _, conn in ipairs(progressConnections) do
                    conn:Disconnect()
                end
                progressConnections = {}
                
                for obj, label in pairs(textLabels) do
                    label:Remove()
                end
                textLabels = {}
            end
            
            local Toggle = Tab:Toggle({
                Title = T("透视对象"),
                Desc = T("发电机 幸存者 杀手 物品"),
                Icon = "bird",
                Type = "Checkbox",
                Default = false,
                Callback = function(state) 
                    espT = state
                    if state then
                        setupEsp()
                    else
                        cleanup()
                    end
                end
            })
            
            game:GetService("Workspace").DescendantAdded:Connect(function(descendant)
                if descendant.Name == "Map" and espT then
                    task.wait(2)
                    if espT then
                        cleanup()
                        setupEsp()
                    end
                end
            end)

            local Slider = Tab:Slider({
                Title = T("最大体力值"),
                Step = 1,
                Value = {
                    Min = 100,
                    Max = 1000,
                    Default = 100,
                },
                Callback = function(value)
                    task.spawn(function()
                        Sprinting.MaxStamina = value
                    end)
                end
            })

            local Slider = Tab:Slider({
                Title = T("奔跑速度"),
                Step = 1,
                Value = {
                    Min = 26,
                    Max = 40,
                    Default = 26,
                },
                Callback = function(value)
                    task.spawn(function()
                        Sprinting.SprintSpeed = value
                    end)
                end
            })

            local Slider = Tab:Slider({
                Title = T("冲刺体力消耗(秒)"),
                Step = 1,
                Value = {
                    Min = 0,
                    Max = 10,
                    Default = 7,
                },
                Callback = function(value)
                    task.spawn(function()
                        Sprinting.StaminaLoss = value
                    end)
                end
            })

            local Slider = Tab:Slider({
                Title = T("停止时恢复体力(秒)"),
                Step = 1,
                Value = {
                    Min = 20,
                    Max = 1000,
                    Default = 35,
                },
                Callback = function(value)
                    task.spawn(function()
                        Sprinting.StaminaGain = value
                    end)
                end
            })

            local autodo1x1T
            local Toggle = Tab:Toggle({
                Title = T("自动1x1窗口"),
                Desc = T("自动做1x1窗口"),
                Icon = "bird",
                Type = "Checkbox",
                Default = false,
                Callback = function(state) 
                    autodo1x1T = state
                    if state then
                        while autodo1x1T and task.wait(0.1) do
                            local player = game:GetService("Players").LocalPlayer
                            local popups = player.PlayerGui.TemporaryUI:GetChildren()
                            local VIM = game:GetService("VirtualInputManager")
                            for _, i in ipairs(popups) do
                                if i.Name == "1x1x1x1Popup" then
                                    local centerX = i.AbsolutePosition.X + (i.AbsoluteSize.X / 2)
                                    local centerY = i.AbsolutePosition.Y + (i.AbsoluteSize.Y / 2)
                                    VIM:SendMouseButtonEvent(
                                        centerX,
                                        centerY,
                                        Enum.UserInputType.MouseButton1.Value,
                                        true,
                                        player.PlayerGui,
                                        1
                                    )
                                    VIM:SendMouseButtonEvent(
                                        centerX,
                                        centerY,
                                        Enum.UserInputType.MouseButton1.Value,
                                        false,
                                        player.PlayerGui,
                                        1
                                    )
                                end
                            end
                        end
                    end
                end
            })

            local WantedChrges
            local Slider = Tab:Slider({
                Title = T("抛硬币费用"),
                Step = 1,
                
                Value = {
                    Min = 1,
                    Max = 3,
                    Default = 1,
                },
                Callback = function(value)
                    WantedChrges= value
                end
            })

            local CoinFlipping
            local Toggle =
                Tab:Toggle(
                {
                    Title = T("自动抛硬币"),
                    Desc = T("自动抛硬币"),
                    Icon = "bird",
                    Type = "Checkbox",
                    Default = false,
                    Callback = function(state)
                        CoinFlipping = state
                        if state then
                            while CoinFlipping and task.wait(1) do
                                if tonumber(game:GetService("Players").LocalPlayer.PlayerGui.MainUI.AbilityContainer.Reroll.Charges.Text) < WantedChrges then
                                    BlockRemote:FireServer("UseActorAbility", "CoinFlip")
                                end
                            end
                        end
                    end
                }
            )

            local SkibidiWait = 7
            local Slider = Tab:Slider({
                Title = T("修机时间"),
                Step = 1,
                Value = {
                    Min = 1,
                    Max = 10,
                    Default = SkibidiWait,
                },
                Callback = function(value)
                    SkibidiWait = value
                end
            })
            
            local SkibidiCS = 4
            local Slider = Tab:Slider({
                Title = T("修机次数"),
                Step = 1,
                Value = {
                    Min = 1,
                    Max = 4,
                    Default = SkibidiCS,
                },
                Callback = function(value)
                    SkibidiCS = value
                end
            })
            
            local autoxiujiT
            local Toggle = Tab:Toggle({
                Title = T("自动修机"),
                Desc = T("自动修机"),
                Icon = "bird",
                Type = "Checkbox",
                Default = false,
                Callback = function(state)
                    autoxiujiT = state
                    if state then
                        while autoxiujiT do
                            local PuzzleUI = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("PuzzleUI", 9999)
                            task.wait(SkibidiWait)
            
                            local FartNapFolder = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Ingame") and workspace.Map.Ingame:FindFirstChild("Map")
                            if FartNapFolder then
                                local closestGenerator, closestDistance = nil, 15
                                local playerPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position

                                for _, g in ipairs(FartNapFolder:GetChildren()) do
                                    if g.Name == "Generator" and g.Progress.Value < 100 then
                                        local distance = (g.Main.Position - playerPosition).Magnitude
                                        if distance <= 15 then
                                            local repairCount = tonumber(g:GetAttribute("RepairCount")) or 0
                                            if repairCount < SkibidiCS then
                                                if distance < closestDistance then
                                                    closestDistance = distance
                                                    closestGenerator = g
                                                end
                                            end
                                        end
                                    end
                                end
                                if closestGenerator then
                                    closestGenerator.Remotes.RE:FireServer()
                                    closestGenerator:SetAttribute(
                                        "RepairCount",
                                        (tonumber(closestGenerator:GetAttribute("RepairCount")) or 0) + 1
                                    )
                                end
                            end
                        end
                    end
                end
            })

            local lookDistance = 30
            local lookSlider = Tab:Slider({
                Title = T("看人距离"),
                Step = 1,
                Value = {
                    Min = 1,
                    Max = 50,
                    Default = lookDistance,
                },
                Callback = function(value)
                    lookDistance = value
                end
            })

            local attackDistance = 6
            local attackSlider = Tab:Slider({
                Title = T("砍人距离"),
                Step = 1,
                Value = {
                    Min = 1,
                    Max = 20,
                    Default = attackDistance,
                },
                Callback = function(value)
                    attackDistance = value
                end
            })

            local autoattackT
            local attackToggle = Tab:Toggle({
                Title = T("自动砍人"),
                Desc = T("杀手自动砍人"),
                Icon = "bird",
                Type = "Checkbox",
                Default = false,
                Callback = function(state)
                    autoattackT = state
                    if state then
                        while autoattackT and task.wait() do
                            local Players = game:GetService('Players')
                            local LocalPlayer = Players.LocalPlayer
                            local character = LocalPlayer.Character
                            if not character then continue end
                            
                            local humanoid = character:FindFirstChild('Humanoid')
                            local playerRoot = character:FindFirstChild('HumanoidRootPart')
                            if not humanoid or not playerRoot then continue end
                            
                            local RemoteEvent = game:GetService('ReplicatedStorage'):WaitForChild('Modules'):WaitForChild('Network'):WaitForChild('RemoteEvent')
                            local Camera = game:GetService('Workspace').CurrentCamera
                            
                            local lookTarget = nil
                            local minLookDistance = math.huge                         
                            local attackTarget = nil
                            local minAttackDistance = math.huge
                            
                            for _, player in pairs(Players:GetPlayers()) do
                                if player ~= LocalPlayer and player.Character then
                                    local targetRoot = player.Character:FindFirstChild('HumanoidRootPart')
                                    if targetRoot then
                                        local distance = (playerRoot.Position - targetRoot.Position).Magnitude
                                        
                                        if distance <= lookDistance and distance < minLookDistance then
                                            minLookDistance = distance
                                            lookTarget = targetRoot
                                        end
                                        
                                        if distance <= attackDistance and distance < minAttackDistance then
                                            minAttackDistance = distance
                                            attackTarget = targetRoot
                                        end
                                    end
                                end
                            end
                            
                            if lookTarget then
                                local lookVector = (lookTarget.Position - playerRoot.Position).Unit
                                playerRoot.CFrame = CFrame.new(playerRoot.Position, lookTarget.Position)
                                Camera.CFrame = CFrame.new(Camera.CFrame.Position, lookTarget.Position)
                            end
                            
                            if attackTarget then
                                RemoteEvent:FireServer('UseActorAbility', 'Slash')
                            end
                        end
                    end
                end
            })
        end
    }
)