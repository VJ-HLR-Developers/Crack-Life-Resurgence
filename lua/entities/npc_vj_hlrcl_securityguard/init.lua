include("entities/npc_vj_hlr1_securityguard/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2010-2025 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_hlr/cracklife/barney.mdl" -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.CanUseHD = false
---------------------------------------------------------------------------------------------------------------------------------------------
local baseInit = ENT.CustomOnInitialize
--
function ENT:CustomOnInitialize()
	//baseInit(self)
	self.SoundTbl_FootStep = {"vj_hlr/crack_fx/npc_step1.wav","vj_hlr/crack_fx/npc_step2.wav","vj_hlr/crack_fx/npc_step3.wav","vj_hlr/crack_fx/npc_step4.wav"}
	self.SoundTbl_Idle = {"vj_hlr/gsrc/npc/barney/whatisthat.wav","vj_hlr/gsrc/npc/barney/somethingstinky.wav","vj_hlr/gsrc/npc/barney/somethingdied.wav","vj_hlr/gsrc/npc/barney/guyresponsible.wav","vj_hlr/gsrc/npc/barney/coldone.wav","vj_hlr/gsrc/npc/barney/ba_gethev.wav","vj_hlr/gsrc/npc/barney/badfeeling.wav","vj_hlr/gsrc/npc/barney/bigmess.wav","vj_hlr/gsrc/npc/barney/bigplace.wav"}
	self.SoundTbl_IdleDialogue = {"vj_hlr/gsrc/npc/barney/youeverseen.wav","vj_hlr/gsrc/npc/barney/workingonstuff.wav","vj_hlr/gsrc/npc/barney/whatsgoingon.wav","vj_hlr/gsrc/npc/barney/thinking.wav","vj_hlr/gsrc/npc/barney/survive.wav","vj_hlr/gsrc/npc/barney/stench.wav","vj_hlr/gsrc/npc/barney/somethingmoves.wav","vj_hlr/gsrc/npc/barney/of1a5_ba01.wav","vj_hlr/gsrc/npc/barney/nodrill.wav","vj_hlr/gsrc/npc/barney/missingleg.wav","vj_hlr/gsrc/npc/barney/luckwillturn.wav","vj_hlr/gsrc/npc/barney/gladof38.wav","vj_hlr/gsrc/npc/barney/gettingcloser.wav","vj_hlr/gsrc/npc/barney/crewdied.wav","vj_hlr/gsrc/npc/barney/ba_idle0.wav","vj_hlr/gsrc/npc/barney/badarea.wav","vj_hlr/gsrc/npc/barney/beertopside.wav"}
	self.SoundTbl_IdleDialogueAnswer = {"vj_hlr/crack_npc/barney/ba_duty.wav","vj_hlr/crack_npc/barney/ba_post.wav","vj_hlr/crack_npc/barney/c3a2_ba_2surv.wav","vj_hlr/crack_npc/barney/drill1a.wav"}
	self.SoundTbl_CombatIdle = {"vj_hlr/gsrc/npc/barney/whatgood.wav","vj_hlr/gsrc/npc/barney/targetpractice.wav","vj_hlr/gsrc/npc/barney/easily.wav","vj_hlr/gsrc/npc/barney/getanyworse.wav"}
	self.SoundTbl_FollowPlayer = {"vj_hlr/crack_npc/barney/ba_pain1.wav"}
	self.SoundTbl_UnFollowPlayer = {"vj_hlr/crack_npc/barney/ba_pain3.wav"}
	self.SoundTbl_Investigate = {"vj_hlr/gsrc/npc/barney/youhearthat.wav","vj_hlr/gsrc/npc/barney/soundsbad.wav","vj_hlr/gsrc/npc/barney/icanhear.wav","vj_hlr/gsrc/npc/barney/hearsomething2.wav","vj_hlr/gsrc/npc/barney/hearsomething.wav","vj_hlr/gsrc/npc/barney/ambush.wav","vj_hlr/gsrc/npc/barney/ba_generic0.wav"}
	self.SoundTbl_Alert = {"vj_hlr/crack_npc/barney/c1a0_ba_headdown.wav","vj_hlr/crack_npc/barney/c3a2_ba_8surv.wav","vj_hlr/gsrc/npc/barney/aimforhead.wav"}
	self.SoundTbl_CallForHelp = {"vj_hlr/gsrc/npc/barney/ba_needhelp0.wav","vj_hlr/gsrc/npc/barney/ba_needhelp1.wav"}
	self.SoundTbl_BecomeEnemyToPlayer = {"vj_hlr/crack_npc/barney/ba_uwish.wav","vj_hlr/crack_npc/barney/ba_tomb.wav","vj_hlr/crack_npc/barney/ba_somuch.wav","vj_hlr/crack_npc/barney/ba_iwish.wav","vj_hlr/crack_npc/barney/ba_endline.wav","vj_hlr/crack_npc/barney/ba_later.wav","vj_hlr/crack_npc/barney/ba_whoathere.wav"}
	self.SoundTbl_Suppressing = {"vj_hlr/gsrc/npc/barney/c1a4_ba_octo2.wav","vj_hlr/gsrc/npc/barney/c1a4_ba_octo4.wav","vj_hlr/gsrc/npc/barney/c1a4_ba_octo3.wav","vj_hlr/gsrc/npc/barney/ba_generic1.wav","vj_hlr/gsrc/npc/barney/ba_bring.wav","vj_hlr/gsrc/npc/barney/ba_attacking1.wav"}
	self.SoundTbl_OnGrenadeSight = {"vj_hlr/gsrc/npc/barney/standback.wav","vj_hlr/gsrc/npc/barney/ba_heeey.wav"}
	self.SoundTbl_OnKilledEnemy = {"vj_hlr/gsrc/npc/barney/soundsbad.wav","vj_hlr/gsrc/npc/barney/ba_seethat.wav","vj_hlr/gsrc/npc/barney/ba_kill0.wav","vj_hlr/gsrc/npc/barney/ba_gotone.wav","vj_hlr/gsrc/npc/barney/ba_firepl.wav","vj_hlr/gsrc/npc/barney/ba_buttugly.wav","vj_hlr/gsrc/npc/barney/ba_another.wav","vj_hlr/gsrc/npc/barney/ba_close.wav"}
	self.SoundTbl_AllyDeath = {"vj_hlr/gsrc/npc/barney/die.wav"}
	self.SoundTbl_Pain = {"vj_hlr/crack_npc/barney/ba_pain1.wav","vj_hlr/gsrc/npc/barney/ba_pain2.wav","vj_hlr/crack_npc/barney/ba_pain3.wav"}
	self.SoundTbl_DamageByPlayer = {"vj_hlr/crack_npc/barney/ba_dontmake.wav","vj_hlr/crack_npc/barney/ba_dotoyou.wav","vj_hlr/crack_npc/barney/ba_friends.wav","vj_hlr/crack_npc/barney/ba_pissme.wav","vj_hlr/crack_npc/barney/ba_stepoff.wav","vj_hlr/crack_npc/barney/ba_watchit.wav","vj_hlr/crack_npc/barney/ba_whatyou.wav"}
	self.SoundTbl_Death = {"vj_hlr/crack_npc/barney/ba_die1.wav","vj_hlr/crack_npc/barney/ba_die2.wav","vj_hlr/gsrc/npc/barney/ba_die3.wav"}
	
	self:Give("weapon_vj_hlr1_glock17")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	//print(key)
	if key == "step" then
		self:FootStepSoundCode()
	elseif key == "shoot" then
		local wep = self:GetActiveWeapon()
		if IsValid(wep) then
			wep:NPCShoot_Primary()
		end
	elseif key == "body" then
		VJ_EmitSound(self, "vj_hlr/crack_fx/bodydrop.wav", 75, 100)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local colorRed = VJ.Color2Byte(Color(130, 19, 10))

function ENT:HandleGibOnDeath(dmginfo, hitgroup)
	self.HasDeathSounds = false
	if self.HasGibOnDeathEffects then
		local effectData = EffectData()
		effectData:SetOrigin(self:GetPos() + self:OBBCenter())
		effectData:SetColor(colorRed)
		effectData:SetScale(120)
		util.Effect("VJ_Blood1", effectData)
		effectData:SetScale(8)
		effectData:SetFlags(3)
		effectData:SetColor(0)
		util.Effect("bloodspray", effectData)
		util.Effect("bloodspray", effectData)
	end
	
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/flesh1.mdl", {CollisionDecal="VJ_HLR1_Blood_Red", Pos=self:LocalToWorld(Vector(0, 0, 40))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/flesh2.mdl", {CollisionDecal="VJ_HLR1_Blood_Red", Pos=self:LocalToWorld(Vector(0, 1, 40))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/flesh3.mdl", {CollisionDecal="VJ_HLR1_Blood_Red", Pos=self:LocalToWorld(Vector(1, 0, 40))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/flesh4.mdl", {CollisionDecal="VJ_HLR1_Blood_Red", Pos=self:LocalToWorld(Vector(1, 1, 40))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/hgib_b_bone.mdl", {CollisionDecal="VJ_HLR1_Blood_Red", Pos=self:LocalToWorld(Vector(0, 0, 50))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/hgib_b_gib.mdl", {CollisionDecal="VJ_HLR1_Blood_Red", Pos=self:LocalToWorld(Vector(0, 0, 41))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/hgib_guts.mdl", {CollisionDecal="VJ_HLR1_Blood_Red", Pos=self:LocalToWorld(Vector(0, 0, 42))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/hgib_hmeat.mdl", {CollisionDecal="VJ_HLR1_Blood_Red", Pos=self:LocalToWorld(Vector(0, 0, 45))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/hgib_lung.mdl", {CollisionDecal="VJ_HLR1_Blood_Red", Pos=self:LocalToWorld(Vector(0, 1, 45))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/hgib_skull.mdl", {CollisionDecal="VJ_HLR1_Blood_Red", Pos=self:LocalToWorld(Vector(0, 0, 60))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/hgib_legbone.mdl", {CollisionDecal="VJ_HLR1_Blood_Red", Pos=self:LocalToWorld(Vector(0, 0, 15))})
	self:PlaySoundSystem("Gib", "vj_base/gib/splat.wav")
	self:PlaySoundSystem("Gib", "vj_hlr/crack_fx/bodysplat.wav")
	return true, {AllowSound = false}
end