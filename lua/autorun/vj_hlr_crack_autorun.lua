/*--------------------------------------------------
	=============== Autorun File ===============
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
------------------ Addon Information ------------------
local PublicAddonName = "Half-Life Resurgence: Crack-Life"
local AddonName = "Half-Life Resurgence: Crack-Life"
local AddonType = "SNPC"
local AutorunFile = "autorun/vj_hlr_crack_autorun.lua"
-------------------------------------------------------
local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")
if VJExists == true then
	include('autorun/vj_controls.lua')
	
	local vCat = "HL Resurgence: Crack-Life"
	VJ.AddCategoryInfo(vCat, {Icon = "vj_hl/icons/clcampaign.png"})

		--VJ.AddNPC("Adolf Hitler","npc_vj_hlrcl_hitleranth",vCat)
		VJ.AddNPC("Annoying Houndeye","npc_vj_hlrcl_houndeye",vCat)
		VJ.AddNPC("Big Smoke","npc_vj_hlrcl_smoke",vCat)
		VJ.AddNPC("Bonewheel","npc_vj_hlrcl_bonewheel",vCat)
		VJ.AddNPC("Bullchicken","npc_vj_hlrcl_bullchicken",vCat)
		VJ.AddNPC("Corrupted Gonarch","npc_vj_hlrcl_gonarch",vCat)
		VJ.AddNPC("The Crowbar","npc_vj_hlrcl_crowbar",vCat)
		VJ.AddNPC("Disco Vortigaunt","npc_vj_hlrcl_alienslave",vCat)
		VJ.AddNPC("Evil Scientist","npc_vj_hlrcl_evilsci",vCat)
		VJ.AddNPC("Fat Assassin","npc_vj_hlrcl_fatassassin",vCat)
		VJ.AddNPC("Filthy Controller","npc_vj_hlrcl_controller",vCat)
		VJ.AddNPC("Foundation Repairman","npc_vj_hlrcl_agrunt",vCat)
		VJ.AddNPC("Gentlecrab","npc_vj_hlrcl_gentlecrab",vCat)
		VJ.AddNPC("German Grunt","npc_vj_hlrcl_german",vCat)
		VJ.AddNPC("Chav","npc_vj_hlrcl_gopnik",vCat)
		VJ.AddNPC("Chav (Super)","npc_vj_hlrcl_gopnik_super",vCat)
		VJ.AddNPC("Chav (Mega)","npc_vj_hlrcl_gopnik_mega",vCat)
		VJ.AddNPC("Mario Zombie","npc_vj_hlrcl_mariozombie",vCat)
		VJ.AddNPC("Pink Panther","npc_vj_hlrcl_pinkpanther",vCat)
		VJ.AddNPC("Retarded Scientist","npc_vj_hlrcl_scientist",vCat)
		VJ.AddNPC("Retarded Security Guard","npc_vj_hlrcl_securityguard",vCat)
		VJ.AddNPC("Shrek","npc_vj_hlrcl_shrek",vCat)
		VJ.AddNPC("Skrillyd","npc_vj_hlrcl_skrillex",vCat)
		VJ.AddNPC("Skrillyd's Player","sent_vj_hlrcl_recorder",vCat)
		--VJ.AddNPC("Skrillyd's Player (Huge)","sent_vj_hlrcl_recorder_huge",vCat)
		VJ.AddNPC("Soviet Grunt","npc_vj_hlrcl_sgrunt",vCat)
		VJ.AddNPC("Suicide Bomber","npc_vj_hlrcl_terror",vCat)
		VJ.AddNPC("Skellington","npc_vj_hlrcl_spooky",vCat)
		VJ.AddNPC("The Nimrod Force Fuckshit Triple Mafia Smasher of Crackheads X5000 Alpha Version 133.7","npc_vj_hlrcl_finalboss",vCat)
		VJ.AddNPC("Viking Gargantua","npc_vj_hlrcl_garg_viking",vCat)
		VJ.AddNPC("Zombozo","npc_vj_hlrcl_zombozo",vCat)
		
		VJ.AddNPC("Steveman","npc_vj_hlrcl_steveman",vCat)
		--VJ.AddNPC("Guardchav","npc_vj_hlrcl_guardchav",vCat)
		VJ.AddNPC("Admin Vladimir","npc_vj_hlrcl_vlad",vCat)
		VJ.AddNPC(" ","npc_vj_hlrcl_blackscary",vCat)
	
-- !!!!!! DON'T TOUCH ANYTHING BELOW THIS !!!!!! -------------------------------------------------------------------------------------------------------------------------
	AddCSLuaFile(AutorunFile)
	VJ.AddAddonProperty(AddonName,AddonType)
else
	if CLIENT then
		chat.AddText(Color(0, 200, 200), PublicAddonName,
		Color(0, 255, 0), " was unable to install, you are missing ",
		Color(255, 100, 0), "VJ Base!")
	end
	
	timer.Simple(1, function()
		if not VJBASE_ERROR_MISSING then
			VJBASE_ERROR_MISSING = true
			if CLIENT then
				// Get rid of old error messages from addons running on older code...
				if VJF && type(VJF) == "Panel" then
					VJF:Close()
				end
				VJF = true
				
				local frame = vgui.Create("DFrame")
				frame:SetSize(600, 160)
				frame:SetPos((ScrW() - frame:GetWide()) / 2, (ScrH() - frame:GetTall()) / 2)
				frame:SetTitle("Error: VJ Base is missing!")
				frame:SetBackgroundBlur(true)
				frame:MakePopup()
	
				local labelTitle = vgui.Create("DLabel", frame)
				labelTitle:SetPos(250, 30)
				labelTitle:SetText("VJ BASE IS MISSING!")
				labelTitle:SetTextColor(Color(255,128,128))
				labelTitle:SizeToContents()
				
				local label1 = vgui.Create("DLabel", frame)
				label1:SetPos(170, 50)
				label1:SetText("Garry's Mod was unable to find VJ Base in your files!")
				label1:SizeToContents()
				
				local label2 = vgui.Create("DLabel", frame)
				label2:SetPos(10, 70)
				label2:SetText("You have an addon installed that requires VJ Base but VJ Base is missing. To install VJ Base, click on the link below. Once\n                                                   installed, make sure it is enabled and then restart your game.")
				label2:SizeToContents()
				
				local link = vgui.Create("DLabelURL", frame)
				link:SetSize(300, 20)
				link:SetPos(195, 100)
				link:SetText("VJ_Base_Download_Link_(Steam_Workshop)")
				link:SetURL("https://steamcommunity.com/sharedfiles/filedetails/?id=131759821")
				
				local buttonClose = vgui.Create("DButton", frame)
				buttonClose:SetText("CLOSE")
				buttonClose:SetPos(260, 120)
				buttonClose:SetSize(80, 35)
				buttonClose.DoClick = function()
					frame:Close()
				end
			elseif (SERVER) then
				VJF = true
				timer.Remove("VJBASEMissing")
				timer.Create("VJBASE_ERROR_CONFLICT", 5, 0, function()
					print("VJ Base is missing! Download it from the Steam Workshop! Link: https://steamcommunity.com/sharedfiles/filedetails/?id=131759821")
				end)
			end
		end
	end)
end