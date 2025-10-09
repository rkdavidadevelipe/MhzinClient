-- === WHITELIST PROTEGIDA ===
local NICKS_WHITELIST = {
    "Mhzin19", -- dono
    "Kakah", -- autorizado
}

local Players = game:GetService("Players")
local player = Players.LocalPlayer

if not table.find(NICKS_WHITELIST, player.Name) then
    warn("[HavenXClient] Acesso negado para " .. player.Name .. ". Você não está na whitelist.")
    return -- impede execução do resto do script
end

-- Serviços
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local Debris = game:GetService("Debris")

-- Carregar WindUI
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- Criar Janela
local Window = WindUI:CreateWindow({
    Title = "HavenXClient - Painel ADM",
    Icon = "shield",
    Author = "by Kakah",
    Theme = "Dark",
    Size = UDim2.fromOffset(580, 460),
})

-- Aba principal
local Tab = Window:Tab({
    Title = "Comandos Gerais",
    Icon = "bomb",
})

-- Notificação inicial
WindUI:Notify({
    Title = "Painel Admin",
    Content = "HavenXClient ADM carregado por "..player.DisplayName,
    Duration = 3,
    Icon = "shield",
})

-- Jogador selecionado
local selectedPlayer = nil
local Dropdown = nil

-- Função para criar dropdown com jogadores atuais (incluindo autor)
local function createDropdown()
    local names = {}
    for _, plr in ipairs(Players:GetPlayers()) do
        table.insert(names, plr.Name)
    end

    if Dropdown then Dropdown:Remove() end

    Dropdown = Tab:Dropdown({
        Title = "Selecionar Jogador",
        Values = names,
        Multi = false,
        Callback = function(value)
            selectedPlayer = Players:FindFirstChild(value)
        end
    })
end

task.delay(1, createDropdown)
Players.PlayerAdded:Connect(createDropdown)
Players.PlayerRemoving:Connect(createDropdown)

-- Função para executar comandos
local function executeCommand(command)
    if not selectedPlayer then
        WindUI:Notify({
            Title = "Erro",
            Content = "Nenhum jogador selecionado!",
            Duration = 2,
            Icon = "x-circle",
        })
        return
    end

    local char = selectedPlayer.Character
    local humanoid = char and char:FindFirstChild("Humanoid")
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local myRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

    if command == "kick" then
        pcall(function()
            selectedPlayer:Kick("Você foi kickado pelo admin pelos seus atos"..player.DisplayName.." *©KAKAH STUDIOS*")
        end)

    elseif command == "jail" and root then
        local jail = Instance.new("Model")
        jail.Name = "AdminJail_" .. selectedPlayer.Name
        jail.Parent = workspace

        local function createWall(size, pos)
            local wall = Instance.new("Part")
            wall.Size = size
            wall.Anchored = true
            wall.CanCollide = true
            wall.BrickColor = BrickColor.new("Really black")
            wall.Position = root.Position + pos
            wall.Parent = jail

            local selection = Instance.new("SelectionBox")
            selection.Adornee = wall
            selection.Color3 = Color3.fromRGB(150, 0, 255)
            selection.LineThickness = 0.1
            selection.Parent = wall
        end

        createWall(Vector3.new(10, 1, 10), Vector3.new(0, -0.5, 0))
        createWall(Vector3.new(10, 20, 1), Vector3.new(0, 10, 5))
        createWall(Vector3.new(10, 20, 1), Vector3.new(0, 10, -5))
        createWall(Vector3.new(1, 20, 10), Vector3.new(5, 10, 0))
        createWall(Vector3.new(1, 20, 10), Vector3.new(-5, 10, 0))
        createWall(Vector3.new(10, 1, 10), Vector3.new(0, 20, 0))

        humanoid.WalkSpeed, humanoid.JumpPower = 0, 0

    elseif command == "unjail" then
        local jail = workspace:FindFirstChild("AdminJail_" .. selectedPlayer.Name)
        if jail then jail:Destroy() end
        if humanoid then humanoid.WalkSpeed, humanoid.JumpPower = 16, 50 end

    elseif command == "freeze" and humanoid then
        humanoid.WalkSpeed, humanoid.JumpPower = 0, 0
        humanoid.PlatformStand = true

    elseif command == "unfreeze" and humanoid then
        humanoid.WalkSpeed, humanoid.JumpPower = 16, 50
        humanoid.PlatformStand = false

    elseif command == "godmode" and humanoid then
        humanoid.MaxHealth = math.huge
        humanoid.Health = math.huge

    elseif command == "tp" and root and myRoot then
        root.CFrame = myRoot.CFrame * CFrame.new(0, 0, -3)

    elseif command == "bring" and root and myRoot then
        root.CFrame = myRoot.CFrame * CFrame.new(0, 0, 3)

    elseif command == "kill" and humanoid then
        humanoid.Health = 0

    elseif command == "verify" then
        WindUI:Notify({
            Title = "✅ VERIFIED ✅",
            Content = selectedPlayer.DisplayName .. " verificado!",
            Duration = 3,
            Icon = "check-circle",
        })

    elseif command == "speed" and humanoid then
        humanoid.WalkSpeed = 100
    end
end

local commands = {
    {Title = "Jail",     Cmd = "jail",     Desc = "Prende o jogador"},
    {Title = "Unjail",   Cmd = "unjail",   Desc = "Libera da prisão"},
    {Title = "Freeze",   Cmd = "freeze",   Desc = "Congela o jogador"},
    {Title = "Unfreeze", Cmd = "unfreeze", Desc = "Descongela o jogador"},
    {Title = "TP",       Cmd = "tp",       Desc = "Teleporta até você"},
    {Title = "Bring",    Cmd = "bring",    Desc = "Traz até você"},
    {Title = "Kill",     Cmd = "kill",     Desc = "Mata o jogador"},
    {Title = "Verify",   Cmd = "verify",   Desc = "Verifica o jogador"},
    {Title = "Speed",    Cmd = "speed",    Desc = "Deixa rápido"},
}

for _, data in ipairs(commands) do
    Tab:Button({ Title = data.Title, Desc = data.Desc, Callback = function() executeCommand(data.Cmd) end })
end
