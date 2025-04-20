include("entities/npc_vj_hlr1_houndeye/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2010-2025 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_hlr/cracklife/houndeye.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.VJ_NPC_Class = {"CLASS_CRACKLIFE"}
ENT.Houndeye_Type = 1
ENT.CanUseHD = false

local blastSd = {"vj_hlr/crack_npc/houndeye/he_blast1.wav","vj_hlr/crack_npc/houndeye/he_blast2.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(20, 20 , 40), Vector(-20, -20, 0))
	self.SoundTbl_FootStep = {"vj_hlr/crack_npc/houndeye/he_hunt1.wav"}
	self.SoundTbl_Alert = {"vj_hlr/crack_npc/houndeye/he_alert1.wav"}
	self.SoundTbl_BeforeMeleeAttack = {"vj_hlr/crack_npc/houndeye/he_attack1.wav"}
	self.SoundTbl_Pain = {"vj_hlr/crack_npc/houndeye/he_pain1.wav","vj_hlr/crack_npc/houndeye/he_pain3.wav"}
	self.SoundTbl_Death = {"vj_hlr/crack_npc/houndeye/he_die1.wav"}

	self:SetCollisionBounds(Vector(20, 20 , 40), Vector(-20, -20, 0))
	
	self.Houndeye_NextSleepT = CurTime() + math.Rand(0, 15)

	self.AnimTbl_Death = {ACT_DIESIMPLE, ACT_DIEFORWARD, ACT_DIEBACKWARD}
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	//print(key)
	if key == "he_hunt" then
		self:FootStepSoundCode()
	elseif key == "placeholder_eye_event_dont_use" then
		VJ_EmitSound(self,{"vj_hlr/gsrc/npc/houndeye/he_pain1.wav","vj_hlr/gsrc/npc/houndeye/he_pain3.wav"})
	elseif key == "body" then
		VJ_EmitSound(self, "vj_hlr/crack_fx/bodydrop.wav", 75, 100)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local houndeyeClasses = {npc_vj_hlrcl_houndeye = true}
local beamEffectTbl = {material = "vj_hl/sprites/shockwave", framerate = 20, flags = 0}
--
function ENT:OnMeleeAttackExecute(status, ent, isProp)
	if status == "Init" then
		local friNum = 0 -- How many allies exist around the Houndeye
		local color = Color(188, 220, 255) -- The shock wave color
		local dmg = 15 -- How much damage should the shock wave do?
		local myPos = self:GetPos()
		for _, v in ipairs(ents.FindInSphere(myPos, 400)) do
			if v != self && houndeyeClasses[v:GetClass()] then
				friNum = friNum + 1
			end
		end
		-- More allies = more damage and different colors
		if friNum == 1 then
			color = Color(101, 133, 221)
			dmg = 30
		elseif friNum == 2 then
			color = Color(67, 85, 255)
			dmg = 45
		elseif friNum >= 3 then
			color = Color(62, 33, 211)
			dmg = 60
		end
		
		-- flags 0 = No fade!
		effects.BeamRingPoint(myPos, 0.3, 2, 400, 16, 0, color, beamEffectTbl)
		effects.BeamRingPoint(myPos, 0.3, 2, 200, 16, 0, color, beamEffectTbl)
		
		if self.HasSounds && self.HasMeleeAttackSounds then
			VJ.EmitSound(self, blastSd, 100, math.random(80, 100))
		end
		VJ.ApplyRadiusDamage(self, self, myPos, 400, dmg, self.MeleeAttackDamageType, true, true, {DisableVisibilityCheck=true, Force=80})
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
		effectData:SetScale(100)
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
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/agib7.mdl", {BloodType="Yellow", CollisionDecal="VJ_HLR1_Blood_Yellow", Pos=self:LocalToWorld(Vector(0, 0, 40))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/agib8.mdl", {BloodType="Yellow", CollisionDecal="VJ_HLR1_Blood_Yellow", Pos=self:LocalToWorld(Vector(0, 0, 45))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/agib9.mdl", {BloodType="Yellow", CollisionDecal="VJ_HLR1_Blood_Yellow", Pos=self:LocalToWorld(Vector(0, 0, 25))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/agib10.mdl", {BloodType="Yellow", CollisionDecal="VJ_HLR1_Blood_Yellow", Pos=self:LocalToWorld(Vector(0, 0, 15))})
	self:PlaySoundSystem("Gib", "vj_base/gib/splat.wav")
	self:PlaySoundSystem("Gib", "vj_hlr/crack_fx/bodysplat.wav")
	return true, {AllowSound = false}
end
/*-----------------------------------------------
	*** Copyright (c) 2010-2025 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/