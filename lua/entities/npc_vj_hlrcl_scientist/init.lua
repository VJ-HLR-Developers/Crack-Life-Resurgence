include("entities/npc_vj_hlr1_scientist/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2010-2025 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_hlr/cracklife/scientist.mdl" -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.SpawnShit = 0
ENT.CanUseHD = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.SoundTbl_FootStep = {"vj_hlr/crack_fx/npc_step1.wav","vj_hlr/crack_fx/npc_step2.wav","vj_hlr/crack_fx/npc_step3.wav","vj_hlr/crack_fx/npc_step4.wav"}
	self.SoundTbl_Idle = {"vj_hlr/gsrc/npc/scientist/administrator.wav","vj_hlr/gsrc/npc/scientist/c1a0_sci_stall.wav","vj_hlr/gsrc/npc/scientist/c1a1_sci_3scan.wav","vj_hlr/gsrc/npc/scientist/c1a1_sci_2scan.wav","vj_hlr/gsrc/npc/scientist/c1a1_sci_1scan.wav","vj_hlr/gsrc/npc/scientist/c1a4_sci_trainend.wav","vj_hlr/gsrc/npc/scientist/containfail.wav","vj_hlr/gsrc/npc/scientist/cough.wav","vj_hlr/gsrc/npc/scientist/fusionshunt.wav","vj_hlr/gsrc/npc/scientist/hopenominal.wav","vj_hlr/gsrc/npc/scientist/hideglasses.wav","vj_hlr/gsrc/npc/scientist/howinteresting.wav","vj_hlr/gsrc/npc/scientist/ipredictedthis.wav","vj_hlr/gsrc/npc/scientist/needsleep.wav","vj_hlr/gsrc/npc/scientist/neverseen.wav","vj_hlr/gsrc/npc/scientist/nogrant.wav","vj_hlr/gsrc/npc/scientist/organicmatter.wav","vj_hlr/gsrc/npc/scientist/peculiarmarks.wav","vj_hlr/gsrc/npc/scientist/peculiarodor.wav","vj_hlr/gsrc/npc/scientist/reportflux.wav","vj_hlr/gsrc/npc/scientist/runtest.wav","vj_hlr/gsrc/npc/scientist/shutdownchart.wav","vj_hlr/gsrc/npc/scientist/somethingfoul.wav","vj_hlr/gsrc/npc/scientist/sneeze.wav","vj_hlr/gsrc/npc/scientist/sniffle.wav","vj_hlr/gsrc/npc/scientist/stench.wav","vj_hlr/gsrc/npc/scientist/thatsodd.wav","vj_hlr/gsrc/npc/scientist/thatsmell.wav","vj_hlr/gsrc/npc/scientist/allnominal.wav","vj_hlr/gsrc/npc/scientist/importantspecies.wav","vj_hlr/gsrc/npc/scientist/yawn.wav","vj_hlr/gsrc/npc/scientist/whoresponsible.wav","vj_hlr/crack_npc/scientist/c3a2_sci_fool.wav"}
	self.SoundTbl_IdleDialogue = {"vj_hlr/crack_npc/scientist/lvl20speak1.wav","vj_hlr/crack_npc/scientist/c3a2_sci_1glu.wav","vj_hlr/crack_npc/scientist/lvl20speak4.wav","vj_hlr/crack_npc/scientist/lvl20speak2.wav","vj_hlr/crack_npc/scientist/lvl20speak3.wav","vj_hlr/crack_npc/scientist/lvl20speak5.wav","vj_hlr/crack_npc/scientist/fuckoff1.wav","vj_hlr/crack_npc/scientist/fuckoff2.wav"}
	self.SoundTbl_IdleDialogueAnswer = {"vj_hlr/crack_npc/scientist/lvl20speak2.wav","vj_hlr/crack_npc/scientist/lvl20speak3.wav","vj_hlr/crack_npc/scientist/lvl20speak5.wav","vj_hlr/crack_npc/scientist/fuckoff1.wav","vj_hlr/crack_npc/scientist/fuckoff2.wav"}
	self.SoundTbl_CombatIdle = {"vj_hlr/gsrc/npc/scientist/scream01.wav","vj_hlr/gsrc/npc/scientist/scream02.wav","vj_hlr/gsrc/npc/scientist/scream03.wav","vj_hlr/gsrc/npc/scientist/scream04.wav","vj_hlr/gsrc/npc/scientist/scream05.wav","vj_hlr/gsrc/npc/scientist/scream06.wav","vj_hlr/gsrc/npc/scientist/scream07.wav","vj_hlr/gsrc/npc/scientist/scream08.wav","vj_hlr/gsrc/npc/scientist/scream09.wav","vj_hlr/gsrc/npc/scientist/scream10.wav","vj_hlr/gsrc/npc/scientist/scream11.wav","vj_hlr/gsrc/npc/scientist/scream12.wav","vj_hlr/gsrc/npc/scientist/scream13.wav","vj_hlr/gsrc/npc/scientist/scream14.wav","vj_hlr/gsrc/npc/scientist/scream15.wav","vj_hlr/gsrc/npc/scientist/scream16.wav","vj_hlr/gsrc/npc/scientist/scream17.wav","vj_hlr/gsrc/npc/scientist/scream18.wav","vj_hlr/gsrc/npc/scientist/scream19.wav","vj_hlr/gsrc/npc/scientist/scream20.wav","vj_hlr/gsrc/npc/scientist/scream22.wav","vj_hlr/gsrc/npc/scientist/scream23.wav","vj_hlr/gsrc/npc/scientist/scream24.wav","vj_hlr/gsrc/npc/scientist/scream25.wav","vj_hlr/gsrc/npc/scientist/sci_fear8.wav","vj_hlr/gsrc/npc/scientist/sci_fear7.wav","vj_hlr/gsrc/npc/scientist/sci_fear15.wav","vj_hlr/gsrc/npc/scientist/sci_fear2.wav","vj_hlr/gsrc/npc/scientist/sci_fear3.wav","vj_hlr/gsrc/npc/scientist/sci_fear4.wav","vj_hlr/gsrc/npc/scientist/sci_fear5.wav","vj_hlr/gsrc/npc/scientist/sci_fear11.wav","vj_hlr/gsrc/npc/scientist/sci_fear12.wav","vj_hlr/gsrc/npc/scientist/sci_fear13.wav","vj_hlr/gsrc/npc/scientist/sci_fear1.wav","vj_hlr/gsrc/npc/scientist/rescueus.wav","vj_hlr/gsrc/npc/scientist/nooo.wav","vj_hlr/gsrc/npc/scientist/noplease.wav","vj_hlr/gsrc/npc/scientist/madness.wav","vj_hlr/gsrc/npc/scientist/gottogetout.wav","vj_hlr/gsrc/npc/scientist/getoutofhere.wav","vj_hlr/gsrc/npc/scientist/getoutalive.wav","vj_hlr/gsrc/npc/scientist/evergetout.wav","vj_hlr/gsrc/npc/scientist/dontwantdie.wav","vj_hlr/gsrc/npc/scientist/b01_sci01_whereami.wav","vj_hlr/gsrc/npc/scientist/cantbeworse.wav","vj_hlr/gsrc/npc/scientist/canttakemore.wav","vj_hlr/crack_npc/scientist/c1a0_sci_catscream.wav"}
	self.SoundTbl_FollowPlayer = {"vj_hlr/crack_npc/scientist/follow1.wav","vj_hlr/crack_npc/scientist/follow2.wav","vj_hlr/crack_npc/scientist/follow3.wav","vj_hlr/crack_npc/scientist/follow4.wav","vj_hlr/crack_npc/scientist/sci_somewhere.wav"}
	self.SoundTbl_UnFollowPlayer = {"vj_hlr/gsrc/npc/scientist/whyleavehere.wav","vj_hlr/gsrc/npc/scientist/slowingyou.wav","vj_hlr/gsrc/npc/scientist/reconsider.wav","vj_hlr/gsrc/npc/scientist/leavingme.wav","vj_hlr/gsrc/npc/scientist/istay.wav","vj_hlr/gsrc/npc/scientist/illwaithere.wav","vj_hlr/gsrc/npc/scientist/illwait.wav","vj_hlr/gsrc/npc/scientist/fine.wav","vj_hlr/gsrc/npc/scientist/d01_sci14_right.wav","vj_hlr/gsrc/npc/scientist/crowbar.wav","vj_hlr/gsrc/npc/scientist/cantbeserious.wav","vj_hlr/gsrc/npc/scientist/c1a3_sci_1man.wav","vj_hlr/gsrc/npc/scientist/c1a1_sci_5scan.wav","vj_hlr/gsrc/npc/scientist/asexpected.wav","vj_hlr/gsrc/npc/scientist/beenaburden.wav"}
	self.SoundTbl_MoveOutOfPlayersWay = {"vj_hlr/gsrc/npc/scientist/sorryimleaving.wav","vj_hlr/gsrc/npc/scientist/excuse.wav"}
	self.SoundTbl_MedicBeforeHeal = {"vj_hlr/gsrc/npc/scientist/youlookbad.wav","vj_hlr/gsrc/npc/scientist/youlookbad2.wav","vj_hlr/gsrc/npc/scientist/youneedmedic.wav","vj_hlr/gsrc/npc/scientist/youwounded.wav","vj_hlr/gsrc/npc/scientist/thiswillhelp.wav","vj_hlr/gsrc/npc/scientist/letstrythis.wav","vj_hlr/gsrc/npc/scientist/letmehelp.wav","vj_hlr/gsrc/npc/scientist/holdstill.wav","vj_hlr/gsrc/npc/scientist/heal1.wav","vj_hlr/gsrc/npc/scientist/heal2.wav","vj_hlr/gsrc/npc/scientist/heal3.wav","vj_hlr/gsrc/npc/scientist/heal4.wav","vj_hlr/gsrc/npc/scientist/heal5.wav"}
	self.SoundTbl_OnPlayerSight = {"vj_hlr/gsrc/npc/scientist/undertest.wav","vj_hlr/gsrc/npc/scientist/sci_somewhere.wav","vj_hlr/gsrc/npc/scientist/saved.wav","vj_hlr/gsrc/npc/scientist/newhevsuit.wav","vj_hlr/gsrc/npc/scientist/keller.wav","vj_hlr/gsrc/npc/scientist/inmesstoo.wav","vj_hlr/gsrc/npc/scientist/hellothere.wav","vj_hlr/gsrc/npc/scientist/hellofromlab.wav","vj_hlr/gsrc/npc/scientist/hellofreeman.wav","vj_hlr/gsrc/npc/scientist/hello.wav","vj_hlr/gsrc/npc/scientist/greetings.wav","vj_hlr/gsrc/npc/scientist/greetings2.wav","vj_hlr/gsrc/npc/scientist/goodtoseeyou.wav","vj_hlr/gsrc/npc/scientist/freemanalive.wav","vj_hlr/gsrc/npc/scientist/freeman.wav","vj_hlr/gsrc/npc/scientist/fix.wav","vj_hlr/gsrc/npc/scientist/corporal.wav","vj_hlr/gsrc/npc/scientist/c3a2_sci_1surv.wav","vj_hlr/crack_npc/scientist/c3a2_sci_position.wav","vj_hlr/crack_npc/scientist/c1a4_sci_rocket.wav","vj_hlr/crack_npc/scientist/c1a1_sci_5scan.wav","vj_hlr/crack_npc/scientist/c1a0_sci_gm.wav","vj_hlr/crack_npc/scientist/c1a0_sci_ctrl4a.wav","vj_hlr/crack_npc/scientist/c1a0_sci_ctrl3a.wav","vj_hlr/crack_npc/scientist/c1a0_sci_ctrl2a.wav","vj_hlr/crack_npc/scientist/c1a0_sci_crit3a.wav","vj_hlr/crack_npc/scientist/c1a0_sci_crit2a.wav"}
	self.SoundTbl_Investigate = {"vj_hlr/gsrc/npc/scientist/whatissound.wav","vj_hlr/gsrc/npc/scientist/overhere.wav","vj_hlr/gsrc/npc/scientist/lowervoice.wav","vj_hlr/gsrc/npc/scientist/ihearsomething.wav","vj_hlr/gsrc/npc/scientist/hello2.wav","vj_hlr/gsrc/npc/scientist/hearsomething.wav","vj_hlr/gsrc/npc/scientist/didyouhear.wav","vj_hlr/gsrc/npc/scientist/d01_sci10_interesting.wav","vj_hlr/gsrc/npc/scientist/c3a2_sci_1glu.wav"}
	self.SoundTbl_Alert = {"vj_hlr/crack_npc/scientist/sci6.wav","vj_hlr/crack_npc/scientist/c1a3_sci_team.wav","vj_hlr/crack_npc/scientist/c1a3_sci_rescued.wav"}
	self.SoundTbl_BecomeEnemyToPlayer = {"vj_hlr/crack_npc/scientist/sci_aftertest.wav","vj_hlr/crack_npc/scientist/fuckoff1.wav","vj_hlr/crack_npc/scientist/fuckoff2.wav"}
	self.SoundTbl_OnGrenadeSight = {"vj_hlr/gsrc/npc/scientist/sci_fear6.wav","vj_hlr/gsrc/npc/scientist/sci_fear14.wav","vj_hlr/gsrc/npc/scientist/c1a2_sci_1zomb.wav"}
	self.SoundTbl_AllyDeath = {"vj_hlr/crack_npc/scientist/scie3.wav"}
	self.SoundTbl_Pain = {"vj_hlr/gsrc/npc/scientist/sci_pain1.wav","vj_hlr/gsrc/npc/scientist/sci_pain2.wav","vj_hlr/gsrc/npc/scientist/sci_pain3.wav","vj_hlr/gsrc/npc/scientist/sci_pain4.wav","vj_hlr/gsrc/npc/scientist/sci_pain5.wav","vj_hlr/gsrc/npc/scientist/sci_pain6.wav","vj_hlr/gsrc/npc/scientist/sci_pain7.wav","vj_hlr/gsrc/npc/scientist/sci_pain8.wav","vj_hlr/gsrc/npc/scientist/sci_pain9.wav","vj_hlr/gsrc/npc/scientist/sci_pain10.wav","vj_hlr/gsrc/npc/scientist/sci_fear9.wav","vj_hlr/gsrc/npc/scientist/sci_fear10.wav","vj_hlr/gsrc/npc/scientist/c1a2_sci_dangling.wav","vj_hlr/gsrc/npc/scientist/iwounded.wav","vj_hlr/gsrc/npc/scientist/iwounded2.wav","vj_hlr/gsrc/npc/scientist/iwoundedbad.wav"}
	self.SoundTbl_DamageByPlayer = {"vj_hlr/crack_npc/scientist/vomit.wav","vj_hlr/crack_npc/scientist/sci6.wav"}
	self.SoundTbl_Death = {"vj_hlr/crack_npc/scientist/sci_busy.wav","vj_hlr/crack_npc/scientist/vomit.wav"}
	
	local randBG = math.random(0, 4)
	self:SetBodygroup(1, randBG)
	if randBG == 2 && self.SCI_Type == 0 then
		self:SetSkin(1)
	end
	
	self.SCI_NextTieAnnoyanceT = CurTime() + math.Rand(20, 100)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	//print(key)
	if key == "step" or key == "wheelchair" then
		self:FootStepSoundCode()
	elseif key == "lift" /*&& !self:BusyWithActivity()*/ then
		self:SetBodygroup(2,2)
		self.SpawnShit = 2
		self:StopAllCommonSpeechSounds()
		self:PlaySoundSystem("GeneralSpeech", "vj_hlr/crack_npc/scientist/lift.wav")
		//VJ_EmitSound(self, {"vj_hlr/gsrc/npc/scientist/weartie.wav","vj_hlr/gsrc/npc/scientist/ties.wav"}, 80, 100)
	elseif key == "draw" then
		self:SetBodygroup(2,1)
		self.SpawnShit = 1
	elseif key == "holster" then
		self:SetBodygroup(2,0)
		self.SpawnShit = 0
	elseif key == "body" then
		VJ_EmitSound(self, "vj_hlr/crack_fx/bodydrop.wav", 75, 100)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_IntMsg(ply, controlEnt)
	ply:ChatPrint("RELOAD: Toggle scared animations")
	ply:ChatPrint("LMOUSE: Question everyone if they even lift (if not scared & possible)")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnMedicBehavior(status, statusData)
	if status == "BeforeHeal" then
		-- Healing animation (3)
		self:PlayAnim(ACT_ARM, true, false, false, 0, {OnFinish=function(interrupted, anim)
			if interrupted then return end
			self:PlayAnim(ACT_MELEE_ATTACK1, true, false, false, 0, {OnFinish=function(interrupted2, anim2)


				local ent = self.MedicData.Target
				self.SoundTbl_MedicReceiveHeal = {""}
				local d = DamageInfo()
				d:SetAttacker(ent)
				d:SetInflictor(self)
				d:SetDamageType(DMG_NERVEGAS) 
				d:SetDamage(ent:Health())
				ent:TakeDamageInfo(d)

				if interrupted2 then return end
				self:PlayAnim(ACT_DISARM, true, false)
			end})
		end})
	elseif status == "OnReset" then
		timer.Simple(1.5, function() if IsValid(self) then self:SetBodygroup(2, 0) end end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPriorToKilled(dmginfo, hitgroup)
	self:SetBodygroup(2,0)
	if self.SpawnShit == 1 then
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/cracklife/bigneedle.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,50)),CollideSound={"vj_hlr/crack_fx/metal1.wav"}})
	elseif self.SpawnShit == 2 then
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/cracklife/camera.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,50)),CollideSound={"vj_hlr/crack_fx/metal1.wav"}})
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