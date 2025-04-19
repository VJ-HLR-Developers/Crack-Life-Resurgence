include("entities/npc_vj_hlr1_hgrunt/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2010-2025 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_hlr/cracklife/hgrunt.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.VJ_NPC_Class = {"CLASS_CRACKLIFE_SOVIET"}

ENT.GrenadeAttackEntity = "obj_vj_hlrcl_pepsinade" -- The entity that the SNPC throws | Half Life 2 Grenade: "npc_grenade_frag"
ENT.CanUseHD = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:HECU_CustomOnInitialize()
	self:SetBodygroup(1, math.random(0, 1))
	self.SoundTbl_FootStep = {"vj_hlr/crack_fx/npc_step1.wav","vj_hlr/crack_fx/npc_step2.wav","vj_hlr/crack_fx/npc_step3.wav","vj_hlr/crack_fx/npc_step4.wav"}
	self.SoundTbl_Death = {"vj_hlr/crack_npc/hgrunt/gr_die1.wav","vj_hlr/crack_npc/hgrunt/gr_die2.wav","vj_hlr/crack_npc/hgrunt/gr_die3.wav"}
	self.SoundTbl_Pain = {"vj_hlr/crack_npc/hgrunt/gr_pain1.wav","vj_hlr/crack_npc/hgrunt/gr_pain2.wav","vj_hlr/crack_npc/hgrunt/gr_pain4.wav","vj_hlr/crack_npc/hgrunt/gr_pain5.wav"}
	self.SoundTbl_Idle = {"vj_hlr/hl1_npc/hgrunt/gr_alert1.wav","vj_hlr/hl1_npc/hgrunt/gr_idle1.wav","vj_hlr/hl1_npc/hgrunt/gr_idle2.wav","vj_hlr/hl1_npc/hgrunt/gr_idle3.wav"}
	self.SoundTbl_CombatIdle = {"vj_hlr/crack_npc/hgrunt/taunt1.wav","vj_hlr/crack_npc/hgrunt/taunt2.wav","vj_hlr/crack_npc/hgrunt/taunt4.wav","vj_hlr/crack_npc/hgrunt/taunt5.wav","vj_hlr/crack_npc/hgrunt/taunt6.wav"}
	self.SoundTbl_Suppressing = {"vj_hlr/crack_npc/hgrunt/charge1.wav","vj_hlr/crack_npc/hgrunt/charge2.wav","vj_hlr/crack_npc/hgrunt/charge3.wav","vj_hlr/crack_npc/hgrunt/charge4.wav"}
	self.SoundTbl_OnReceiveOrder = {"vj_hlr/crack_npc/hgrunt/charge1.wav","vj_hlr/crack_npc/hgrunt/charge2.wav"}
	self.SoundTbl_Investigate = {"vj_hlr/crack_npc/hgrunt/taunt1.wav"}
	self.SoundTbl_Alert = {"vj_hlr/crack_npc/hgrunt/alien2.wav","vj_hlr/crack_npc/hgrunt/alien3.wav"}
	self.SoundTbl_WeaponReload = {"vj_hlr/crack_npc/hgrunt/gr_reload1.wav"}
	self.SoundTbl_GrenadeAttack = {"vj_hlr/crack_npc/hgrunt/taunt3.wav","vj_hlr/crack_npc/hgrunt/throw1.wav","vj_hlr/crack_npc/hgrunt/throw2.wav","vj_hlr/crack_npc/hgrunt/throw3.wav"}
	self.SoundTbl_OnGrenadeSight = {"vj_hlr/crack_npc/hgrunt/cover1.wav","vj_hlr/crack_npc/hgrunt/cover2.wav","vj_hlr/crack_npc/hgrunt/cover3.wav","vj_hlr/crack_npc/hgrunt/grenade1.wav","vj_hlr/crack_npc/hgrunt/grenade2.wav","vj_hlr/crack_npc/hgrunt/grenade3.wav"}
	self.SoundTbl_AllyDeath = {"vj_hlr/crack_npc/hgrunt/cover3.wav","vj_hlr/crack_npc/hgrunt/cover2.wav"}
	if GetConVar("vj_hlrcl_disableracism"):GetInt() == 1 then
		self.SoundTbl_CombatIdle = {"vj_hlr/crack_npc/hgrunt/taunt1.wav","vj_hlr/crack_npc/hgrunt/taunt2.wav","vj_hlr/crack_npc/hgrunt/taunt4.wav","vj_hlr/crack_npc/hgrunt/taunt5.wav","vj_hlr/crack_npc/hgrunt/taunt6_c.wav"}
		self.SoundTbl_OnGrenadeSight = {"vj_hlr/crack_npc/hgrunt/cover1.wav","vj_hlr/crack_npc/hgrunt/cover2.wav","vj_hlr/crack_npc/hgrunt/cover3_c.wav","vj_hlr/crack_npc/hgrunt/grenade1.wav","vj_hlr/crack_npc/hgrunt/grenade2.wav","vj_hlr/crack_npc/hgrunt/grenade3.wav"}	
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert(ent)
	if math.random(1,2) == 1 then
		if ent:GetClass() == "npc_vj_hlrcl_german" then
			if GetConVar("vj_hlrcl_disableracism"):GetInt() == 1 then
				self:PlaySoundSystem("Alert", {"vj_hlr/crack_npc/hgrunt/alien1_c.wav"})
			else
				self:PlaySoundSystem("Alert", {"vj_hlr/crack_npc/hgrunt/alien1.wav"})
			end
			return
		elseif ent:IsPlayer() then
			if GetConVar("vj_hlrcl_disableracism"):GetInt() == 1 then
				self:PlaySoundSystem("Alert", {"vj_hlr/crack_npc/hgrunt/freeman1.wav","vj_hlr/crack_npc/hgrunt/freeman2_c.wav","vj_hlr/crack_npc/hgrunt/freeman3.wav"})
			else
				self:PlaySoundSystem("Alert", {"vj_hlr/crack_npc/hgrunt/freeman1.wav","vj_hlr/crack_npc/hgrunt/freeman2.wav","vj_hlr/crack_npc/hgrunt/freeman3.wav"})
			end
			return
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	//print(key)
	if key == "event_emit step" or key == "step" then
		self:FootStepSoundCode()
	elseif key == "event_mattack" or key == "melee" or key == "machete_melee" then
		self:MeleeAttackCode()
	elseif key == "event_rattack mp5_fire" or key == "event_rattack shotgun_fire" or key == "event_rattack saw_fire" or key == "event_rattack pistol_fire" or key == "shoot" or key == "colt_fire" or key == "fire" then
		local wep = self:GetActiveWeapon()
		if IsValid(wep) then
			wep:NPCShoot_Primary()
		end
	elseif key == "body" then
		VJ_EmitSound(self, "vj_hlr/crack_fx/bodydrop.wav", 75, 100)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomGibOnDeathSounds(dmginfo,hitgroup)
	VJ_EmitSound(self,"vj_hlr/crack_fx/bodysplat.wav", 90, math.random(100,100))
	VJ_EmitSound(self, "vj_base/gib/splat.wav", 90, math.random(100,100))
	return false
end