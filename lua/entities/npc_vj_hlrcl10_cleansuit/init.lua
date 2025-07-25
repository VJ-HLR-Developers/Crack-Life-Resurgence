AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2010-2025 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_hlr/cracklife10/cleansuit_scientist.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 60
ENT.ControllerParams = {
    ThirdP_Offset = Vector(-5, 0, -15), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "Bip02 Head", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(5, 0, 5), -- The offset for the controller when the camera is in first person
}
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.CustomBlood_Particle = {"vj_hlr_blood_red"}
ENT.CustomBlood_Decal = {"VJ_HLR1_Blood_Red"} -- Decals to spawn when it's damaged
ENT.HasBloodPool = false -- Does it have a blood pool?
ENT.VJ_NPC_Class = {"CLASS_CRACKLIFE_SCHIZO"} -- NPCs with the same class with be allied to each other

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDistance = 15 -- How close an enemy has to be to trigger a melee attack | false = Let the base auto calculate on initialize based on the NPC's collision bounds
ENT.MeleeAttackDamageDistance = 20 -- How far does the damage go | false = Let the base auto calculate on initialize based on the NPC's collision bounds
ENT.MeleeAttackDamage = 50

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.AnimTbl_RangeAttack = ACT_RANGE_ATTACK1 -- Range Attack Animations
ENT.RangeAttackEntityToSpawn = "obj_vj_hlr1_toxicspit" -- The entity that is spawned when range attacking
ENT.TimeUntilRangeAttackProjectileRelease = false
ENT.NextRangeAttackTime = 1.5 -- How much time until it can use a range attack?
ENT.RangeDistance = 500 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 150 -- How close does it have to be until it uses melee?
ENT.RangeUseAttachmentForPos = false -- Should the projectile spawn on a attachment?
ENT.RangeAttackPos_Up = 60 -- Up/Down spawning position for range attack
ENT.RangeAttackPos_Forward = 0 -- Forward/ Backward spawning position for range attack
ENT.RangeAttackPos_Right = 10 -- Right/Left spawning position for range attack

ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
//ENT.DeathAnimationTime = 0.8 -- Time until the SNPC spawns its corpse and gets removed
	-- ====== Flinching Variables ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = ACT_SMALL_FLINCH -- If it uses normal based animation, use this
ENT.HitGroupFlinching_Values = {
	{HitGroup={HITGROUP_LEFTARM}, Animation={ACT_FLINCH_LEFTARM}},
	{HitGroup={HITGROUP_LEFTLEG}, Animation={ACT_FLINCH_LEFTLEG}},
	{HitGroup={HITGROUP_RIGHTARM}, Animation={ACT_FLINCH_RIGHTARM}},
	{HitGroup={HITGROUP_RIGHTLEG}, Animation={ACT_FLINCH_RIGHTLEG}}
}
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"vj_hlr/crack_fx/npc_step1.wav","vj_hlr/crack_fx/npc_step2.wav","vj_hlr/crack_fx/npc_step3.wav","vj_hlr/crack_fx/npc_step4.wav"}
ENT.SoundTbl_Idle = {"vj_hlr/crack10_npc/cleansuit/cs_idle1.wav","vj_hlr/crack10_npc/cleansuit/cs_idle2.wav","vj_hlr/crack10_npc/cleansuit/cs_idle3.wav","vj_hlr/crack10_npc/cleansuit/cs_idle4.wav","vj_hlr/crack10_npc/cleansuit/cs_idle5.wav"}
ENT.SoundTbl_CombatIdle = {"vj_hlr/crack10_npc/cleansuit/cs_alert3.wav","vj_hlr/crack10_npc/cleansuit/cs_alert5.wav","vj_hlr/crack10_npc/cleansuit/cs_idle1.wav","vj_hlr/crack10_npc/cleansuit/cs_idle3.wav","vj_hlr/crack10_npc/cleansuit/cs_idle4.wav"}
ENT.SoundTbl_Alert = {"vj_hlr/crack10_npc/cleansuit/cs_alert1.wav", "vj_hlr/crack10_npc/cleansuit/cs_alert2.wav", "vj_hlr/crack10_npc/cleansuit/cs_alert3.wav","vj_hlr/crack10_npc/cleansuit/cs_alert4.wav","vj_hlr/crack10_npc/cleansuit/cs_alert5.wav","vj_hlr/crack10_npc/cleansuit/cs_alert6.wav","vj_hlr/crack10_npc/cleansuit/cs_alert7.wav"}
ENT.SoundTbl_Pain = {"vj_hlr/gsrc/npc/scientist/sci_pain1.wav","vj_hlr/gsrc/npc/scientist/sci_pain2.wav","vj_hlr/gsrc/npc/scientist/sci_pain3.wav","vj_hlr/gsrc/npc/scientist/sci_pain4.wav","vj_hlr/gsrc/npc/scientist/sci_pain5.wav"}
ENT.SoundTbl_Death = {"vj_hlr/gsrc/npc/scientist/sci_pain1.wav","vj_hlr/gsrc/npc/scientist/sci_pain2.wav","vj_hlr/gsrc/npc/scientist/sci_pain3.wav","vj_hlr/gsrc/npc/scientist/sci_pain4.wav","vj_hlr/gsrc/npc/scientist/sci_pain5.wav"}

ENT.GeneralSoundPitch1 = 100

-- Custom
ENT.SCI_NextMouthMove = 0
ENT.SCI_NextMouthDistance = 0
ENT.SpawnHat = true
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetBodygroup(1, math.random(0, 3))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	//print(key)
	if key == "step" then
		self:FootStepSoundCode()
    elseif key == "body" then
		VJ_EmitSound(self, "vj_hlr/crack_fx/bodydrop.wav", 85, 100)
	elseif key == "melee" then
        self:MeleeAttackCode()
    elseif key == "spray" then
        self:RangeAttackCode()
        VJ_EmitSound(self, "vj_hlr/gsrc/npc/bullchicken/bc_attack2.wav", 75, 100)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	-- Mouth animation when talking
	if CurTime() < self.SCI_NextMouthMove then
		if self.SCI_NextMouthDistance == 0 then
			self.SCI_NextMouthDistance = math.random(10,70)
		else
			self.SCI_NextMouthDistance = 0
		end
		self:SetPoseParameter("m", self.SCI_NextMouthDistance)
	else
		self:SetPoseParameter("m", 0)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackCode_GetShootPos(projectile)
	local ene = self:GetEnemy()
	return self:CalculateProjectile("Curve", projectile:GetPos(), ene:GetPos() + ene:OBBCenter(), 1500)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnCreateSound(sdData, sdFile)
	self.SCI_NextMouthMove = CurTime() + SoundDuration(sdFile)
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
	self:PlaySoundSystem("Gib", "vj_base/gib/splat.wav")
	self:PlaySoundSystem("Gib", "vj_hlr/crack_fx/bodysplat.wav")
	return true, {AllowSound = false}
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPriorToKilled(dmginfo, hitgroup)
	if self.SpawnHat == true then
		self:SetBodygroup(2,1)
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/cracklife10/needle.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(4,15,10)),CollideSound={""}})
        self:CreateGibEntity("obj_vj_gib","models/vj_hlr/cracklife10/spray.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(4,-15,10)),CollideSound={""}})
		self.SpawnHat = false
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomDeathAnimationCode(dmginfo, hitgroup)
	if hitgroup == HITGROUP_HEAD then
		self.AnimTbl_Death = {ACT_DIE_HEADSHOT}
	else
		self.AnimTbl_Death = {ACT_DIEBACKWARD,ACT_DIEFORWARD,ACT_DIESIMPLE,ACT_DIE_GUTSHOT}
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, corpseEnt)
	VJ.HLR_ApplyCorpseSystem(self, corpseEnt)
end
/*-----------------------------------------------
	*** Copyright (c) 2010-2025 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/