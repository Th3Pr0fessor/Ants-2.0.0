local Ants = {}

Ants.Generate = function(Part, wt, Resource)
    while wait(wt) do
        local PC = Part:Clone()
        PC.Size = Vector3.new(4,4,4)
        PC.Name = Resource
        PC.Parent = game.Workspace
        PC.Position = Part.Position + Vector3.new(math.random(-100,100),0,math.random(-100,100))
        PC.Transparency = 0
    end
end

return Ants
