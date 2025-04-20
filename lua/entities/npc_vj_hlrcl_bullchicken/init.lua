include("entities/npc_vj_hlr1_bullsquid/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2010-2025 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consself of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_hlr/cracklife/bullsquid.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.VJ_NPC_Class = {"CLASS_CRACKLIFE"}
ENT.CanUseHD = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.SoundTbl_FootStep = {"vj_hlr/crack_fx/npc_step1.wav","vj_hlr/crack_fx/npc_step2.wav","vj_hlr/crack_fx/npc_step3.wav","vj_hlr/crack_fx/npc_step4.wav"}
	self.SoundTbl_Idle = {"vj_hlr/crack_npc/bullchicken/bc_idle1.wav","vj_hlr/crack_npc/bullchicken/bc_idle2.wav","vj_hlr/crack_npc/bullchicken/bc_idle3.wav","vj_hlr/crack_npc/bullchicken/bc_idle4.wav","vj_hlr/crack_npc/bullchicken/bc_idle5.wav"}
	self.SoundTbl_Alert = {"vj_hlr/crack_npc/bullchicken/bc_idle1.wav","vj_hlr/crack_npc/bullchicken/bc_idle2.wav","vj_hlr/crack_npc/bullchicken/bc_idle3.wav","vj_hlr/crack_npc/bullchicken/bc_idle4.wav","vj_hlr/crack_npc/bullchicken/bc_idle5.wav"}
	self.SoundTbl_BeforeMeleeAttack = {"vj_hlr/crack_npc/bullchicken/bc_idle4.wav"}
	self.SoundTbl_MeleeAttack = {"vj_hlr/gsrc/npc/bullchicken/bc_bite1.wav","vj_hlr/gsrc/npc/bullchicken/bc_bite2.wav","vj_hlr/gsrc/npc/bullchicken/bc_bite3.wav"}
	self.SoundTbl_MeleeAttackMiss = {"vj_hlr/gsrc/npc/zombie/claw_miss1.wav","vj_hlr/gsrc/npc/zombie/claw_miss2.wav"}
	self.SoundTbl_RangeAttack = {"vj_hlr/gsrc/npc/bullchicken/bc_attack2.wav","vj_hlr/gsrc/npc/bullchicken/bc_attack3.wav"}
	self.SoundTbl_Pain = {"vj_hlr/crack_npc/bullchicken/bc_idle4.wav","vj_hlr/crack_npc/bullchicken/bc_idle5.wav"}
	self.SoundTbl_Death = {"vj_hlr/crack_npc/bullchicken/bc_die1.wav","vj_hlr/crack_npc/bullchicken/bc_die2.wav","vj_hlr/crack_npc/bullchicken/bc_die3.wav"}
	self:SetCollisionBounds(Vector(30, 30 , 44), Vector(-30, -30, 0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	if key == "step" then
		self:FootStepSoundCode()
	elseif key == "melee_bite" or key == "melee_whip" then
		self:MeleeAttackCode()
	elseif key == "rangeattack" then
		self:RangeAttackCode()
	elseif key == "body" then
		VJ_EmitSound(self, "vj_hlr/crack_fx/bodydrop.wav", 75, 100)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local colorYellow = VJ.Color2Byte(Color(255, 221, 35))
--
function ENT:HandleGibOnDeath(dmginfo, hitgroup)
	self.HasDeathSounds = false
	if self.HasGibOnDeathEffects then
		local effectData = EffectData()
		effectData:SetOrigin(self:GetPos() + self:OBBCenter())
		effectData:SetColor(colorYellow)
		effectData:SetScale(120)
		util.Effect("VJ_Blood1", effectData)
		effectData:SetScale(8)
		effectData:SetFlags(3)
		effectData:SetColor(1)
		util.Effect("bloodspray", effectData)
		util.Effect("bloodspray", effectData)
	end
	
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/agib1.mdl", {BloodType="Yellow", CollisionDecal="VJ_HLR1_Blood_Yellow", Pos=self:LocalToWorld(Vector(0, 0, 40))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/agib2.mdl", {BloodType="Yellow", CollisionDecal="VJ_HLR1_Blood_Yellow", Pos=self:LocalToWorld(Vector(0, 0, 20))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/agib3.mdl", {BloodType="Yellow", CollisionDecal="VJ_HLR1_Blood_Yellow", Pos=self:LocalToWorld(Vector(0, 0, 30))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/agib4.mdl", {BloodType="Yellow", CollisionDecal="VJ_HLR1_Blood_Yellow", Pos=self:LocalToWorld(Vector(0, 0, 35))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/agib5.mdl", {BloodType="Yellow", CollisionDecal="VJ_HLR1_Blood_Yellow", Pos=self:LocalToWorld(Vector(0, 0, 50))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/agib6.mdl", {BloodType="Yellow", CollisionDecal="VJ_HLR1_Blood_Yellow", Pos=self:LocalToWorld(Vector(0, 0, 55))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/agib7.mdl", {BloodType="Yellow", CollisionDecal="VJ_HLR1_Blood_Yellow", Pos=self:LocalToWorld(Vector(0, 1, 40))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/agib8.mdl", {BloodType="Yellow", CollisionDecal="VJ_HLR1_Blood_Yellow", Pos=self:LocalToWorld(Vector(0, 0, 45))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/agib9.mdl", {BloodType="Yellow", CollisionDecal="VJ_HLR1_Blood_Yellow", Pos=self:LocalToWorld(Vector(0, 0, 25))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/agib10.mdl", {BloodType="Yellow", CollisionDecal="VJ_HLR1_Blood_Yellow", Pos=self:LocalToWorld(Vector(0, 0, 15))})
	self:PlaySoundSystem("Gib", "vj_hlr/crack_fx/bodysplat.wav")
	self:PlaySoundSystem("Gib", "vj_base/gib/splat.wav")
	return true, {AllowSound = false}
end