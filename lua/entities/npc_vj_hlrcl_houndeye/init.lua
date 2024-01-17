AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2010-2024 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_hlr/cracklife/houndeye.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.VJ_NPC_Class = {"CLASS_CRACKLIFE"}
ENT.Houndeye_Type = 1
ENT.CanUseHD = false
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
		VJ_EmitSound(self,{"vj_hlr/hl1_npc/houndeye/he_pain1.wav","vj_hlr/hl1_npc/houndeye/he_pain3.wav"})
	elseif key == "body" then
		VJ_EmitSound(self, "vj_hlr/crack_fx/bodydrop.wav", 75, 100)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_BeforeChecks()
	local friNum = 0 -- How many allies exist around the Houndeye
	local color = Color(188, 220, 255) -- The shock wave color
	local dmg = 15 -- How much damage should the shock wave do?
	for _, v in ipairs(ents.FindInSphere(self:GetPos(), 400)) do
		if v != self && v:GetClass() == "npc_vj_hlrcl_houndeye" then
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
	effects.BeamRingPoint(self:GetPos(), 0.3, 2, 400, 16, 0, color, {material="vj_hl/sprites/shockwave", framerate=20, flags=0})
	effects.BeamRingPoint(self:GetPos(), 0.3, 2, 200, 16, 0, color, {material="vj_hl/sprites/shockwave", framerate=20, flags=0})
	
	if self.HasSounds == true && GetConVar("vj_npc_sd_meleeattack"):GetInt() == 0 then
		VJ_EmitSound(self, {"vj_hlr/crack_npc/houndeye/he_blast1.wav","vj_hlr/crack_npc/houndeye/he_blast2.wav"}, 90, math.random(80,100))
	end
	util.VJ_SphereDamage(self, self, self:GetPos(), 400, dmg, self.MeleeAttackDamageType, true, true, {DisableVisibilityCheck=true, Force=80})
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomGibOnDeathSounds(dmginfo, hitgroup)
	VJ_EmitSound(self,"vj_hlr/crack_fx/bodysplat.wav", 90, math.random(100,100))
	VJ_EmitSound(self, "vj_gib/default_gib_splat.wav", 90, 100)
	return false
end
/*-----------------------------------------------
	*** Copyright (c) 2010-2024 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/