include("entities/npc_vj_hlr1_securityguard/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2010-2025 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_hlr/cracklife10/unbarney.mdl" -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.VJ_NPC_Class = {"CLASS_CRACKLIFE_SCHIZO"} -- NPCs with the same class with be allied to each other
ENT.CanUseHD = false
---------------------------------------------------------------------------------------------------------------------------------------------
local baseInit = ENT.CustomOnInitialize
--
function ENT:CustomOnInitialize()
	//baseInit(self)
    self.SoundTbl_FootStep = {"vj_hlr/crack_fx/npc_step1.wav","vj_hlr/crack_fx/npc_step2.wav","vj_hlr/crack_fx/npc_step3.wav","vj_hlr/crack_fx/npc_step4.wav"}
    self.SoundTbl_Idle = {"vj_hlr/crack10_npc/barney/c1a0_ba_button.wav"}
	self.SoundTbl_IdleDialogue = {"vj_hlr/crack10_npc/barney/c1a0_ba_button.wav"}
	self.SoundTbl_IdleDialogueAnswer = {"vj_hlr/crack10_npc/generic/lockpick1.wav","vj_hlr/crack10_npc/generic/lockpick2.wav","vj_hlr/crack10_npc/generic/lockpick3.wav","vj_hlr/crack10_npc/generic/lockpick4.wav","vj_hlr/crack10_npc/generic/lockpick5.wav"}
	self.SoundTbl_CombatIdle = {"vj_hlr/crack10_npc/barney/aimforhead.wav","vj_hlr/crack10_npc/barney/stench.wav","vj_hlr/crack10_npc/barney/whatisthat.wav","vj_hlr/crack10_npc/barney/somethingstinky.wav","vj_hlr/crack10_npc/barney/somethingdied.wav"}
	self.SoundTbl_FollowPlayer = {}
	self.SoundTbl_UnFollowPlayer = {}
	self.SoundTbl_OnPlayerSight = {"vj_hlr/crack10_npc/barney/c1a0_ba_hevno.wav","vj_hlr/crack10_npc/barney/c1a0_ba_desk.wav","vj_hlr/crack10_npc/barney/c1a0_ba_headdown.wav"}
	self.SoundTbl_Investigate = {"vj_hlr/crack10_npc/barney/stench.wav","vj_hlr/crack10_npc/barney/whatisthat.wav"}
	self.SoundTbl_Alert = {"vj_hlr/crack10_npc/barney/ba_another.wav","vj_hlr/crack10_npc/barney/ba_buttugly.wav","vj_hlr/crack10_npc/barney/ba_close.wav","vj_hlr/crack10_npc/barney/ba_tomb.wav","vj_hlr/crack10_npc/barney/ba_whatyou.wav","vj_hlr/crack10_npc/barney/diebloodsucker.wav","vj_hlr/crack10_npc/barney/donthurtem.wav","vj_hlr/crack10_npc/barney/openfire.wav"}
	self.SoundTbl_CallForHelp = {}
	self.SoundTbl_BecomeEnemyToPlayer = {"vj_hlr/crack10_npc/barney/ba_endline.wav","vj_hlr/crack10_npc/barney/ba_iwish.wav","vj_hlr/crack10_npc/barney/ba_stepoff.wav","vj_hlr/crack10_npc/barney/ba_watchit.wav","vj_hlr/crack10_npc/barney/ba_uwish.wav","vj_hlr/crack10_npc/barney/ba_somuch.wav","vj_hlr/crack10_npc/barney/ba_whatyou.wav","vj_hlr/crack10_npc/barney/ba_close.wav"}
	self.SoundTbl_Suppressing = {}
	self.SoundTbl_OnGrenadeSight = {}
	self.SoundTbl_OnDangerSight = {}
	self.SoundTbl_OnKilledEnemy = {"vj_hlr/crack10_npc/barney/ba_firepl.wav","vj_hlr/crack10_npc/barney/ba_gotone.wav","vj_hlr/crack10_npc/barney/ba_seethat.wav"}
	self.SoundTbl_AllyDeath = {}
	self.SoundTbl_Pain = {}
	self.SoundTbl_DamageByPlayer = {"vj_hlr/crack10_npc/barney/leavealone.wav","vj_hlr/crack10_npc/barney/ba_dontmake.wav","vj_hlr/crack10_npc/barney/ba_dotoyou.wav","vj_hlr/crack10_npc/barney/ba_pissme.wav","vj_hlr/crack10_npc/barney/ba_whatyou.wav"}
	self.SoundTbl_Death = {"vj_hlr/crack10_npc/barney/ba_die1.wav","vj_hlr/crack10_npc/barney/ba_die2.wav","vj_hlr/crack10_npc/barney/ba_die3.wav"}
	
	self:Give("weapon_vj_hlr1_glock17")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	//print(key)
	if key == "step" then
		self:FootStepSoundCode()
	elseif key == "shoot" then
		local wep = self:GetActiveWeapon()
		if IsValid(wep) then
			wep:NPCShoot_Primary()
		end
	elseif key == "body" then
		VJ_EmitSound(self, "vj_hlr/crack_fx/bodydrop.wav", 75, 100)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local colorRed = VJ.Color2Byte(Color(130, 19, 10))

function ENT:HandleGibOnDeath(dmginfo, hitgroup)
	self.HasDeathSounds = false
	if self.HasGibOnDeathEffects then
		local effectData = EffectData()
		effectData:SetOrigin(self:GetPos() + self:OBBCenter())
		effectData:SetColor(colorRed)
		effectData:SetScale(120)
		util.Effect("VJ_Blood1", effectData)
		effectData:SetScale(8)
		effectData:SetFlags(3)
		effectData:SetColor(0)
		util.Effect("bloodspray", effectData)
		util.Effect("bloodspray", effectData)
	end
	
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/flesh1.mdl", {CollisionDecal="VJ_HLR1_Blood_Red", Pos=self:LocalToWorld(Vector(0, 0, 40))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/flesh2.mdl", {CollisionDecal="VJ_HLR1_Blood_Red", Pos=self:LocalToWorld(Vector(0, 1, 40))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/flesh3.mdl", {CollisionDecal="VJ_HLR1_Blood_Red", Pos=self:LocalToWorld(Vector(1, 0, 40))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/flesh4.mdl", {CollisionDecal="VJ_HLR1_Blood_Red", Pos=self:LocalToWorld(Vector(1, 1, 40))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/hgib_b_bone.mdl", {CollisionDecal="VJ_HLR1_Blood_Red", Pos=self:LocalToWorld(Vector(0, 0, 50))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/hgib_b_gib.mdl", {CollisionDecal="VJ_HLR1_Blood_Red", Pos=self:LocalToWorld(Vector(0, 0, 41))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/hgib_guts.mdl", {CollisionDecal="VJ_HLR1_Blood_Red", Pos=self:LocalToWorld(Vector(0, 0, 42))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/hgib_hmeat.mdl", {CollisionDecal="VJ_HLR1_Blood_Red", Pos=self:LocalToWorld(Vector(0, 0, 45))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/hgib_lung.mdl", {CollisionDecal="VJ_HLR1_Blood_Red", Pos=self:LocalToWorld(Vector(0, 1, 45))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/hgib_skull.mdl", {CollisionDecal="VJ_HLR1_Blood_Red", Pos=self:LocalToWorld(Vector(0, 0, 60))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/hgib_legbone.mdl", {CollisionDecal="VJ_HLR1_Blood_Red", Pos=self:LocalToWorld(Vector(0, 0, 15))})
	self:PlaySoundSystem("Gib", "vj_base/gib/splat.wav")
	self:PlaySoundSystem("Gib", "vj_hlr/crack_fx/bodysplat.wav")
	return true, {AllowSound = false}
end