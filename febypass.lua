_G.fsociety = {}

_G.fsociety.elliotalderson = function(...)
	local Remote = game:GetService("ReplicatedStorage"):WaitForChild("fsociety")
	Remote:FireServer("elliotalderson", ...)
end
