/*--------------------------------------------------
	=============== Autorun File ===============
	*** Copyright (c) 2012-2025 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
local clrVersion = "1.3-beta1-hotfix2"
VJ.AddPlugin("Crack-Life Resurgence", "NPC", clrVersion)

VJ.HLR_VERSION = clrVersion

-- sound.Add( {
-- 	name = "HLRCL_UFOSD_IntroSound",
-- 	channel = CHAN_VOICE,
-- 	volume = 1.0,
-- 	level = 100,
-- 	pitch = 100,
-- 	sound = "vj_hlr/crack_npc/joj/JOJbossintro.wav"
-- } )

-- util.PrecacheSound("HLRCL_UFOSD_IntroSound")

	include('autorun/vj_controls.lua')

	if !VJ then VJ = {} end -- If VJ isn't initialized, initialize it!
	
	
	local vCat = "HL Resurgence: Crack-Life"
	local vCat2 = "HL Resurgence: Crack-Life: Anniversary"
	VJ.AddCategoryInfo(vCat, {Icon = "vj_hl/icons/clcampaign.png"})
	VJ.AddCategoryInfo(vCat2, {Icon = "vj_hl/icons/cl10.png"})

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
		VJ.AddNPC("SkrillyD","npc_vj_hlrcl_skrillex",vCat)
		VJ.AddNPC("SkrillyD's Player","sent_vj_hlrcl_recorder",vCat)
		--VJ.AddNPC("SkrillyD's Player (Huge)","sent_vj_hlrcl_recorder_huge",vCat)
		VJ.AddNPC("Soviet Grunt","npc_vj_hlrcl_sgrunt",vCat)
		VJ.AddNPC("Suicide Bomber","npc_vj_hlrcl_terror",vCat)
		VJ.AddNPC("Skellington","npc_vj_hlrcl_spooky",vCat)
		VJ.AddNPC("The Final Boss","npc_vj_hlrcl_finalboss",vCat)
		VJ.AddNPC("Viking Gargantua","npc_vj_hlrcl_garg_viking",vCat)
		VJ.AddNPC("Zombozo","npc_vj_hlrcl_zombozo",vCat)
		
		-- 1.1
		VJ.AddNPC("Admin Vladimir","npc_vj_hlrcl_vlad",vCat)
		VJ.AddNPC("Steveman","npc_vj_hlrcl_steveman",vCat)
		
		-- 1.2
		VJ.AddNPC(" ","npc_vj_hlrcl_blackscary",vCat)
		VJ.AddNPC("Skellington Master","npc_vj_hlrcl_2spooky",vCat)
		VJ.AddNPC("JOJ UFO","npc_vj_hlrcl_joj",vCat)
		VJ.AddNPC("Snark","npc_vj_hlrcl_snark",vCat)
		VJ.AddNPC("Snark Nest","npc_vj_hlrcl_snarknest",vCat)
		
		--[[
		VJ.AddNPC("Guardchav","npc_vj_hlrcl_guardchav",vCat)
		https://www.youtube.com/watch?v=MUDMSzMjAdg
		-- siemka lost all the files for 2014 campaign, there's a recreated model floating around but is being gatekept.
		--]]
		
		-- 1.3
		//VJ.AddNPC("Black Meat Guard","npc_vj_hlrcl10_securityguard",vCat2)
		//VJ.AddNPC("Black Meat Scientist","npc_vj_hlrcl10_scientist",vCat2)
		//VJ.AddNPC("Gus","npc_vj_hlrcl10_gus",vCat2)
		//VJ.AddNPC("Camera Man","npc_vj_hlrcl10_camerasci",vCat2)
		//VJ.AddNPC("Drill","npc_vj_hlrcl10_drill",vCat2)
		//VJ.AddNPC("Extra Clean","npc_vj_hlrcl10_extraclean",vCat2)
		//VJ.AddNPC("Fairy","npc_vj_hlrcl10_fairy",vCat2)
		VJ.AddNPC("Forklift","npc_vj_hlrcl10_forklift",vCat2)
		VJ.AddNPC("Gentlezombie","npc_vj_hlrcl10_zombie",vCat2)
		VJ.AddNPC("CIA Man","npc_vj_hlrcl10_ciaman",vCat2)
		VJ.AddNPC("Fedora Man","npc_vj_hlrcl10_fedorasci",vCat2)
		VJ.AddNPC("JMan","npc_vj_hlrcl10_jman",vCat2)
		//VJ.AddNPC("Mercenary","npc_vj_hlrcl10_hgrunt",vCat2)
		VJ.AddNPC("Monkey","npc_vj_hlrcl10_monkey",vCat2)
		VJ.AddNPC("Rocket Gina","npc_vj_hlrcl10_rocketgina",vCat2)
		VJ.AddNPC("UN Peacekeeper","npc_vj_hlrcl10_unbarney",vCat2)
		VJ.AddNPC("Vaccinator","npc_vj_hlrcl10_cleansuit",vCat2)

		// anniversary campaign exclusive
		//VJ.AddNPC("Enforcer","npc_vj_hlrcl10_badbarney",vCat2)
		//VJ.AddNPC("Cowboy","npc_vj_hlrcl10_cowboy",vCat2)
		//VJ.AddNPC("Jungle Dart Man","npc_vj_hlrcl10_dartsci",vCat2)
		//VJ.AddNPC("Jungle Man","npc_vj_hlrcl10_junglesci",vCat2)
		//VJ.AddNPC("Eugene Prigozhin","npc_vj_hlrcl10_eugene",vCat2)
		//VJ.AddNPC("Fat Scientist","npc_vj_hlrcl10_fatsci",vCat2)
		//VJ.AddNPC("Firebomb Man","npc_vj_hlrcl10_firebombsci",vCat2)
		//VJ.AddNPC("George Droid","npc_vj_hlrcl10_georgedroid",vCat2)
		//VJ.AddNPC("The Streamer","npc_vj_hlrcl10_streamer",vCat2)
		//VJ.AddNPC("Gonarch Rider","npc_vj_hlrcl10_gonrider",vCat2)
		VJ.AddNPC("Pollo","npc_vj_hlrcl10_chicken",vCat2)
		//VJ.AddNPC("Musket Zombie","npc_vj_hlrcl10_musketzombie",vCat2)
		//VJ.AddNPC("Moped Grunt","npc_vj_hlrcl10_mopedgrunt",vCat2)
		//VJ.AddNPC("Scooter Man","npc_vj_hlrcl10_scootersci",vCat2)
		//VJ.AddNPC("Robo Ninja","npc_vj_hlrcl10_roboninja",vCat2)
		//VJ.AddNPC("Robo Wizard","npc_vj_hlrcl10_robowizard",vCat2)
		//VJ.AddNPC("Doorman","npc_vj_hlrcl10_shieldbarn",vCat2)
		//VJ.AddNPC("Indian Warrior","npc_vj_hlrcl10_iwar",vCat2)
		//VJ.AddNPC("Indian Bolt Man","npc_vj_hlrcl10_rajesh",vCat2)
		//VJ.AddNPC("Skibidi Loader","npc_vj_hlrcl10_skibidiloader",vCat2)
		//VJ.AddNPC("Skibidi Toilet","npc_vj_hlrcl10_controller",vCat2)
		//VJ.AddNPC("Varg Vikernes","npc_vj_hlrcl10_varg",vCat2)
		//VJ.AddNPC("Dr. Oetker","npc_vj_hlrcl10_oetker",vCat2)
		//VJ.AddNPC("White Knight (Bow)","npc_vj_hlrcl10_bowknight",vCat2)
		//VJ.AddNPC("White Knight","npc_vj_hlrcl10_whiteknight",vCat2)

		// you'll see all of anniversary npcs eventually, i just barely have time to work on this addon
		
		VJ.AddConVar("vj_hlrcl_skipufointro", 0, {FCVAR_ARCHIVE})
		VJ.AddConVar("vj_hlrcl_oldchavsounds", 0, {FCVAR_ARCHIVE})
		VJ.AddConVar("vj_hlrcl_disableracism", 1, {FCVAR_NONE})
		-----------------------------------------------------------------------------
		VJ.AddConVar("vj_hlrcl_allyspawn_2spooky", 1, {FCVAR_ARCHIVE})
		VJ.AddConVar("vj_hlrcl_selfspawn_2spooky", 1, {FCVAR_ARCHIVE})
		VJ.AddConVar("vj_hlrcl_allyspawn_skrillex", 1, {FCVAR_ARCHIVE})
		VJ.AddConVar("vj_hlrcl_allyspawn_joj", 1, {FCVAR_ARCHIVE})
		VJ.AddConVar("vj_hlrcl_allyspawn_vlad", 1, {FCVAR_ARCHIVE})
		VJ.AddConVar("vj_hlrcl_allyspawn_finalboss", 1, {FCVAR_ARCHIVE})
		
if CLIENT then
	hook.Add("PopulateToolMenu", "VJ_ADDTOMENU_HLRCL", function()
		spawnmenu.AddToolMenuOption("DrVrej", "SNPC Configures", "Crack-Life Resurgence", "Crack-Life Resurgence", "", "", function(Panel)
			Panel:AddControl("Button", {Text = "#vjbase.menu.general.reset.everything", Command = "vj_hlrcl_skipufointro 0\nvj_hlrcl_oldchavsounds 0\nvj_hlrcl_disableracism 1\nvj_hlrcl_allyspawn_2spooky 1\nvj_hlrcl_selfspawn_2spooky 1\nvj_hlrcl_allyspawn_finalboss 1\nvj_hlrcl_allyspawn_joj 1\nvj_hlrcl_allyspawn_skrillex 1\nvj_hlrcl_allyspawn_vlad 1"})
			Panel:AddControl("Checkbox", {Label = "Skip JOJ UFO intro", Command = "vj_hlrcl_skipufointro"})
			Panel:ControlHelp("Skips the 19 second long intro when spawning JOJ UFO.")
			Panel:AddControl("Checkbox", {Label = "Old Chav Sounds", Command = "vj_hlrcl_oldchavsounds"})
			Panel:ControlHelp("Force old Chav voice acting from original Crack-Life.\nDoesn't affect Mega & Super Chavs.")
			Panel:AddControl("Checkbox", {Label = "Disable spicy speech for Soviet Grunts", Command = "vj_hlrcl_disableracism"})
			Panel:ControlHelp("")
			Panel:AddControl("Label", {Text = "BOSS ALLY SPAWNING OPTIONS:"})
			Panel:AddControl("Checkbox", {Label = "Allow Skrillyd to spawn allies", Command = "vj_hlrcl_allyspawn_skrillex"})
			Panel:AddControl("Checkbox", {Label = "Allow JOJ UFO to spawn allies", Command = "vj_hlrcl_allyspawn_joj"})
			Panel:AddControl("Checkbox", {Label = "Allow Admin Vladimir to spawn allies", Command = "vj_hlrcl_allyspawn_vlad"})
			Panel:AddControl("Checkbox", {Label = "Allow the Final Boss to spawn allies", Command = "vj_hlrcl_allyspawn_finalboss"})
			Panel:AddControl("Checkbox", {Label = "Allow Skellington Master to spawn allies", Command = "vj_hlrcl_allyspawn_2spooky"})
			Panel:AddControl("Checkbox", {Label = "Allow Skellington Master to spawn itself on flinch", Command = "vj_hlrcl_selfspawn_2spooky"})
		end)
	end)
end