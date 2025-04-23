AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2010-2025 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_hlr/cracklife/vlad.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 0
ENT.VJ_NPC_Class = {"CLASS_CRACKLIFE_SOVIET"} -- NPCs with the same class with be allied to each other
ENT.HasDeathRagdoll = false -- If set to false, it will not spawn the regular ragdoll of the SNPC

ENT.Tank_Shell_TimeUntilFire = 0.7
ENT.Tank_TurningSpeed = 10 -- How fast the gun moves as it's aiming towards an enemy

-- Tank Base
ENT.Tank_SoundTbl_Turning = {"vj_hlr/gsrc/npc/tanks/abrams_turret_rot.wav"}
ENT.Tank_SoundTbl_ReloadShell = {"vj_hlr/gsrc/npc/tanks/tank_reload.wav"}
ENT.Tank_SoundTbl_FireShell = {"vj_hlr/gsrc/npc/tanks/shoot.wav"}

ENT.Tank_AngleDiffuseNumber = 0
ENT.Tank_Shell_SpawnPos = Vector(220, 0, 210)
ENT.Tank_Shell_Entity = "obj_vj_hlr1_rocket" -- The entity that is spawned when the shell is fired
ENT.Tank_Shell_VelocitySpeed = 3000 -- How fast should the tank shell travel?
ENT.Tank_Shell_DynamicLightPos = Vector(220, 0, 210)
ENT.Tank_Shell_MuzzleFlashPos = Vector(220, 0, 210)
ENT.Tank_Shell_ParticlePos = Vector(220, 0, 210)

-- Custom --
ENT.RapidFire = 0
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Tank_Init()
	timer.Create("vlad_rapidassfuck"..self:EntIndex(), 2, 0, function() self.RapidFire = math.random(0,1) end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Tank_OnThinkActive()
	if self.RapidFire == 1 then
		self.Tank_Shell_TimeUntilFire = 0.2
	else
		self.Tank_Shell_TimeUntilFire = 0.7
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	VJ_STOPSOUND(self.CurrentTankMovingSound)
	timer.Remove("timer_shell_attack"..self:EntIndex())
	timer.Remove("vlad_rapidassfuck"..self:EntIndex())
end