include("entities/npc_vj_hlr1_zombie/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2010-2025 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_hlr/cracklife/chav.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.VJC_Data = {
    ThirdP_Offset = Vector(-5, 0, -15), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "Bip02 Head", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(5, 0, 5), -- The offset for the controller when the camera is in first person
}
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.CustomBlood_Particle = {"vj_hlr_blood_red"}
ENT.CustomBlood_Decal = {"VJ_HLR_Blood_Red"} -- Decals to spawn when it's damaged
ENT.VJ_NPC_Class = {"CLASS_CRACKLIFE_CHAV"} -- NPCs with the same class with be allied to each other
ENT.StartHealth = 60

//ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.DeathAnimationTime = 0.47 -- Time until the SNPC spawns its corpse and gets removed

ENT.SoundTbl_FootStep = {"vj_hlr/crack_fx/npc_step1.wav","vj_hlr/crack_fx/npc_step2.wav","vj_hlr/crack_fx/npc_step3.wav","vj_hlr/crack_fx/npc_step4.wav"}
ENT.SoundTbl_Idle = {"vj_hlr/crack_npc/zombie/zo_idle1.wav","vj_hlr/crack_npc/zombie/zo_idle2.wav","vj_hlr/crack_npc/zombie/zo_idle3.wav","vj_hlr/crack_npc/zombie/zo_idle4.wav"}
ENT.SoundTbl_Alert = {"vj_hlr/crack_npc/zombie/zo_alert10.wav","vj_hlr/crack_npc/zombie/zo_alert20.wav","vj_hlr/crack_npc/zombie/zo_alert30.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"vj_hlr/crack_npc/zombie/zo_attack1.wav","vj_hlr/crack_npc/zombie/zo_attack2.wav"}
ENT.SoundTbl_Pain = {"vj_hlr/crack_npc/zombie/zo_pain1.wav","vj_hlr/crack_npc/zombie/zo_pain2.wav"}
ENT.SoundTbl_Death = {"vj_hlr/crack_npc/zombie/zo_pain1.wav","vj_hlr/crack_npc/zombie/zo_pain2.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"vj_hlr/crack_fx/bat_hit.wav","vj_hlr/crack_fx/bat_hit.wav","vj_hlr/crack_fx/bat_hit.wav"}

ENT.SCI_NextMouthMove = 0
ENT.SCI_NextMouthDistance = 0
ENT.SpawnHat = true

ENT.ChavType = 0
--[[
	0 - Regular chav
	1 - Super chav
]]--
ENT.CanUseHD = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	local randvoice = math.random(1,10)
	if (GetConVar("vj_hlrcl_oldchavsounds"):GetInt() == 1 && self.ChavType == 0) or (randvoice == 1 && self.ChavType == 0) then
		self.SoundTbl_Idle = {"vj_hlr/crack_npc/zombie/old/zo_idle1.wav","vj_hlr/crack_npc/zombie/old/zo_idle2.wav","vj_hlr/crack_npc/zombie/old/zo_idle3.wav","vj_hlr/crack_npc/zombie/old/zo_idle4.wav"}
		self.SoundTbl_Alert = {"vj_hlr/crack_npc/zombie/old/zo_alert10.wav","vj_hlr/crack_npc/zombie/old/zo_alert20.wav","vj_hlr/crack_npc/zombie/old/zo_alert30.wav"}
		self.SoundTbl_BeforeMeleeAttack = {"vj_hlr/crack_npc/zombie/old/zo_attack1.wav","vj_hlr/crack_npc/zombie/old/zo_attack2.wav"}
		self.SoundTbl_Pain = {"vj_hlr/crack_npc/zombie/old/zo_pain1.wav","vj_hlr/crack_npc/zombie/old/zo_pain2.wav"}
		self.SoundTbl_Death = {"vj_hlr/crack_npc/zombie/old/zo_pain1.wav","vj_hlr/crack_npc/zombie/old/zo_pain2.wav"}
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	//print(key)
	if key == "event_emit step" then
		self:FootStepSoundCode()
	end
	if key == "event_mattack right" or key == "event_mattack left" or key == "event_mattack both" then
		self:MeleeAttackCode()
	end
	if key == "body" then
		VJ_EmitSound(self, "vj_hlr/crack_fx/bodydrop.wav", 85, 100)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	if CurTime() < self.SCI_NextMouthMove then
		if self.SCI_NextMouthDistance == 0 then
			self.SCI_NextMouthDistance = math.random(50,150)
		else
			self.SCI_NextMouthDistance = 0
		end
		self:SetPoseParameter("m",self.SCI_NextMouthDistance)
	else
		self:SetPoseParameter("m",0)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnCreateSound(sdData, sdFile)
	self.SCI_NextMouthMove = CurTime() + SoundDuration(sdFile)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomGibOnDeathSounds(dmginfo,hitgroup)
	VJ_EmitSound(self,"vj_hlr/crack_fx/bodysplat.wav", 90, math.random(100,100))
	VJ_EmitSound(self, "vj_base/gib/splat.wav", 90, math.random(100,100))
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_BeforeCorpseSpawned(dmginfo,hitgroup)
	if self.SpawnHat == true then
		self:SetBodygroup(0,1)
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/cracklife/chav_bat.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(8,-8,10)),CollideSound={""}})
		self.SpawnHat = false
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomDeathAnimationCode(dmginfo, hitgroup)
	if self.SpawnHat == true then
		self:SetBodygroup(0,1)
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/cracklife/chav_bat.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(8,-8,10)),CollideSound={""}})
		self.SpawnHat = false
	end
	if hitgroup == HITGROUP_HEAD then
		self.AnimTbl_Death = {ACT_DIE_GUTSHOT,ACT_DIE_HEADSHOT}
	else
		self.AnimTbl_Death = {ACT_DIEBACKWARD,ACT_DIEFORWARD,ACT_DIESIMPLE}
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:HandleGibOnDeath(dmginfo,hitgroup)
	self.HasDeathSounds = false
		if self.HasGibDeathParticles == true then
			local bloodeffect = EffectData()
			bloodeffect:SetOrigin(self:GetPos() +self:OBBCenter())
			bloodeffect:SetColor(VJ_Color2Byte(Color(130,19,10)))
			bloodeffect:SetScale(120)
			util.Effect("VJ_Blood1",bloodeffect)
			
			local bloodspray = EffectData()
			bloodspray:SetOrigin(self:GetPos())
			bloodspray:SetScale(8)
			bloodspray:SetFlags(3)
			bloodspray:SetColor(0)
			util.Effect("bloodspray",bloodspray)
			util.Effect("bloodspray",bloodspray)
		end
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh1.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh2.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh3.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh4.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_b_bone.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,50))})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_b_gib.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_guts.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_hmeat.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,45))})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_lung.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,45))})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_legbone.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,15))})
		self:PlaySoundSystem("Gib", "vj_hlr/crack_fx/bodysplat.wav")
		self:PlaySoundSystem("Gib", "vj_base/gib/splat.wav")
		return true, {AllowSound = false}
end
		
/*-----------------------------------------------
	*** Copyright (c) 2010-2025 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/