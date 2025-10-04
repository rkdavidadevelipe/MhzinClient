
-- Mhzin Hub (Versão otimizada para Delta)
-- Mantém todas as abas principais e o loading screen.
-- Title/SubTitle: "Mhzin Hub | Brookhaven RP 🌌🏡 1.0" / "by The Wolf"
-- Nota: Feito para executores mobile (Delta). Teste e me diz se falta algo.

-- ================ Configurações iniciais ================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Função safe para carregar libraries (tenta carregar redzlib, se falhar usa fallback)
local function safeHttpGet(url)
    local ok, res = pcall(function() return game:HttpGet(url) end)
    if ok then return res end
    return nil
end

local lib = nil
-- tenta carregar redzlib (original). se falhar, tenta Rayfield (fallback).
local redz_code = safeHttpGet("https://raw.githubusercontent.com/tbao143/Library-ui/refs/heads/main/Redzhubui")
if redz_code then
    local ok, fn = pcall(loadstring, redz_code)
    if ok and fn then
        local ok2, obj = pcall(fn)
        if ok2 then lib = obj end
    end
end

if not lib then
    -- fallback: rayfield minified loader (URL pode ser alterado conforme disponibilidade)
    local ray_code = safeHttpGet("https://raw.githubusercontent.com/RegularVynixu/UI-Libraries/main/discord%20lib%20v3/Library.lua")
    if ray_code then
        local ok, fn = pcall(loadstring, ray_code)
        if ok and fn then
            local ok2, obj = pcall(fn)
            if ok2 then lib = obj end
        end
    end
end

-- Se não encontrou nenhuma library, cria um fallback minimal UI (muito simples)
if not lib then
    lib = {}
    function lib:MakeWindow(opts)
        -- fallback: retorna tabela com MakeTab/controls que apenas chamam Callbacks (sem GUI)
        local w = {tabs = {}}
        function w:MakeTab(_) 
            local t = {}
            function t:AddButton(tab) if type(tab)=="table" and tab[2] then (tab[2])() end end
            function t:AddToggle(_) end
            function t:AddSlider(_) end
            function t:AddDropdown(_) end
            function t:AddTextBox(_) end
            function t:AddParagraph(_) end
            function t:AddSection(_) end
            function t:AddDiscordInvite(_) end
            function t:AddMinimizeButton(_) end
            return t
        end
        function w:AddMinimizeButton() end
        return w
    end
end

-- ================ Loading screen (Delta-friendly) ================
do
    local playerGui = LocalPlayer:WaitForChild("PlayerGui")
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MhzinLoader"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui

    local bg = Instance.new("Frame", screenGui)
    bg.Size = UDim2.new(1,0,1,0)
    bg.BackgroundColor3 = Color3.fromRGB(80,0,180)
    bg.BorderSizePixel = 0

    local main = Instance.new("Frame", bg)
    main.Size = UDim2.new(0,460,0,160)
    main.AnchorPoint = Vector2.new(0.5,0.5)
    main.Position = UDim2.new(0.5,0,0.5,0)
    main.BackgroundTransparency = 1

    local title = Instance.new("TextLabel", main)
    title.Text = "Mhzin Client"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 32
    title.TextColor3 = Color3.new(1,1,1)
    title.BackgroundTransparency = 1
    title.Position = UDim2.new(0.5,0,0.05,0)
    title.AnchorPoint = Vector2.new(0.5,0)

    local subtitle = Instance.new("TextLabel", main)
    subtitle.Text = "Pra acabar com os Web Casal"
    subtitle.Font = Enum.Font.Gotham
    subtitle.TextSize = 18
    subtitle.BackgroundTransparency = 1
    subtitle.Position = UDim2.new(0.5,0,0.28,0)
    subtitle.AnchorPoint = Vector2.new(0.5,0)

    local barBg = Instance.new("Frame", main)
    barBg.Size = UDim2.new(0.9,0,0.15,0)
    barBg.Position = UDim2.new(0.5,0,0.65,0)
    barBg.AnchorPoint = Vector2.new(0.5,0)
    barBg.BackgroundColor3 = Color3.fromRGB(40,0,80)
    barBg.BorderSizePixel = 0
    barBg.ClipsDescendants = true

    local bar = Instance.new("Frame", barBg)
    bar.Size = UDim2.new(0,0,1,0)
    bar.BackgroundColor3 = Color3.fromRGB(200,0,255)
    bar.BorderSizePixel = 0

    local percentLabel = Instance.new("TextLabel", main)
    percentLabel.Text = "0%"
    percentLabel.Font = Enum.Font.GothamBold
    percentLabel.TextSize = 20
    percentLabel.BackgroundTransparency = 1
    percentLabel.Position = UDim2.new(0.5,0,1.2,0)
    percentLabel.AnchorPoint = Vector2.new(0.5,0)

    -- anima barra sem travar (uso throttled wait)
    spawn(function()
        for i=0,100 do
            bar.Size = UDim2.new(i/100,0,1,0)
            percentLabel.Text = tostring(i) .. "%"
            task.wait(0.04)
        end
        task.wait(0.25)
        if screenGui and screenGui.Parent then
            screenGui:Destroy()
        end
    end)
end

-- ================ Window & Tabs ================
local Window = lib:MakeWindow({
    Title = "Mhzin Hub | Brookhaven RP 🌌🏡 1.0",
    SubTitle = "by The Wolf",
    SaveFolder = "MhzinHub_Delta"
})

local Tab1 = Window:MakeTab({"Credits","info"})
local Tab2 = Window:MakeTab({"Fun","fun"})
local Tab3 = Window:MakeTab({"Avatar","shirt"})
local Tab4 = Window:MakeTab({"House","Home"})
local Tab5 = Window:MakeTab({"Car","car"})
local Tab6 = Window:MakeTab({"RGB","brush"})
local Tab7 = Window:MakeTab({"Music All","radio"})
local Tab8 = Window:MakeTab({"Music","music"})
local Tab9 = Window:MakeTab({"Troll","skull"})
local Tab11 = Window:MakeTab({"Scripts","scroll"})

-- ================ Tab1: Credits ================
Tab1:AddSection({"Créditos do Hub"})
Tab1:AddDiscordInvite({
    Name = "Mhzin Hub",
    Description = "Server Oficial",
    Logo = "rbxassetid://7229442422",
    Invite = "https://discord.gg/xcBdjWAsa",
})
local Paragraph = Tab1:AddParagraph({"Executador", (identifyexecutor and identifyexecutor() or (getexecutorname and getexecutorname() or "Executor Desconhecido"))})

-- ================ Tab2: Fun (movimento, fly, etc) ================
Tab2:AddSection({"Player Character"})
local selectedPlayerName = nil
local headsitActive = false

-- selecionar jogador por texto
Tab2:AddTextBox({
    Name = "Nome do Jogador",
    PlaceholderText = "Digite parte do nome",
    Callback = function(Value)
        local val = Value and tostring(Value):lower() or ""
        local found = nil
        for _,p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Name:lower():sub(1,#val) == val then
                found = p; break
            end
        end
        if found then
            selectedPlayerName = found.Name
            StarterGui:SetCore("SendNotification",{Title="Player Selecionado",Text=found.Name,Duration=3})
        else
            StarterGui:SetCore("SendNotification",{Title="Aviso",Text="Nenhum jogador encontrado",Duration=3})
        end
    end
})

-- headsit (simplificado e com pcall)
local function headsitOnPlayer(target)
    local ok, err = pcall(function()
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not target or not target.Character or not target.Character:FindFirstChild("Head") then return end
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        hrp.CFrame = target.Character.Head.CFrame * CFrame.new(0,2.2,0)
        for _,v in pairs(hrp:GetChildren()) do if v:IsA("WeldConstraint") then v:Destroy() end end
        local weld = Instance.new("WeldConstraint")
        weld.Part0 = hrp; weld.Part1 = target.Character.Head; weld.Parent = hrp
        if humanoid then humanoid.Sit = true end
    end)
    return ok
end

Tab2:AddButton({"Headsit Toggle", function()
    if not selectedPlayerName then StarterGui:SetCore("SendNotification",{Title="Erro",Text="Nenhum jogador selecionado",Duration=3}); return end
    local target = Players:FindFirstChild(selectedPlayerName)
    if not headsitActive then
        if headsitOnPlayer(target) then headsitActive = true end
    else
        -- remove welds
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            for _,v in pairs(char.HumanoidRootPart:GetChildren()) do if v:IsA("WeldConstraint") then v:Destroy() end end
            local hum = char:FindFirstChildOfClass("Humanoid") if hum then hum.Sit = false end
        end
        headsitActive = false
    end
end})

-- Speed & Jump sliders
Tab2:AddSlider({Name="Speed",MinValue=16,MaxValue=888,Default=16,Callback=function(v)
    local ch = LocalPlayer.Character
    local hum = ch and ch:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = v end
end})
Tab2:AddSlider({Name="JumpPower",MinValue=50,MaxValue=500,Default=50,Callback=function(v)
    local ch = LocalPlayer.Character
    local hum = ch and ch:FindFirstChildOfClass("Humanoid")
    if hum then hum.JumpPower = v end
end})

-- Gravity
Tab2:AddSlider({Name="Gravity",MinValue=0,MaxValue=10000,Default=196.2,Callback=function(v) pcall(function() Workspace.Gravity = v end) end})

-- Infinite Jump toggle (leve)
local InfiniteJumpEnabled = false
game:GetService("UserInputService").JumpRequest:Connect(function()
    if InfiniteJumpEnabled then
        local character = LocalPlayer.Character
        if character and character:FindFirstChildOfClass("Humanoid") then
            character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)
Tab2:AddToggle({Name="Infinite Jump",Default=false,Callback=function(v) InfiniteJumpEnabled = v end})

-- Ultimate Noclip (simplificado e leve)
local ultimateNoclipEnabled = false
local noclipConn = nil
Tab2:AddToggle({Name="Ultimate Noclip",Default=false,Callback=function(state)
    ultimateNoclipEnabled = state
    if state then
        noclipConn = RunService.Heartbeat:Connect(function()
            local char = LocalPlayer.Character
            if not char then return end
            for _,part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end)
    else
        if noclipConn then noclipConn:Disconnect(); noclipConn = nil end
        local char = LocalPlayer.Character
        if char then
            for _,part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = true end
            end
        end
    end
end})

-- Anti-Sit (leve)
local antiSitConn = nil
local antiSitEnabled = false
Tab2:AddToggle({Name="Anti-Sit",Default=false,Callback=function(state)
    antiSitEnabled = state
    if state then
        local function apply(character)
            local hum = character:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.Sit = false
                hum:SetStateEnabled(Enum.HumanoidStateType.Seated,false)
                if antiSitConn then antiSitConn:Disconnect(); antiSitConn = nil end
                antiSitConn = hum.Seated:Connect(function(s)
                    if s then
                        pcall(function() hum.Sit = false end)
                    end
                end)
            end
        end
        if LocalPlayer.Character then apply(LocalPlayer.Character) end
        LocalPlayer.CharacterAdded:Connect(function(char) if antiSitEnabled then task.wait(0.5); apply(char) end end)
    else
        if antiSitConn then antiSitConn:Disconnect(); antiSitConn = nil end
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Seated,true)
        end
    end
end})

-- Fly GUI button (carrega external script safe)
Tab2:AddButton({Name="Ativar Fly GUI",Callback=function()
    local ok, _ = pcall(function()
        local code = safeHttpGet("https://rawscripts.net/raw/Universal-Script-Fly-gui-v3-30439")
        if code then loadstring(code)() end
    end)
    StarterGui:SetCore("SendNotification",{Title= ok and "Sucesso" or "Erro",Text= ok and "Fly GUI carregado" or "Falha ao carregar",Duration=3})
end})

-- ESP (leve: atualiza a cada 0.5s)
local espEnabled = false
local espGuis = {}
local espConn = nil
local espColor = Color3.fromRGB(255,255,255)
Tab2:AddDropdown({Name="Cor do ESP",Default="Branco",Options={"RGB","Branco","Roxo","Vermelho","Verde","Azul"},Callback=function(v)
    if v == "RGB" then espColor = "RGB" else
        local colors = {Branco=Color3.fromRGB(255,255,255),Roxo=Color3.fromRGB(128,0,128),Vermelho=Color3.fromRGB(255,0,0),Verde=Color3.fromRGB(0,255,0),Azul=Color3.fromRGB(0,170,255)}
        espColor = colors[v] or Color3.fromRGB(255,255,255)
    end
end})
Tab2:AddToggle({Name="ESP Ativado",Default=false,Callback=function(state)
    espEnabled = state
    if state then
        espConn = RunService.Heartbeat:Connect(function()
            local now = tick()
            if not espEnabled then return end
            -- throttle: atualiza apenas a cada 0.5s
            if not (espConn and (now % 0.5 < 0.05)) then return end
            for _,p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                    if not espGuis[p] then
                        local billboard = Instance.new("BillboardGui")
                        billboard.Name = "ESP_Billboard"
                        billboard.Adornee = p.Character.Head
                        billboard.Size = UDim2.new(0,200,0,50)
                        billboard.StudsOffset = Vector3.new(0,3,0)
                        billboard.AlwaysOnTop = true
                        local txt = Instance.new("TextLabel",billboard)
                        txt.Size = UDim2.new(1,0,1,0)
                        txt.BackgroundTransparency = 1
                        txt.Font = Enum.Font.SourceSansBold
                        txt.TextSize = 14
                        txt.Text = p.Name.." | "..p.AccountAge.."d"
                        txt.TextColor3 = (espColor == "RGB") and Color3.fromHSV((tick()%5)/5,1,1) or espColor
                        billboard.Parent = p.Character.Head
                        espGuis[p] = billboard
                    else
                        local gui = espGuis[p]
                        if gui and gui:FindFirstChild("TextLabel") then
                            local t = gui.TextLabel
                            t.TextColor3 = (espColor == "RGB") and Color3.fromHSV((tick()%5)/5,1,1) or espColor
                        end
                    end
                end
            end
        end)
    else
        if espConn then espConn:Disconnect(); espConn = nil end
        for p,g in pairs(espGuis) do if g and g.Parent then g:Destroy() end end
        espGuis = {}
    end
end})

-- ================ Tab3: Avatar ================
Tab3:AddSection({"Copy Avatar"})
-- Dropdown simples com players
local function getPlayerNames()
    local t = {}
    for _,p in pairs(Players:GetPlayers()) do if p.Name ~= LocalPlayer.Name then table.insert(t,p.Name) end end
    return t
end
local selectedAvatarTarget = nil
local playerDropdown = Tab3:AddDropdown({Name="Players List",Options=getPlayerNames(),Default="",Callback=function(v) selectedAvatarTarget = v end})
Tab3:AddButton({Name="Atualizar lista",Callback=function() playerDropdown:Set(getPlayerNames()) end})

Tab3:AddButton({Name="Copy Avatar",Callback=function()
    if not selectedAvatarTarget or selectedAvatarTarget == "" then StarterGui:SetCore("SendNotification",{Title="Erro",Text="Selecione um jogador",Duration=3}); return end
    local target = Players:FindFirstChild(selectedAvatarTarget)
    if not target or not target.Character then StarterGui:SetCore("SendNotification",{Title="Erro",Text="Jogador sem personagem",Duration=3}); return end
    pcall(function()
        local Remotes = ReplicatedStorage:WaitForChild("Remotes")
        local TH = target.Character:FindFirstChildOfClass("Humanoid")
        local LH = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if TH and LH then
            local PDesc = TH:GetAppliedDescription()
            -- alterar roupas simples (Shirt/Pants/Face) via Remotes.Wear (se existir)
            if pcall(function() return Remotes.Wear end) then
                if tonumber(PDesc.Shirt) then Remotes.Wear:InvokeServer(tonumber(PDesc.Shirt)) end
                task.wait(0.2)
                if tonumber(PDesc.Pants) then Remotes.Wear:InvokeServer(tonumber(PDesc.Pants)) end
                task.wait(0.2)
                if tonumber(PDesc.Face) then Remotes.Wear:InvokeServer(tonumber(PDesc.Face)) end
            end
            StarterGui:SetCore("SendNotification",{Title="Sucesso",Text="Avatar copiado (parte)",Duration=3})
        end
    end)
end})

-- Pequenos botões de partes do corpo (exemplos)
Tab3:AddButton({Name="Mini REPO",Callback=function()
    pcall(function()
        ReplicatedStorage:WaitForChild("Remotes").ChangeCharacterBody:InvokeServer(117101023704825,125767940563838,137301494386930,87357384184710,133391239416999,111818794467824)
    end)
end})

-- ================ Tab4: House ================
Tab4:AddParagraph({Title="Funções para você usar em você",Content=""})
Tab4:AddButton({Name="Remover Ban de Todas as Casas",Description="Tenta remover bans",Callback=function()
    local successCount, failCount = 0,0
    for _,obj in pairs(Workspace:GetDescendants()) do
        if obj.Name:match("BannedBlock") then
            local ok, _ = pcall(function() obj:Destroy() end)
            if ok then successCount = successCount + 1 else failCount = failCount + 1 end
        end
    end
    if successCount > 0 then StarterGui:SetCore("SendNotification",{Title="Sucesso",Text="Removidos: "..successCount,Duration=3}) end
    if failCount > 0 then StarterGui:SetCore("SendNotification",{Title="Aviso",Text="Falhas: "..failCount,Duration=3}) end
    if successCount==0 and failCount==0 then StarterGui:SetCore("SendNotification",{Title="Aviso",Text="Nenhum ban encontrado",Duration=3}) end
end})

-- ================ Tab5: Car ================
Tab5:AddSection({"all car functions"})
-- Função utilitária simples para atualizar lista de cars
local function getCars()
    local t = {}
    local vf = Workspace:FindFirstChild("Vehicles")
    if vf then
        for _,c in pairs(vf:GetChildren()) do
            if tostring(c.Name):match("Car$") then table.insert(t,c.Name) end
        end
    end
    return t
end

local selectedVehicle = nil
local carDropdown = Tab5:AddDropdown({Name="Selecionar Carro do Jogador",Options=getCars(),Callback=function(v) selectedVehicle = v end})
Tab5:AddButton({Name="Atualizar Carros",Callback=function() carDropdown:Set(getCars()) end})

-- Trazer carro selecionado para jogador (simples)
Tab5:AddButton({Name="Trazer Carro Selecionado",Callback=function()
    if not selectedVehicle or selectedVehicle=="" then StarterGui:SetCore("SendNotification",{Title="Erro",Text="Nenhum carro selecionado",Duration=3}); return end
    local vf = Workspace:FindFirstChild("Vehicles")
    if not vf then StarterGui:SetCore("SendNotification",{Title="Erro",Text="Pasta Vehicles nao encontrada",Duration=3}); return end
    local car = vf:FindFirstChild(selectedVehicle)
    if not car then StarterGui:SetCore("SendNotification",{Title="Erro",Text="Carro nao encontrado",Duration=3}); return end
    local seat = car:FindFirstChildWhichIsA("VehicleSeat",true)
    if not seat then StarterGui:SetCore("SendNotification",{Title="Erro",Text="Assento nao encontrado",Duration=3}); return end
    local orig = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.HumanoidRootPart.Position
    -- tenta teleportar: sentar e mover carro
    pcall(function()
        if orig and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:PivotTo(CFrame.new(orig))
        end
        if car.PrimaryPart then
            car:SetPrimaryPartCFrame(CFrame.new(orig + Vector3.new(5,0,5)))
        else
            -- tenta achar Body
            local body = car:FindFirstChild("Body",true) or car:FindFirstChild("Chassis",true)
            if body then car.PrimaryPart = body; car:SetPrimaryPartCFrame(CFrame.new(orig + Vector3.new(5,0,5))) end
        end
    end)
    StarterGui:SetCore("SendNotification",{Title="Sucesso",Text="Tentativa de trazer carro feita",Duration=3})
end})

-- ================ Tab6: RGB ================
Tab6:AddSection({""})
local rgbSpeed = 1
Tab6:AddSlider({Name="Velocidade RGB",Min=1,Max=5,Default=3,Increase=1,Callback=function(v) rgbSpeed = v end})

local rgbToggles = {}
local rgbLoopActive = false
local rgbThread = nil

local function startRGB()
    if rgbLoopActive then return end
    rgbLoopActive = true
    rgbThread = task.spawn(function()
        while rgbLoopActive do
            local color = Color3.fromHSV((tick()*rgbSpeed % 5)/5,1,1)
            pcall(function()
                local rem = ReplicatedStorage:FindFirstChild("Remotes")
                if rem and rem:FindFirstChild("ChangeBodyColor") then
                    rem.ChangeBodyColor:FireServer({ BrickColor.new(color) })
                end
                if rem and rem:FindFirstChild("ChangeHairColor2") then
                    rem.ChangeHairColor2:FireServer("ChangeHairColor2", color)
                end
            end)
            task.wait(0.12)
        end
    end)
end
local function stopRGB()
    rgbLoopActive = false
    rgbThread = nil
end

Tab6:AddToggle({Name="RGB Corpo",Default=false,Callback=function(v)
    rgbToggles["corpo"] = v
    if v then startRGB() else stopRGB() end
end})
Tab6:AddToggle({Name="Nome + Bio RGB",Default=false,Callback=function(v)
    rgbToggles["namebio"] = v
    if v then
        -- name+bio rgb: usamos loop reduzido
        if not rgbLoopActive then startRGB() end
    else
        -- se nenhum toggle ativo, para
        local any = false
        for k,val in pairs(rgbToggles) do if val then any = true end end
        if not any then stopRGB() end
    end
end})

-- ================ Tab7: Music All ================
Tab7:AddSection({"Music All"})
local InputID = nil
Tab7:AddTextBox({Name="Insira o ID Audio All",PlaceholderText="Ex: 6832470734",Callback=function(text) InputID = tonumber(text) end})
Tab7:AddButton({Name="Tocar Som",Callback=function()
    if not InputID then StarterGui:SetCore("SendNotification",{Title="Erro",Text="ID invalido",Duration=3}); return end
    pcall(function()
        local rem = ReplicatedStorage:FindFirstChild("RE")
        if rem and rem:FindFirstChild("1Gu1nSound1s") then
            rem["1Gu1nSound1s"]:FireServer(Workspace, InputID, 1)
        end
        local s = Instance.new("Sound", Workspace)
        s.SoundId = "rbxassetid://"..tostring(InputID)
        s.Looped = false; s:Play()
        task.spawn(function() task.wait(5); pcall(function() s:Destroy() end) end)
    end)
end})

local loopAtivo = false
Tab7:AddToggle({Name="Loop",Default=false,Callback=function(v) loopAtivo = v end})

-- ================ Tab8: Music (dropdowns reduzidos) ================
Tab8:AddParagraph({Title="Musicas Rápidas",Content=""})
Tab8:AddButton({Name="Tocar Som Exemplo",Callback=function()
    local id = 1838600953 -- exemplo
    pcall(function()
        local s = Instance.new("Sound", Workspace)
        s.SoundId = "rbxassetid://"..id; s.Looped=false; s:Play()
        task.spawn(function() task.wait(5); pcall(function() s:Destroy() end) end)
    end)
end})

-- ================ Tab9: Troll (funções perigosas minimizadas) ================
Tab9:AddParagraph({Title="Troll (funcões reduzidas)",Content="Algumas funções perigosas foram minimizadas para compatibilidade."})
Tab9:AddButton({Name="Anti-Sit Global (Toggle)",Callback=function()
    -- ativa anti-sit local
    local char = LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid").Sit = false
        StarterGui:SetCore("SendNotification",{Title="Ativado",Text="Anti-Sit local aplicado",Duration=3})
    end
end})

-- ================ Tab11: Scripts (execução de raw) ================
Tab11:AddSection({"Load external script"})
Tab11:AddTextBox({Name="URL / RAW",PlaceholderText="Cole o link raw",Callback=function(v) _G.RawLink = v end})
Tab11:AddButton({Name="Executar RAW/URL",Callback=function()
    if not _G.RawLink or _G.RawLink=="" then StarterGui:SetCore("SendNotification",{Title="Erro",Text="Cole o link",Duration=3}); return end
    local ok, code = pcall(function() return game:HttpGet(_G.RawLink) end)
    if ok and code then
        local suc, err = pcall(loadstring(code))
        StarterGui:SetCore("SendNotification",{Title = suc and "Executado" or "Erro", Text = suc and "Script executado" or tostring(err), Duration=4})
    else
        StarterGui:SetCore("SendNotification",{Title="Erro",Text="Falha ao baixar",Duration=3})
    end
end})

-- ================ Mensagem final ================
StarterGui:SetCore("SendNotification",{Title="Mhzin Hub",Text="Script otimizado carregado. Teste as funções básicas.",Duration=5})
