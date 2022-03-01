AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2022 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_hlr/cracklife/blackscary.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 80
ENT.HullType = HULL_HUMAN
ENT.VJC_Data = {
    ThirdP_Offset = Vector(-5, 0, -15), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "Bip01 Head", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(5, 0, 5), -- The offset for the controller when the camera is in first person
}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.Bleeds = false
//ENT.BloodColor = ""
ENT.HasBloodParticle = false
ENT.HasBloodDecal = false
ENT.VJ_NPC_Class = {"CLASS_CRACKLIFE_IT"} -- NPCs with the same class with be allied to each other
ENT.HasDeathRagdoll = false

ENT.DeathCorpseFade = true -- Fades the ragdoll on death
ENT.DeathCorpseFadeTime = 0.1 -- How much time until the ragdoll fades | Unit = Seconds
ENT.AllowedToGib = false

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDistance = 50 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 80 -- How far does the damage go?

ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events
ENT.AnimTbl_Run = {ACT_RUN} -- Set the running animations | Put multiple to let the base pick a random animation when it moves
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
--ENT.DeathAnimationTime = 0.8 -- Time until the SNPC spawns its corpse and gets removed
	-- ====== Flinching Variables ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = {"vjseq_flinch"} -- If it uses normal based animation, use this
ENT.HitGroupFlinching_Values = {
	{HitGroup={HITGROUP_LEFTARM}, Animation={ACT_FLINCH_LEFTARM}},
	{HitGroup={HITGROUP_LEFTLEG}, Animation={ACT_FLINCH_LEFTLEG}},
	{HitGroup={HITGROUP_RIGHTARM}, Animation={ACT_FLINCH_RIGHTARM}},
	{HitGroup={HITGROUP_RIGHTLEG}, Animation={ACT_FLINCH_RIGHTLEG}}
}
ENT.AnimTbl_Death = {ACT_DIE_HEADSHOT, ACT_DIEFORWARD}
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
//ENT.SoundTbl_SoundTrack = {"vj_hlr/crack_npc/blackscary/bendrowned.mp3"}
ENT.SoundTbl_Death = {"vj_hlr/crack_npc/blackscary/die.wav"}
ENT.SoundTbl_Breath = {"vj_hlr/crack_npc/blackscary/breathe1.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"vj_hlr/hl1_npc/zombie/zo_attack1.wav","vj_hlr/hl1_npc/zombie/zo_attack2.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"vj_hlr/hl1_npc/zombie/claw_strike1.wav","vj_hlr/hl1_npc/zombie/claw_strike2.wav","vj_hlr/hl1_npc/zombie/claw_strike3.wav"}

ENT.GeneralSoundPitch1 = 100

ENT.BeforeMeleeAttackSoundLevel = 50
ENT.BreathSoundLevel = 55
ENT.ActuallyKilled = false
ENT.BeforeMeleeAttackSoundPitch = VJ_Set(30, 50)
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	if self:GetModel() == "models/vj_hlr/hl1/zombie.mdl" then
		self.HasSoundTrack = true
		self.SoundTbl_SoundTrack = {"vj_hlr/crack_npc/blackscary/bendrowned.mp3"}
	end
	self:SetRenderMode(RENDERMODE_TRANSCOLOR)
	self:SetColor(Color(0,0,0,3))
	self:AddFlags(FL_NOTARGET)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()
	local controlled = self.VJ_IsBeingControlled
	if !self.ActuallyKilled then
		if IsValid(self:GetEnemy()) && !controlled then
			local dist = self:VJ_GetNearestPointToEntityDistance(self:GetEnemy())
			if !(self:GetEnemy():GetForward():Dot((self:GetPos() -self:GetEnemy():GetPos()):GetNormalized()) > math.cos(math.rad(60))) && dist > 350 then
				// Stalk the player
				self.AnimTbl_Run = {ACT_RUN}
				self:SetColor(Color(0,0,0,255))
				self:RemoveFlags(FL_NOTARGET)
				timer.Create("blackscary_camo"..self:EntIndex(), 1, 1, function() self:SetColor(Color(0,0,0,0)) self:AddFlags(FL_NOTARGET) end)
			else
				self.AnimTbl_Run = {ACT_WALK}
				self:SetColor(Color(0,0,0,3))
				self:AddFlags(FL_NOTARGET)
				//
			end
		else
			self.AnimTbl_Run = {ACT_RUN}
			self:SetColor(Color(0,0,0,255))
			self:RemoveFlags(FL_NOTARGET)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	//print(key)
	if key == "event_mattack right" or key == "event_mattack left" or key == "event_mattack both" then
		self:MeleeAttackCode()
	elseif key == "ragdoll" then
		VJ_EmitSound(self, "vj_hlr/fx/bodydrop"..math.random(3, 4)..".wav", 75, 100)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	if math.random(1, 2) == 1 then
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}
		self.MeleeAttackDamage = 10
	else
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK2}
		self.MeleeAttackDamage = 25
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	timer.Remove("blackscary_camo"..self:EntIndex())
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomDeathAnimationCode(dmginfo, hitgroup)
	self.ActuallyKilled = true
	self:SetColor(Color(0,0,0,255))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_BeforeStartTimer(seed) 
	self:RemoveFlags(FL_NOTARGET)
	self:SetColor(Color(0,0,0,255))
end
---------------------------------------------------------------------------------------------------------------------------------------------