_G.fsociety = _G.fsociety or {}

_G.fsociety.elliotalderson = function(code)
	local Remote = game:GetService("ReplicatedStorage"):WaitForChild("fsociety")
	Remote:FireServer("elliotalderson", code)
end
