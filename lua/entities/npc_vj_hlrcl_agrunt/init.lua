include("entities/npc_vj_hlr1_aliengrunt/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2010-2024 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_hlr/cracklife/agrunt.mdl" -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.VJ_NPC_Class = {"CLASS_CRACKLIFE"}
ENT.EntitiesToNoCollide = {"npc_vj_hlrcl_joj"}
ENT.CanUseHD = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(25,25,95), Vector(-25,-25,0))
	self.SoundTbl_FootStep = {"vj_hlr/hl1_npc/player/pl_ladder1.wav","vj_hlr/hl1_npc/player/pl_ladder2.wav","vj_hlr/hl1_npc/player/pl_ladder3.wav","vj_hlr/hl1_npc/player/pl_ladder4.wav"}
	self.SoundTbl_Idle = {"vj_hlr/crack_npc/agrunt/ag_idle1.wav","vj_hlr/crack_npc/agrunt/ag_idle2.wav","vj_hlr/crack_npc/agrunt/ag_idle3.wav","vj_hlr/crack_npc/agrunt/ag_idle4.wav","vj_hlr/crack_npc/agrunt/ag_idle5.wav"}
	self.SoundTbl_Alert = {"vj_hlr/crack_npc/agrunt/ag_alert1.wav","vj_hlr/crack_npc/agrunt/ag_alert2.wav","vj_hlr/crack_npc/agrunt/ag_alert3.wav","vj_hlr/crack_npc/agrunt/ag_alert4.wav","vj_hlr/crack_npc/agrunt/ag_alert5.wav"}
	self.SoundTbl_MeleeAttackExtra = {"vj_hlr/hl1_npc/zombie/claw_strike1.wav","vj_hlr/hl1_npc/zombie/claw_strike2.wav","vj_hlr/hl1_npc/zombie/claw_strike3.wav"}
	self.SoundTbl_MeleeAttackMiss = {"vj_hlr/hl1_npc/zombie/claw_miss1.wav","vj_hlr/hl1_npc/zombie/claw_miss2.wav"}
	self.SoundTbl_BeforeMeleeAttack = {"vj_hlr/crack_npc/agrunt/ag_attack1.wav","vj_hlr/crack_npc/agrunt/ag_attack2.wav","vj_hlr/crack_npc/agrunt/ag_attack3.wav"}
	self.SoundTbl_BeforeRangeAttack = {"vj_hlr/crack_npc/agrunt/ag_attack1.wav"}
	self.SoundTbl_Pain = {"vj_hlr/crack_npc/agrunt/ag_pain1.wav","vj_hlr/crack_npc/agrunt/ag_pain2.wav","vj_hlr/crack_npc/agrunt/ag_pain3.wav","vj_hlr/crack_npc/agrunt/ag_pain4.wav","vj_hlr/crack_npc/agrunt/ag_pain5.wav"}
	self.SoundTbl_Death = {"vj_hlr/crack_npc/agrunt/ag_die1.wav","vj_hlr/crack_npc/agrunt/ag_die2.wav","vj_hlr/crack_npc/agrunt/ag_die3.wav","vj_hlr/crack_npc/agrunt/ag_die4.wav","vj_hlr/crack_npc/agrunt/ag_die5.wav"}

	self.AnimTbl_Death = {ACT_DIEBACKWARD, ACT_DIEFORWARD, ACT_DIESIMPLE}
	self.HitGroupFlinching_Values = {{HitGroup = {HITGROUP_LEFTARM}, Animation = {ACT_FLINCH_LEFTARM}},{HitGroup = {HITGROUP_RIGHTARM}, Animation = {ACT_FLINCH_RIGHTARM}},{HitGroup = {HITGROUP_LEFTLEG}, Animation = {ACT_FLINCH_LEFTLEG}},{HitGroup = {HITGROUP_RIGHTLEG}, Animation = {ACT_FLINCH_RIGHTLEG}}}
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	//print(key)
	if key == "event_emit Step" then
		self:FootStepSoundCode()
	elseif key == "event_mattack" then
		self:MeleeAttackCode()
	elseif key == "event_rattack" then
		self:RangeAttackCode()
		VJ_EmitSound(self, "vj_hlr/crack_npc/agrunt/ag_fire1.wav", 75, 100)
	elseif key == "body" then
		VJ_EmitSound(self, "vj_hlr/crack_fx/bodydrop.wav", 75, 100)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo, hitgroup)
	self.HasDeathSounds = false
	if self.HasGibDeathParticles == true then
		local effectBlood = EffectData()
		effectBlood:SetOrigin(self:GetPos() + self:OBBCenter())
		effectBlood:SetColor(VJ_Color2Byte(Color(255,221,35)))
		effectBlood:SetScale(120)
		util.Effect("VJ_Blood1",effectBlood)
		
		local bloodspray = EffectData()
		bloodspray:SetOrigin(self:GetPos() + self:OBBCenter())
		bloodspray:SetScale(8)
		bloodspray:SetFlags(3)
		bloodspray:SetColor(1)
		util.Effect("bloodspray",bloodspray)
		util.Effect("bloodspray",bloodspray)
		
		local effectdata = EffectData()
		effectdata:SetOrigin(self:GetPos() + self:OBBCenter())
		effectdata:SetScale(1)
		util.Effect("StriderBlood",effectdata)
		util.Effect("StriderBlood",effectdata)
	end
	
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib1.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib2.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,20))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib3.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,30))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib4.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,35))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib5.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,50))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib6.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,55))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib7.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib8.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,45))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib9.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,25))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib10.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,15))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib2.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,65))})
	return true -- Return to true if it gibbed!
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomGibOnDeathSounds(dmginfo, hitgroup)
	VJ_EmitSound(self, "vj_hlr/crack_fx/bodysplat.wav", 90, 100)
	VJ_EmitSound(self, "vj_base/gib/splat.wav", 90, 100)
	return false
end