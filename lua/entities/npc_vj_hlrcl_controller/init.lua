include("entities/npc_vj_hlr1_aliencontroller/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2010-2024 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_hlr/cracklife/controller.mdl" -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.VJ_NPC_Class = {"CLASS_CRACKLIFE"}
---------------------------------------------------------------------------------------------------------------------------------------------
local baseInit = ENT.CustomOnInitialize
--
function ENT:CustomOnInitialize()
	baseInit(self)
	self:SetCollisionBounds(Vector(35, 35, 100), Vector(-35, -35, -10))
	self.SoundTbl_Idle = {"vj_hlr/crack_npc/controller/con_idle1.wav","vj_hlr/crack_npc/controller/con_idle2.wav","vj_hlr/crack_npc/controller/con_idle3.wav","vj_hlr/crack_npc/controller/con_idle4.wav","vj_hlr/crack_npc/controller/con_idle5.wav"}
	self.SoundTbl_Alert = {"vj_hlr/crack_npc/controller/con_alert1.wav","vj_hlr/crack_npc/controller/con_alert2.wav"}
	self.SoundTbl_RangeAttack = {"vj_hlr/crack_npc/controller/con_attack1.wav","vj_hlr/crack_npc/controller/con_attack2.wav","vj_hlr/crack_npc/controller/con_attack3.wav"}
	self.SoundTbl_Pain = {"vj_hlr/crack_npc/controller/con_pain1.wav","vj_hlr/crack_npc/controller/con_pain2.wav","vj_hlr/crack_npc/controller/con_pain3.wav"}
	self.SoundTbl_Death = {"vj_hlr/crack_npc/controller/con_die1.wav","vj_hlr/crack_npc/controller/con_die2.wav"}
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomGibOnDeathSounds(dmginfo,hitgroup)
	VJ_EmitSound(self, "vj_hlr/crack_fx/bodysplat.wav", 90, 100)
	VJ_EmitSound(self, "vj_gib/default_gib_splat.wav", 90, 100)
	return false
end