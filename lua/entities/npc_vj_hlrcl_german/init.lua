AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2010-2025 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_hlr/cracklife/german1.mdl","models/vj_hlr/cracklife/german2.mdl","models/vj_hlr/cracklife/german3.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.HullType = HULL_HUMAN
ENT.VJ_NPC_Class = {"CLASS_CRACKLIFE_GERMAN"} -- NPCs with the same class with be allied to each other

ENT.MeleeAttackDistance = 20 -- How close an enemy has to be to trigger a melee attack | false = Let the base auto calculate on initialize based on the NPC's collision bounds

ENT.VJC_Data = {
    ThirdP_Offset = Vector(-5, 0, -15), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "Bip01 Head", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(5, 0, 5), -- The offset for the controller when the camera is in first person
}
ENT.StartHealth = 80
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.CustomBlood_Particle = {"vj_hlr_blood_red"}
ENT.CustomBlood_Decal = {"VJ_HLR1_Blood_Red"}
ENT.HasBloodPool = false -- Does it have a blood pool?

ENT.HasRangeAttack = true -- Can this NPC range attack?
ENT.AnimTbl_RangeAttack = ACT_RANGE_ATTACK1 -- Range Attack Animations
ENT.RangeDistance = 1020 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 100 -- How close does it have to be until it uses melee?
ENT.TimeUntilRangeAttackProjectileRelease = false -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = 3 -- How much time until it can use a range attack?
ENT.DisableDefaultRangeAttackCode = true -- When true, it won't spawn the range attack entity, allowing you to make your own

ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Death = {ACT_DIEBACKWARD, ACT_DIEFORWARD, ACT_DIESIMPLE} -- Death Animations
ENT.DeathAnimationTime = false -- Time until the NPC spawns its corpse and gets removed
ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = ACT_SMALL_FLINCH -- If it uses normal based animation, use this
ENT.HitGroupFlinching_Values = {{HitGroup = {HITGROUP_LEFTARM}, Animation = {ACT_FLINCH_LEFTARM}},{HitGroup = {HITGROUP_RIGHTARM}, Animation = {ACT_FLINCH_RIGHTARM}},{HitGroup = {HITGROUP_LEFTLEG}, Animation = {ACT_FLINCH_LEFTLEG}},{HitGroup = {HITGROUP_RIGHTLEG}, Animation = {ACT_FLINCH_RIGHTLEG}}}

ENT.AnimTbl_Death = {ACT_DIEBACKWARD,ACT_DIEFORWARD,ACT_DIESIMPLE,ACT_DIE_GUTSHOT} -- Death Animations
ENT.NextRangeAttackTime = 0.3
ENT.SpawnHat = true
ENT.CanUseHD = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.SoundTbl_FootStep = {"vj_hlr/crack_fx/npc_step1.wav","vj_hlr/crack_fx/npc_step2.wav","vj_hlr/crack_fx/npc_step3.wav","vj_hlr/crack_fx/npc_step4.wav"}
	self.SoundTbl_BeforeRangeAttack = {""}
	self.SoundTbl_RangeAttack = {""}
	self.SoundTbl_Idle = {"vj_hlr/crack_npc/germansoldier/slv_word1.wav","vj_hlr/crack_npc/germansoldier/slv_word2.wav","vj_hlr/crack_npc/germansoldier/slv_word3.wav","vj_hlr/crack_npc/germansoldier/slv_word4.wav","vj_hlr/crack_npc/germansoldier/slv_word5.wav","vj_hlr/crack_npc/germansoldier/slv_word6.wav","vj_hlr/crack_npc/germansoldier/slv_word7.wav","vj_hlr/crack_npc/germansoldier/slv_word8.wav"}
	self.SoundTbl_IdleDialogue = {"vj_hlr/crack_npc/germansoldier/slv_word1.wav","vj_hlr/crack_npc/germansoldier/slv_word2.wav","vj_hlr/crack_npc/germansoldier/slv_word3.wav","vj_hlr/crack_npc/germansoldier/slv_word4.wav","vj_hlr/crack_npc/germansoldier/slv_word5.wav","vj_hlr/crack_npc/germansoldier/slv_word6.wav","vj_hlr/crack_npc/germansoldier/slv_word7.wav","vj_hlr/crack_npc/germansoldier/slv_word8.wav"}
	self.SoundTbl_IdleDialogueAnswer = {"vj_hlr/crack_npc/germansoldier/slv_word1.wav","vj_hlr/crack_npc/germansoldier/slv_word2.wav","vj_hlr/crack_npc/germansoldier/slv_word3.wav","vj_hlr/crack_npc/germansoldier/slv_word4.wav","vj_hlr/crack_npc/germansoldier/slv_word5.wav","vj_hlr/crack_npc/germansoldier/slv_word6.wav","vj_hlr/crack_npc/germansoldier/slv_word7.wav","vj_hlr/crack_npc/germansoldier/slv_word8.wav"}
	self.SoundTbl_Alert = {"vj_hlr/crack_npc/germansoldier/slv_alert1.wav","vj_hlr/crack_npc/germansoldier/slv_alert2.wav","vj_hlr/crack_npc/germansoldier/slv_alert4.wav"}
	self.SoundTbl_Pain = {"vj_hlr/crack_npc/germansoldier/slv_pain1.wav"}
	self.SoundTbl_Death = {"vj_hlr/crack_npc/germansoldier/slv_die1.wav","vj_hlr/crack_npc/germansoldier/slv_die2.wav"}
	self.SoundTbl_MeleeAttackExtra = {"vj_hlr/gsrc/npc/zombie/claw_strike1.wav","vj_hlr/gsrc/npc/zombie/claw_strike2.wav","vj_hlr/gsrc/npc/zombie/claw_strike3.wav"}
	self.SoundTbl_MeleeAttackMiss = {"vj_hlr/gsrc/npc/zombie/claw_miss1.wav","vj_hlr/gsrc/npc/zombie/claw_miss2.wav"}
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	//print(key)
	if key == "event_emit step" or key == "step" then
		self:FootStepSoundCode()
	elseif key == "right" or key == "left" then
		self:MeleeAttackCode()
	elseif key == "shoot" then
		self:RangeAttackCode()
		VJ_EmitSound(self, "vj_hlr/gsrc/npc/hassault/hw_shoot1.wav", 75, 150)
	elseif key == "body" then
		VJ_EmitSound(self, "vj_hlr/crack_fx/bodydrop.wav", 75, 100)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomRangeAttackCode()
	local startPos = self:GetPos() + self:GetUp()*45 + self:GetForward()*40
	local tr = util.TraceLine({
		start = startPos,
		endpos = self:GetAimPosition(self:GetEnemy(), startPos, 0),
		filter = self
	})
	local hitPos = tr.HitPos
	
	-- Fire 2 electric beams at the enemy
	local elec = EffectData()
	elec:SetStart(startPos)
	elec:SetOrigin(hitPos)
	elec:SetEntity(self)
	elec:SetAttachment(1)
	util.Effect("VJ_HLR_Electric", elec)
	elec:SetAttachment(2)
	util.Effect("VJ_HLR_Electric", elec)
	
	VJ.ApplyRadiusDamage(self, self, hitPos, 30, 10, DMG_SHOCK, true, false, {Force = 90})
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:HandleGibOnDeath(dmginfo, hitgroup)
	self.HasDeathSounds = false
	if self.HasGibDeathParticles == true then
		local bloodeffect = EffectData()
		bloodeffect:SetOrigin(self:GetPos() + self:OBBCenter())
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
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh1.mdl",{CollisionDecal="VJ_HLR1_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh2.mdl",{CollisionDecal="VJ_HLR1_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh3.mdl",{CollisionDecal="VJ_HLR1_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh4.mdl",{CollisionDecal="VJ_HLR1_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_b_bone.mdl",{CollisionDecal="VJ_HLR1_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,50))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_b_gib.mdl",{CollisionDecal="VJ_HLR1_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_guts.mdl",{CollisionDecal="VJ_HLR1_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_hmeat.mdl",{CollisionDecal="VJ_HLR1_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,45))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_lung.mdl",{CollisionDecal="VJ_HLR1_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,45))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_skull.mdl",{CollisionDecal="VJ_HLR1_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,60))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_legbone.mdl",{CollisionDecal="VJ_HLR1_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,15))})
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomGibOnDeathSounds(dmginfo, hitgroup)
	VJ_EmitSound(self,"vj_hlr/crack_fx/bodysplat.wav", 90, math.random(100,100))
	VJ_EmitSound(self, "vj_base/gib/splat.wav", 90, 100)
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomDeathAnimationCode(dmginfo, hitgroup)
	if hitgroup == HITGROUP_HEAD then
		self.AnimTbl_Death = {ACT_DIE_HEADSHOT}
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, corpseEnt)
	VJ.HLR_ApplyCorpseSystem(self, corpseEnt, nil)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPriorToKilled(dmginfo, hitgroup)
	if self.SpawnHat == true then
		self:SetBodygroup(1,1)
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/cracklife/w_mp44.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,0)),CollideSound={""}})
		self.SpawnHat = false
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomDeathAnimationCode(dmginfo, hitgroup)
	if hitgroup == HITGROUP_HEAD then
		self.AnimTbl_Death = {ACT_DIE_GUTSHOT,ACT_DIE_HEADSHOT}
	else
		self.AnimTbl_Death = {ACT_DIEBACKWARD,ACT_DIEFORWARD,ACT_DIESIMPLE}
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2010-2025 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/