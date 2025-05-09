include("entities/npc_vj_hlr1_zombie/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2010-2025 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_hlr/cracklife/skellington.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.VJ_NPC_Class = {"CLASS_CRACKLIFE"} -- NPCs with the same class with be allied to each other
ENT.Bleeds = false
ENT.BloodColor = ""
ENT.HasBloodParticle = false
ENT.HasCollisionDecal = false

ENT.HasIdleSounds = false
ENT.HasAlertSounds = false

ENT.SoundTbl_FootStep = {"vj_hlr/crack_fx/npc_step1.wav","vj_hlr/crack_fx/npc_step2.wav","vj_hlr/crack_fx/npc_step3.wav","vj_hlr/crack_fx/npc_step4.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"vj_hlr/null.wav","vj_hlr/null.wav"}
ENT.SoundTbl_Pain = {"vj_hlr/crack_npc/spooky/s_pain1.wav","vj_hlr/crack_npc/spooky/s_pain2.wav","vj_hlr/crack_npc/spooky/s_pain3.wav"}
ENT.SoundTbl_Death = {"vj_hlr/crack_npc/spooky/s_die.wav","vj_hlr/crack_npc/spooky/s_die2.wav","vj_hlr/crack_npc/spooky/s_die3.wav"}
ENT.CanUseHD = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	//print(key)
	if key == "event_emit step" then
		self:FootStepSoundCode()
	end
	if key == "event_mattack right" or key == "event_mattack left" or key == "event_mattack both" then
		self:MeleeAttackCode()
	end
	if key == "ragdoll" then
		VJ_EmitSound(self, "vj_hlr/crack_fx/bodydrop.wav", 85, 100)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomGibOnDeathSounds(dmginfo,hitgroup)
	VJ_EmitSound(self,"vj_hlr/crack_fx/bodysplat.wav", 90, math.random(100,100))
	VJ_EmitSound(self, "vj_base/gib/splat.wav", 90, math.random(100,100))
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:HandleGibOnDeath(dmginfo,hitgroup)
	self.HasDeathSounds = false
	
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/abone_template1.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/abone_template1.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,20))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/abone_template1.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,30))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/abone_template1.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,15))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/abone_template1.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,35))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/bleachbones_pelvis_template1.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,35))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/bleachbones_jawbone1.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,50))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/bleachbones_bskull_template1.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,55))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/bleachbones_ribcage1.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/bleachbones_riblet1.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,45))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/bleachbones_riblet1.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,25))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/bleachbones_riblet1.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,35))})
	self:PlaySoundSystem("Gib", "vj_base/gib/splat.wav")
	self:PlaySoundSystem("Gib", "vj_hlr/crack_fx/bodysplat.wav")
	return true, {AllowSound = false}
end
---------------------------------------------------------------------------------------------------------------------------------------------
local gibs = {"models/vj_hlr/gibs/abone_template1.mdl","models/vj_hlr/gibs/abone_template1.mdl","models/vj_hlr/gibs/abone_template1.mdl","models/vj_hlr/gibs/abone_template1.mdl","models/vj_hlr/gibs/abone_template1.mdl","models/vj_hlr/gibs/bleachbones_pelvis_template1.mdl","models/vj_hlr/gibs/bleachbones_jawbone1.mdl","models/vj_hlr/gibs/bleachbones_bskull_template1.mdl","models/vj_hlr/gibs/bleachbones_ribcage1.mdl","models/vj_hlr/gibs/bleachbones_riblet1.mdl","models/vj_hlr/gibs/bleachbones_riblet1.mdl","models/vj_hlr/gibs/bleachbones_riblet1.mdl"}
--
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, corpseEnt)
	VJ.HLR_ApplyCorpseSystem(self, corpseEnt, gibs)
end
/*-----------------------------------------------
	*** Copyright (c) 2010-2025 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/