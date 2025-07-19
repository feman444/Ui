-- Serviços
local MarketplaceService = game:GetService("MarketplaceService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerMouse = Player:GetMouse()

-- Configuração principal
local redzlib = {
    Themes = {
        Darker = {
            ["Color Hub 1"] = ColorSequence.new({
                ColorSequenceKeypoint.new(0.00, Color3.fromRGB(15, 25, 45)),
                ColorSequenceKeypoint.new(0.50, Color3.fromRGB(25, 40, 70)),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(15, 25, 45))
            }),
            ["Color Hub 2"] = Color3.fromRGB(20, 35, 60),
            ["Color Stroke"] = Color3.fromRGB(35, 55, 85),
            ["Color Theme"] = Color3.fromRGB(70, 160, 255),
            ["Color Text"] = Color3.fromRGB(230, 240, 250),
            ["Color Dark Text"] = Color3.fromRGB(160, 180, 210)
        },
        -- Outros temas originais...
    },
    -- Restante da configuração...
}

-- Funções auxiliares
local function SetProps(instance, props)
    if props then
        for prop, value in pairs(props) do
            instance[prop] = value
        end
    end
    return instance
end

local function SetChildren(instance, children)
    if children then
        for _, child in pairs(children) do
            child.Parent = instance
        end
    end
    return instance
end

local function Create(...)
    local args = {...}
    local new = Instance.new(args[1])
    local children = {}
    
    if type(args[2]) == "table" then
        SetProps(new, args[2])
        SetChildren(new, args[3])
        children = args[3] or {}
    elseif typeof(args[2]) == "Instance" then
        new.Parent = args[2]
        SetProps(new, args[3])
        SetChildren(new, args[4])
        children = args[4] or {}
    end
    return new
end

-- Função para inserir tema
local function InsertTheme(instance, type)
    local theme = redzlib.Themes[redzlib.Save.Theme]
    
    if type == "Gradient" then
        instance.Color = theme["Color Hub 1"]
    elseif type == "Frame" then
        instance.BackgroundColor3 = theme["Color Hub 2"]
    -- Outros tipos...
    end
    
    table.insert(redzlib.Instances, {
        Instance = instance,
        Type = type
    })
    return instance
end

-- Elementos da UI
AddEle("Corner", function(parent, cornerRadius)
    return Create("UICorner", parent, {
        CornerRadius = cornerRadius or UDim.new(0, 8)
    })
end)

AddEle("Stroke", function(parent, props, ...)
    local args = {...}
    local stroke = Create("UIStroke", parent, {
        Color = args[1] or redzlib.Themes[redzlib.Save.Theme]["Color Stroke"],
        Thickness = args[2] or 1.5,
        ApplyStrokeMode = "Border"
    })
    if props then SetProps(stroke, props) end
    return InsertTheme(stroke, "Stroke")
end)

-- Função principal para criar janela
function redzlib:MakeWindow(config)
    local viewportSize = workspace.CurrentCamera.ViewportSize
    local uiScale = viewportSize.Y / 450
    
    local screenGui = Create("ScreenGui", CoreGui, {
        Name = "redz Library V5",
    }, {
        Create("UIScale", { Scale = uiScale })
    })

    -- Configuração da janela principal
    local mainFrame = InsertTheme(Create("ImageButton", screenGui, {
        Size = UDim2.fromOffset(unpack(redzlib.Save.UISize)),
        Position = UDim2.new(0.5, -redzlib.Save.UISize[1]/2, 0.5, -redzlib.Save.UISize[2]/2),
        BackgroundTransparency = 0.03,
        Name = "Hub"
    }), "Main")

    -- Configuração visual
    Make("Gradient", mainFrame, { Rotation = 45 })
    Make("Corner", mainFrame, UDim.new(0, 10))
    Make("Stroke", mainFrame, nil, nil, 2)
    
    -- Barra superior
    local topBar = Create("Frame", mainFrame, {
        Size = UDim2.new(1, 0, 0, 28),
        BackgroundTransparency = 1,
        Name = "TopBar"
    })

    -- Título com fonte personalizada
    local title = InsertTheme(Create("TextLabel", topBar, {
        Position = UDim2.new(0, 15, 0.5),
        AnchorPoint = Vector2.new(0, 0.5),
        AutomaticSize = Enum.AutomaticSize.XY,
        Text = config.Title or "redz Library V5",
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        Name = "Title"
    }), "Text")

    -- Botões de controle
    local closeButton = Create("ImageButton", topBar, {
        Size = UDim2.new(0, 14, 0, 14),
        Position = UDim2.new(1, -10, 0.5),
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundTransparency = 1,
        Image = "rbxassetid://10747384394",
        Name = "Close"
    })

    -- ... (implementação completa dos controles)

    -- Funções da janela
    local window = {
        Minimized = false,
        SaveSize = nil
    }

    function window:Minimize()
        if self.Minimized then
            -- Restaurar
            mainFrame.Size = self.SaveSize
        else
            -- Minimizar
            self.SaveSize = mainFrame.Size
            mainFrame.Size = UDim2.new(mainFrame.Size.X.Scale, mainFrame.Size.X.Offset, 0, 28)
        end
        self.Minimized = not self.Minimized
    end

    -- ... (implementação completa dos métodos da janela)

    return window
end

-- Funções para elementos UI (tabs, buttons, etc.)
function redzlib:AddTab(name, icon)
    -- Implementação original com novo visual
end

function redzlib:AddButton(config)
    -- Implementação original com novo visual
end

-- ... (todas as outras funções originais)

return redzlib
