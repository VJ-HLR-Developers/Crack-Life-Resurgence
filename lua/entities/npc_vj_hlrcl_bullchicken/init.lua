AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contselfs may be reproduced, copied, modified or adapted,
	without the prior written consself of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_hlr/cracklife/bullsquid.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.VJ_NPC_Class = {"CLASS_CRACKLIFE"}
ENT.CanUseHD = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.SoundTbl_FootStep = {"vj_hlr/pl_step1.wav","vj_hlr/pl_step2.wav","vj_hlr/pl_step3.wav","vj_hlr/pl_step4.wav"}
	self.SoundTbl_Idle = {"vj_hlr/crack_npc/bullchicken/bc_idle1.wav","vj_hlr/crack_npc/bullchicken/bc_idle2.wav","vj_hlr/crack_npc/bullchicken/bc_idle3.wav","vj_hlr/crack_npc/bullchicken/bc_idle4.wav","vj_hlr/crack_npc/bullchicken/bc_idle5.wav"}
	self.SoundTbl_Alert = {"vj_hlr/crack_npc/bullchicken/bc_idle1.wav","vj_hlr/crack_npc/bullchicken/bc_idle2.wav","vj_hlr/crack_npc/bullchicken/bc_idle3.wav","vj_hlr/crack_npc/bullchicken/bc_idle4.wav","vj_hlr/crack_npc/bullchicken/bc_idle5.wav"}
	self.SoundTbl_BeforeMeleeAttack = {"vj_hlr/crack_npc/bullchicken/bc_idle4.wav"}
	self.SoundTbl_MeleeAttack = {"vj_hlr/hl1_npc/bullchicken/bc_bite1.wav","vj_hlr/hl1_npc/bullchicken/bc_bite2.wav","vj_hlr/hl1_npc/bullchicken/bc_bite3.wav"}
	self.SoundTbl_MeleeAttackMiss = {"vj_hlr/hl1_npc/zombie/claw_miss1.wav","vj_hlr/hl1_npc/zombie/claw_miss2.wav"}
	self.SoundTbl_RangeAttack = {"vj_hlr/hl1_npc/bullchicken/bc_attack2.wav","vj_hlr/hl1_npc/bullchicken/bc_attack3.wav"}
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
function ENT:CustomGibOnDeathSounds(dmginfo, hitgroup)
	VJ_EmitSound(self,"vj_hlr/crack_fx/bodysplat.wav", 90, math.random(100,100))
	VJ_EmitSound(self, "vj_gib/default_gib_splat.wav", 90, 100)
	return false
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contselfs may be reproduced, copied, modified or adapted,
	without the prior written consself of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/