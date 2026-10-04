_G.fsociety = _G.fsociety or {}
_G.fsociety = setmetatable(_G.fsociety, {
	__index = function(t, k)
		if k == "elliotalderson" then
			return function(code)
				local Remote = game:GetService("ReplicatedStorage"):WaitForChild("fsociety")
				Remote:FireServer("elliotalderson", code)
			end
		end
	end,
	__newindex = function(t, k, v)
		rawset(t, k, v)
	end,
	__metatable = "fsociety"
})
return _G.fsociety
