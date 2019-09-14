local Ants = {}
local names = {
    "Gatherer",
    "Army",
    "Builder"
}
Ants.SetUp = function(Name, StrongSuit)
    local Folder = Instance.new("Folder")
    Folder.Name = Name
    Folder.Parent = game.Workspace
    local Config = Instance.new("Configuration")
    Config.Parent = Folder
    for i = 1, #names do
        local CV = Instance.new("Color3Value")
        CV.Value = Color3.new(math.random(0,255),math.random(0,255),math.random(0,255))
        CV.Name = names[i].."Color"
        CV.Parent = Config
    end
    local StringValue = Instance.new("StringValue")
    StringValue.Parent = Config
    StringValue.Value = StrongSuit
    StringValue.Name = "StrongSuit"
    local Queen = Instance.new("Model")
    Queen.Name = "Queen"
    Queen.Parent = Folder
    local Hum = Instance.new("Humanoid", Queen)
    local HRP = Instance.new("Part")
    HRP.Name = "HumanoidRootPart"
    HRP.Size = Vector3.new(1,.5,1)
    HRP.Position = Vector3.new(math.random(-50,50),0,math.random(-50,50))
    HRP.Parent = Queen
    HRP.BrickColor = BrickColor.random()
    local QM = Instance.new("SpecialMesh")
    QM.MeshId = "rbxassetid://3558097891"
    QM.Parent = HRP
    local Deposit = Instance.new("Part")
    Deposit.Name = "Deposit"
    Deposit.Size = Vector3.new(1,1,1)
    Deposit.Parent = Queen.Parent
    Deposit.BrickColor = BrickColor.random()
    Deposit.Anchored = true
    Deposit.CanCollide = false
    Deposit.Position = HRP.Position + Vector3.new(5,0,0)
    Queen.PrimaryPart = HRP
	return Queen, Folder
end
--Ants will be squares rn
Ants.Creation = function(Queen, Folder, BirthTime)
    local Larva = Queen:Clone()
    local Range = 50
	Larva.Parent = Folder
    Larva.PrimaryPart.Position = Queen.PrimaryPart.Position + Vector3.new(math.random(-Range,Range),0,math.random(-Range,Range))
    Larva.Name = "Larva"
    Larva.PrimaryPart.Color = Color3.fromRGB(255,255,255)
    local Config = Instance.new("Configuration")
    Config.Parent = Larva
    local BV = Instance.new("BoolValue")
    BV.Parent = Config
    BV.Name = "IsActive"
    local Class = Instance.new("StringValue")
    Class.Parent = Larva
    Class.Name = "Class"
    local x = math.random(0, 100)
    wait(BirthTime)
    if x >= 0 and x < 25 then -- was supposed to be an 'and'
        if Folder.Configuration.StrongSuit.Value == "Army" then
            Class.Value = "Gatherer"
        elseif Folder.Configuration.StrongSuit.Value == "Builder" then
            Class.Value = "Army"
        elseif Folder.Configuration.StrongSuit.Value == "Gatherer" then
            Class.Value = "Builder"
        end
    elseif x > 24 and x < 50 then
        if Folder.Configuration.StrongSuit.Value == "Army" then
            Class.Value = "Builder"
        elseif Folder.Configuration.StrongSuit.Value == "Builder" then
            Class.Value = "Gatherer"
        elseif Folder.Configuration.StrongSuit.Value == "Gatherer" then
            Class.Value = "Army"
        end
    elseif x > 49 or x <= 100 then
        Class.Value = Folder.Configuration.StrongSuit.Value
    end
    Larva.Name = Class.Value.."Ant"
    if Class.Value == "Gatherer" then
        Larva.PrimaryPart.Color = Folder.Configuration:WaitForChild("GathererColor").Value
    elseif Class.Value == "Builder" then
        Larva.PrimaryPart.Color = Folder.Configuration:WaitForChild("BuilderColor").Value
    elseif Class.Value == "Army" then
        Larva.PrimaryPart.Color = Folder.Configuration:WaitForChild("ArmyColor").Value
    end
	return Larva
end

return Ants
