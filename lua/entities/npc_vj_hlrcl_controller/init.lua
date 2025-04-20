include("entities/npc_vj_hlr1_aliencontroller/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2010-2025 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_hlr/cracklife/controller.mdl" -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.VJ_NPC_Class = {"CLASS_CRACKLIFE"}
---------------------------------------------------------------------------------------------------------------------------------------------
local baseInit = ENT.CustomOnInitialize
--
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(35, 35, 100), Vector(-35, -35, -10))
	self.SoundTbl_Idle = {"vj_hlr/crack_npc/controller/con_idle1.wav","vj_hlr/crack_npc/controller/con_idle2.wav","vj_hlr/crack_npc/controller/con_idle3.wav","vj_hlr/crack_npc/controller/con_idle4.wav","vj_hlr/crack_npc/controller/con_idle5.wav"}
	self.SoundTbl_Alert = {"vj_hlr/crack_npc/controller/con_alert1.wav","vj_hlr/crack_npc/controller/con_alert2.wav"}
	self.SoundTbl_RangeAttack = {"vj_hlr/crack_npc/controller/con_attack1.wav","vj_hlr/crack_npc/controller/con_attack2.wav","vj_hlr/crack_npc/controller/con_attack3.wav"}
	self.SoundTbl_Pain = {"vj_hlr/crack_npc/controller/con_pain1.wav","vj_hlr/crack_npc/controller/con_pain2.wav","vj_hlr/crack_npc/controller/con_pain3.wav"}
	self.SoundTbl_Death = {"vj_hlr/crack_npc/controller/con_die1.wav","vj_hlr/crack_npc/controller/con_die2.wav"}
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
	
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/agib1.mdl", {BloodType="Yellow", CollisionDecal="VJ_HLR1_Blood_Yellow", Pos=self:LocalToWorld(Vector(0, 0, 20))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/agib2.mdl", {BloodType="Yellow", CollisionDecal="VJ_HLR1_Blood_Yellow", Pos=self:LocalToWorld(Vector(1, 0, 20))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/agib3.mdl", {BloodType="Yellow", CollisionDecal="VJ_HLR1_Blood_Yellow", Pos=self:LocalToWorld(Vector(0, 1, 20))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/agib4.mdl", {BloodType="Yellow", CollisionDecal="VJ_HLR1_Blood_Yellow", Pos=self:LocalToWorld(Vector(2, 0, 20))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/agib5.mdl", {BloodType="Yellow", CollisionDecal="VJ_HLR1_Blood_Yellow", Pos=self:LocalToWorld(Vector(0, 2, 20))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/agib6.mdl", {BloodType="Yellow", CollisionDecal="VJ_HLR1_Blood_Yellow", Pos=self:LocalToWorld(Vector(3, 0, 20))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/agib7.mdl", {BloodType="Yellow", CollisionDecal="VJ_HLR1_Blood_Yellow", Pos=self:LocalToWorld(Vector(0, 3, 20))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/agib8.mdl", {BloodType="Yellow", CollisionDecal="VJ_HLR1_Blood_Yellow", Pos=self:LocalToWorld(Vector(1, 1, 20))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/agib9.mdl", {BloodType="Yellow", CollisionDecal="VJ_HLR1_Blood_Yellow", Pos=self:LocalToWorld(Vector(1, 2, 20))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/agib10.mdl", {BloodType="Yellow", CollisionDecal="VJ_HLR1_Blood_Yellow", Pos=self:LocalToWorld(Vector(2, 0, 20))})
	self:PlaySoundSystem("Gib", "vj_base/gib/splat.wav")
	self:PlaySoundSystem("Gib", "vj_hlr/crack_fx/bodysplat.wav")
	return true, {AllowSound = false}
end