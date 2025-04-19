include("entities/npc_vj_hlr1_headcrab/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2010-2025 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_hlr/cracklife/headcrab.mdl" -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.VJ_NPC_Class = {"CLASS_CRACKLIFE"} -- NPCs with the same class with be allied to each other

ENT.SoundTbl_Idle = {"vj_hlr/hl1_npc/headcrab/hc_idle1.wav","vj_hlr/hl1_npc/headcrab/hc_idle2.wav","vj_hlr/crack_npc/headcrab/hc_idle3.wav","vj_hlr/hl1_npc/headcrab/hc_idle4.wav","vj_hlr/hl1_npc/headcrab/hc_idle5.wav"}
ENT.SoundTbl_Alert = {"vj_hlr/crack_npc/headcrab/hc_alert1.wav","vj_hlr/crack_npc/headcrab/hc_attack2.wav"}
ENT.SoundTbl_LeapAttackJump = {"vj_hlr/crack_npc/headcrab/hc_attack2.wav","vj_hlr/crack_npc/headcrab/hc_attack3.wav","vj_hlr/crack_npc/headcrab/hc_attack3.wav"}
ENT.SoundTbl_LeapAttackDamage = {"vj_hlr/crack_npc/headcrab/hc_headbite.wav"}
ENT.SoundTbl_Pain = {"vj_hlr/crack_npc/headcrab/hc_pain1.wav","vj_hlr/crack_npc/headcrab/hc_pain2.wav","vj_hlr/crack_npc/headcrab/hc_pain3.wav"}
ENT.SoundTbl_Death = {"vj_hlr/crack_npc/headcrab/hc_die1.wav","vj_hlr/crack_npc/headcrab/hc_die2.wav"}

ENT.SpawnHat = true
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomGibOnDeathSounds(dmginfo, hitgroup)
	VJ_EmitSound(self,"vj_hlr/crack_fx/bodysplat.wav", 90, 100)
	VJ_EmitSound(self, "vj_base/gib/splat.wav", 90, 100)
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_BeforeCorpseSpawned(dmginfo, hitgroup)
	if self.SpawnHat == true then
		self:SetBodygroup(0,1)
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/cracklife/headcrab_hat.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,5)),CollideSound={""}})
		self.SpawnHat = false
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomDeathAnimationCode(dmginfo, hitgroup)
	if self.SpawnHat == true then
		self:SetBodygroup(0,1)
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/cracklife/headcrab_hat.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,5)),CollideSound={""}})
		self.SpawnHat = false
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:HandleGibOnDeath(dmginfo, hitgroup)
	self.HasDeathSounds = false
	if self.HasGibDeathParticles == true then
		local bloodeffect = EffectData()
		bloodeffect:SetOrigin(self:GetPos() +self:OBBCenter())
		bloodeffect:SetColor(VJ_Color2Byte(Color(255,221,35)))
		bloodeffect:SetScale(120)
		util.Effect("VJ_Blood1",bloodeffect)
		
		local bloodspray = EffectData()
		bloodspray:SetOrigin(self:GetPos() +self:OBBCenter())
		bloodspray:SetScale(8)
		bloodspray:SetFlags(3)
		bloodspray:SetColor(1)
		util.Effect("bloodspray",bloodspray)
		util.Effect("bloodspray",bloodspray)
		
		local effectdata = EffectData()
		effectdata:SetOrigin(self:GetPos() +self:OBBCenter())
		effectdata:SetScale(1)
		util.Effect("StriderBlood",effectdata)
		util.Effect("StriderBlood",effectdata)
	end
	
	if self:GetModel() != "models/vj_hlr/hl1/headcrab_baby.mdl" then
		self:CreateGibEntity("obj_vj_gib",{"models/vj_hlr/gibs/agib1.mdl","models/vj_hlr/gibs/agib3.mdl"},{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,5))})
	end
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib5.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,5))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib7.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,5))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib9.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,5))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib10.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,5))})
	if self.SpawnHat == true then
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/cracklife/headcrab_hat.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,0)),CollideSound={""}})
		self.SpawnHat = false
	end
	return true -- Return to true if it gibbed!
end