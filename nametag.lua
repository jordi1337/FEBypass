local TagConfig = require(game.ServerScriptService.NameTag.TagConfig)
local settings = TagConfig.settings

local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local gui = script:FindFirstChild("OverheadUI")

local AFKEvent = require(RS:WaitForChild("BridgeNet2")).ReferenceBridge("AFKSystem")

local playerPlatforms = {}

local platformEvent = RS:WaitForChild("PlayerPlatform")

platformEvent.OnServerEvent:Connect(function(plr, platform)
	if platform == "Computer" or platform == "Mobile" or platform == "Console" then
		playerPlatforms[plr] = platform
		local character = plr.Character
		if character then
			local head = character:FindFirstChild("Head")

			if head then
				local nametag = head:FindFirstChild("OverheadUI")

				if nametag then
					local iconHolder = nametag:FindFirstChild("IconHolder")

					if iconHolder then
						if iconHolder:FindFirstChild("PC") then
							iconHolder.PC.Visible = platform == "Computer"
						end

						if iconHolder:FindFirstChild("MOBILE") then
							iconHolder.MOBILE.Visible = platform == "Mobile"
						end

						if iconHolder:FindFirstChild("CONSOLE") then
							iconHolder.CONSOLE.Visible = platform == "Console"
						end
					end
				end
			end
		end
	end
end)

Players.PlayerAdded:Connect(function(plr)

	plr.CharacterAdded:Connect(function(char)
		local head = char:WaitForChild("Head")
		local humanoid = char:WaitForChild("Humanoid")

		humanoid.NameDisplayDistance = 0
		humanoid.DisplayName = ""

		local teamColor = plr.TeamColor
		local plrRank = plr:GetRankInGroup(settings.Main)
		local nametag = gui:Clone()

		nametag.Username.Username.Text = plr.DisplayName .. " (@" .. plr.Name .. ")"
		nametag.Rank.Rank.Text = plr:GetRoleInGroup(settings.Main) or settings.GuestRankName

		nametag.IconHolder.AFK.Visible = false
		nametag.IconHolder.PC.Visible = false
		nametag.IconHolder.MOBILE.Visible = false
		nametag.IconHolder.CONSOLE.Visible = false

		if plrRank >= settings.MinDeveloperRank and plrRank <= settings.MaxDeveloperRank then
			nametag.IconHolder.DEVELOPER.Visible = true
		else
			nametag.IconHolder.DEVELOPER.Visible = false
		end

		if plr.MembershipType == Enum.MembershipType.Premium then
			nametag.IconHolder.PREMIUM.Visible = true
		else
			nametag.IconHolder.PREMIUM.Visible = false
		end
		
		local platform = playerPlatforms[plr]

		if platform == "Computer" then
			nametag.IconHolder.PC.Visible = true

		elseif platform == "Mobile" then
			nametag.IconHolder.MOBILE.Visible = true

		elseif platform == "Console" then
			nametag.IconHolder.CONSOLE.Visible = true
		end

		if plrRank >= settings.MinMudurRank then
			nametag.Username.Username.TextColor3 = settings.MudurNameColor
		end

		if plrRank >= settings.MinYonetimRank then
			nametag.Username.Username.TextColor3 = settings.YonetimNameColor
		end

		if teamColor == settings.TeamColors.Main then
			nametag.Division.Visible = true
			nametag.Division.BransName.Text = "Asayiş Şube Müdürlüğü"
			nametag.Rank.Rank.Text = plr:GetRoleInGroup(settings.Main) or settings.GuestRankName
			nametag.Division.Frame.BransImage.Image = settings.DivisionIcons.Main
			nametag.Division.Frame.UIGradient.Color = settings.TeamGradients.Main.Color
			nametag.Division.Frame.UIGradient.Rotation = settings.TeamGradients.Main.Rotation

		elseif teamColor == settings.TeamColors.HS then
			nametag.Division.Visible = true
			nametag.Division.BransName.Text = "Havacılık Şube Müdürlüğü"

			local hs = plr:GetRoleInGroup(settings.HS) or settings.GuestRankName
			nametag.Rank.Rank.Text = (nametag.Rank.Rank.Text or "") .. " / " .. hs

			nametag.Division.Frame.BransImage.Image = settings.DivisionIcons.HS
			nametag.Division.Frame.UIGradient.Color = settings.TeamGradients.HS.Color
			nametag.Division.Frame.UIGradient.Rotation = settings.TeamGradients.HS.Rotation

		elseif teamColor == settings.TeamColors.Mudur then
			nametag.Division.Visible = true
			nametag.Division.BransName.Text = "Emniyet Müdürleri"
			nametag.Rank.Rank.Text = plr:GetRoleInGroup(settings.Main) or settings.GuestRankName
			nametag.Division.Frame.BransImage.Image = settings.DivisionIcons.Mudur
			nametag.Division.Frame.UIGradient.Color = settings.TeamGradients.Mudur.Color
			nametag.Division.Frame.UIGradient.Rotation = settings.TeamGradients.Mudur.Rotation

		elseif teamColor == settings.TeamColors.POH then
			nametag.Division.Visible = true
			nametag.Division.BransName.Text = "Özel Harekat Başkanlığı"

			local poh = plr:GetRoleInGroup(settings.POH) or settings.GuestRankName
			nametag.Rank.Rank.Text = (nametag.Rank.Rank.Text or "") .. " / " .. poh

			nametag.Division.Frame.BransImage.Image = settings.DivisionIcons.POH
			nametag.Division.Frame.UIGradient.Color = settings.TeamGradients.POH.Color
			nametag.Division.Frame.UIGradient.Rotation = settings.TeamGradients.POH.Rotation

		elseif teamColor == settings.TeamColors.SGK then
			nametag.Division.Visible = true
			nametag.Division.BransName.Text = "Sahil Güvenlik Komutanlığı"

			local sgk = plr:GetRoleInGroup(settings.SGK) or settings.GuestRankName
			nametag.Rank.Rank.Text = (nametag.Rank.Rank.Text or "") .. " / " .. sgk

			nametag.Division.Frame.BransImage.Image = settings.DivisionIcons.SGK
			nametag.Division.Frame.UIGradient.Color = settings.TeamGradients.SGK.Color
			nametag.Division.Frame.UIGradient.Rotation = settings.TeamGradients.SGK.Rotation

		elseif teamColor == settings.TeamColors.TS then
			nametag.Division.Visible = true
			nametag.Division.BransName.Text = "Trafik Şube Müdürlüğü"

			local ts = plr:GetRoleInGroup(settings.TS) or settings.GuestRankName
			nametag.Rank.Rank.Text = (nametag.Rank.Rank.Text or "") .. " / " .. ts

			nametag.Division.Frame.BransImage.Image = settings.DivisionIcons.TS
			nametag.Division.Frame.UIGradient.Color = settings.TeamGradients.TS.Color
			nametag.Division.Frame.UIGradient.Rotation = settings.TeamGradients.TS.Rotation

		elseif teamColor == settings.TeamColors.YS then
			nametag.Division.Visible = true
			nametag.Division.BransName.Text = "Yunus Şube Müdürlüğü"

			local ys = plr:GetRoleInGroup(settings.YS) or settings.GuestRankName
			nametag.Rank.Rank.Text = (nametag.Rank.Rank.Text or "") .. " / " .. ys

			nametag.Division.Frame.BransImage.Image = settings.DivisionIcons.YS
			nametag.Division.Frame.UIGradient.Color = settings.TeamGradients.YS.Color
			nametag.Division.Frame.UIGradient.Rotation = settings.TeamGradients.YS.Rotation

		elseif teamColor == settings.TeamColors.CK then
			nametag.Division.Visible = true
			nametag.Division.BransName.Text = "Çevik Kuvvet Şube Müdürlüğü"

			local ck = plr:GetRoleInGroup(settings.CK) or settings.GuestRankName
			nametag.Rank.Rank.Text = (nametag.Rank.Rank.Text or "") .. " / " .. ck

			nametag.Division.Frame.BransImage.Image = settings.DivisionIcons.CK
			nametag.Division.Frame.UIGradient.Color = settings.TeamGradients.CK.Color
			nametag.Division.Frame.UIGradient.Rotation = settings.TeamGradients.CK.Rotation

		elseif plr.Team == game:GetService("Teams"):FindFirstChild("Vatandaş") then
			nametag.Rank.Rank.Text = plr:GetRoleInGroup(settings.Main) or settings.GuestRankName

			nametag.Division.Visible = true
			nametag.Division.BransName.Text = "Siviller"

			nametag.Division.Frame.BransImage.Image = settings.DivisionIcons.Vatandas
			nametag.Division.Frame.UIGradient.Color = settings.TeamGradients.Vatandas.Color
			nametag.Division.Frame.UIGradient.Rotation = settings.TeamGradients.Vatandas.Rotation

		else
			nametag.Division.Visible = false
		end

		nametag.Parent = head
		nametag.Adornee = head
	end)
end)

Players.PlayerRemoving:Connect(function(plr)
	playerPlatforms[plr] = nil
end)

AFKEvent:Connect(function(plr, value)
	if typeof(value) ~= "boolean" then
		return
	end

	local character = plr.Character
	if not character then
		return
	end

	local head = character:FindFirstChild("Head")
	if not head then
		return
	end

	local nametag = head:FindFirstChild("OverheadUI")
	if not nametag then
		return
	end

	local iconHolder = nametag:FindFirstChild("IconHolder")
	if not iconHolder then
		return
	end

	local afkIcon = iconHolder:FindFirstChild("AFK")

	if afkIcon and afkIcon:IsA("GuiObject") then
		afkIcon.Visible = value
	end
end)
