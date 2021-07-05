/*--------------------------------------------------
	=============== Autorun File ===============
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
------------------ Addon Information ------------------
local PublicAddonName = "Half-Life Resurgence Crack-Life"
local AddonName = "Half-Life Resurgence Crack-Life"
local AddonType = "SNPC"
local AutorunFile = "autorun/vj_hlr_hd_autorun.lua"
-------------------------------------------------------
local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")
if VJExists == true then
	include('autorun/vj_controls.lua')
	
	local vCat = "HL Resurgence: Crack-Life"
	VJ.AddCategoryInfo(vCat, {Icon = "vj_hl/icons/clcampaign.png"})

		--VJ.AddNPC("Adolf Hitler","npc_vj_hlrcl_hitleranth",vCat)
		--VJ.AddNPC("Annoying Houndeye","npc_vj_hlrcl_houndeye",vCat)
		--VJ.AddNPC("Big Smoke","npc_vj_hlrcl_smoke",vCat)
		VJ.AddNPC("Bonewheel","npc_vj_hlrcl_bonewheel",vCat)
		--VJ.AddNPC("Bullchicken","npc_vj_hlrcl_bullchicken",vCat)
		--VJ.AddNPC("Corrupted Gonarch","npc_vj_hlrcl_gonarch",vCat)
		--VJ.AddNPC("The Crowbar","npc_vj_hlrcl_crowbar",vCat)
		--VJ.AddNPC("Disco Vortigaunt","npc_vj_hlrcl_alienslave",vCat)
		VJ.AddNPC("Evil Scientist","npc_vj_hlrcl_evilsci",vCat)
		--VJ.AddNPC("Fat Assassin","npc_vj_hlrcl_fatassassin",vCat)
		--VJ.AddNPC("Filthy Controller","npc_vj_hlrcl_controller",vCat)
		--VJ.AddNPC("Foundation Repairmen","npc_vj_hlrcl_agrunt",vCat)
		VJ.AddNPC("Gentlecrab","npc_vj_hlrcl_gentlecrab",vCat)
		--VJ.AddNPC("Nazi","npc_vj_hlrcl_german",vCat)
		VJ.AddNPC("Chav","npc_vj_hlrcl_gopnik",vCat)
		VJ.AddNPC("Chav (Super)","npc_vj_hlrcl_gopnik_super",vCat)
		VJ.AddNPC("Chav (Mega)","npc_vj_hlrcl_gopnik_mega",vCat)
		VJ.AddNPC("Mario Zombie","npc_vj_hlrcl_mariozombie",vCat)
		VJ.AddNPC("Pink Panther","npc_vj_hlrcl_pinkpanther",vCat)
		--VJ.AddNPC("Retarded Scientist","npc_vj_hlrcl_scientist",vCat)
		--VJ.AddNPC("Retarded Security Guard","npc_vj_hlrcl_securityguard",vCat)
		--VJ.AddNPC("Shrek","npc_vj_hlrcl_shrek",vCat)
		--VJ.AddNPC("Skrillyd","npc_vj_hlrcl_skrillex",vCat)
		--VJ.AddNPC("Soviet Grunt","npc_vj_hlrcl_sgrunt",vCat)
		VJ.AddNPC("Suicide Bomber","npc_vj_hlrcl_terror",vCat)
		VJ.AddNPC("Skellington","npc_vj_hlrcl_spooky",vCat)
		VJ.AddNPC("The Nimrod Force Fuckshit Triple Mafia Smasher of Crackheads X5000 Alpha Version 133.7","npc_vj_hlrcl_finalboss",vCat)
		VJ.AddNPC("Viking Gargantua","npc_vj_hlrcl_garg_viking",vCat)
		VJ.AddNPC("Zombozo","npc_vj_hlrcl_zombozo",vCat)
	
-- !!!!!! DON'T TOUCH ANYTHING BELOW THIS !!!!!! -------------------------------------------------------------------------------------------------------------------------
	AddCSLuaFile(AutorunFile)
	VJ.AddAddonProperty(AddonName,AddonType)
else
	if (CLIENT) then
		chat.AddText(Color(0,200,200),PublicAddonName,
		Color(0,255,0)," was unable to install, you are missing ",
		Color(255,100,0),"VJ Base!")
	end
	timer.Simple(1,function()
		if not VJF then
			if (CLIENT) then
				VJF = vgui.Create("DFrame")
				VJF:SetTitle("ERROR!")
				VJF:SetSize(790,560)
				VJF:SetPos((ScrW()-VJF:GetWide())/2,(ScrH()-VJF:GetTall())/2)
				VJF:MakePopup()
				VJF.Paint = function()
					draw.RoundedBox(8,0,0,VJF:GetWide(),VJF:GetTall(),Color(200,0,0,150))
				end

				local VJURL = vgui.Create("DHTML",VJF)
				VJURL:SetPos(VJF:GetWide()*0.005, VJF:GetTall()*0.03)
				VJURL:Dock(FILL)
				VJURL:SetAllowLua(true)
				VJURL:OpenURL("https://sites.google.com/site/vrejgaming/vjbasemissing")
			elseif (SERVER) then
				timer.Create("VJBASEMissing",5,0,function() print("VJ Base is Missing! Download it from the workshop!") end)
			end
		end
	end)
end