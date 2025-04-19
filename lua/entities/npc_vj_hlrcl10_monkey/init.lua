AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2010-2025 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_hlr/cracklife10/monkey.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.VJC_Data = {
    ThirdP_Offset = Vector(-5, 0, -15), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "joint13", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(5, 0, 5), -- The offset for the controller when the camera is in first person
}
ENT.StartHealth = 90
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.CustomBlood_Particle = {"vj_hlr_blood_red"}
ENT.CustomBlood_Decal = {"VJ_HLR_Blood_Red"}
ENT.HasBloodPool = false -- Does it have a blood pool?

ENT.VJ_NPC_Class = {"CLASS_CRACKLIFE_MONKE"} -- NPCs with the same class with be allied to each other

ENT.HasLeapAttack = true
-- ====== Distance Variables ====== --
ENT.LeapDistance = 200 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
ENT.LeapToMeleeDistance = 100 -- How close does it have to be until it uses melee?
ENT.LeapAttackDamageDistance = 100 -- How far does the damage go?
ENT.LeapAttackAngleRadius = 60 -- What is the attack angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC

ENT.LeapAttackVelocityForward = 100 -- How much forward force should it apply?
ENT.LeapAttackVelocityUp = 200 -- How much upward force should it apply?

ENT.TimeUntilLeapAttackDamage = 0.3

ENT.HasRangeAttack = true
ENT.AnimTbl_RangeAttack = ACT_RANGE_ATTACK2 -- Range Attack Animations
ENT.AnimTbl_LeapAttack = ACT_RANGE_ATTACK1 -- Range Attack Animations
ENT.NextRangeAttackTime = 4

ENT.TimeUntilRangeAttackProjectileRelease = false

ENT.RangeDistance = 784 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 200 -- How close does it have to be until it uses melee?
ENT.RangeAttackEntityToSpawn = "obj_vj_hlrcl10_poop"

ENT.HasExtraMeleeAttackSounds = true

ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
//ENT.DeathAnimationTime = 0.8 -- Time until the SNPC spawns its corpse and gets removed
	-- ====== Flinching Variables ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = ACT_SMALL_FLINCH -- If it uses normal based animation, use this
ENT.AnimTbl_Death = ACT_DIESIMPLE

ENT.SoundTbl_FootStep = {"vj_hlr/crack_fx/npc_step1.wav","vj_hlr/crack_fx/npc_step2.wav","vj_hlr/crack_fx/npc_step3.wav","vj_hlr/crack_fx/npc_step4.wav"}
ENT.SoundTbl_Idle = {"vj_hlr/crack10_npc/monkey/monke_idle1.wav","vj_hlr/crack10_npc/monkey/monke_idle2.wav","vj_hlr/crack10_npc/monkey/monke_idle3.wav"}
ENT.SoundTbl_Alert = {"vj_hlr/crack10_npc/monkey/monke_alert1.wav", "vj_hlr/crack10_npc/monkey/monke_alert2.wav", "vj_hlr/crack10_npc/monkey/monke_alert3.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"vj_hlr/hl1_npc/zombie/claw_strike1.wav","vj_hlr/hl1_npc/zombie/claw_strike2.wav","vj_hlr/hl1_npc/zombie/claw_strike3.wav"}
ENT.SoundTbl_LeapAttackDamage = {"vj_hlr/hl1_npc/zombie/claw_strike1.wav","vj_hlr/hl1_npc/zombie/claw_strike2.wav","vj_hlr/hl1_npc/zombie/claw_strike3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_hlr/hl1_npc/zombie/claw_miss1.wav","vj_hlr/hl1_npc/zombie/claw_miss2.wav"}
ENT.SoundTbl_LeapAttackDamageMiss = {"vj_hlr/hl1_npc/zombie/claw_miss1.wav","vj_hlr/hl1_npc/zombie/claw_miss2.wav"}
ENT.SoundTbl_Pain = {"vj_hlr/crack10_npc/monkey/monke_pain1.wav", "vj_hlr/crack10_npc/monkey/monke_pain2.wav", "vj_hlr/crack10_npc/monkey/monke_pain3.wav", "vj_hlr/crack10_npc/monkey/monke_pain4.wav", "vj_hlr/crack10_npc/monkey/monke_pain5.wav"}
ENT.SoundTbl_Death = {"vj_hlr/crack10_npc/monkey/monke_pain1.wav", "vj_hlr/crack10_npc/monkey/monke_pain2.wav", "vj_hlr/crack10_npc/monkey/monke_pain3.wav", "vj_hlr/crack10_npc/monkey/monke_pain4.wav", "vj_hlr/crack10_npc/monkey/monke_pain5.wav"}
ENT.SoundTbl_BeforeLeapAttack = {"vj_hlr/crack10_npc/monkey/monke_pain2.wav"}
ENT.SoundTbl_BeforeRangeAttack = {"vj_hlr/crack10_npc/monkey/monke_pain1.wav", "vj_hlr/crack10_npc/monkey/monke_alert2.wav", "vj_hlr/crack10_npc/monkey/monke_alert3.wav"}

ENT.DungThrowSnd = {"vj_hlr/gsrc/fx/flesh1.wav", "vj_hlr/gsrc/fx/flesh2.wav", "vj_hlr/gsrc/fx/flesh3.wav", "vj_hlr/gsrc/fx/flesh5.wav", "vj_hlr/gsrc/fx/flesh6.wav", "vj_hlr/gsrc/fx/flesh7.wav"}

ENT.MeleeAttackDamage = 10

ENT.NextLeapAttackTime = 1
ENT.LeapAttackDamage = 20

-- Custom
ENT.SCI_NextMouthMove = 0
ENT.SCI_NextMouthDistance = 0
ENT.Legbone = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(24, 20 , 30), Vector(-24, -20, 0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	//print(key)
	if key == "step" then
		self:FootStepSoundCode()
    elseif key == "melee" then
		self:MeleeAttackCode()
    //elseif key == "leap" then
		//self:LeapDamageCode()
    elseif key == "range" then
		self:RangeAttackCode()
        VJ_EmitSound(self, table.Random(self.DungThrowSnd), 85, 100)
	elseif key == "body" then
		VJ_EmitSound(self, "vj_hlr/crack_fx/bodydrop.wav", 85, 100)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackProjVelocity(projectile)
	local projPos = projectile:GetPos()
	return self:CalculateProjectile("Curve", projPos, self:GetAimPosition(self:GetEnemy(), projPos, 1, 1000), 1000)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomGibOnDeathSounds(dmginfo,hitgroup)
	VJ_EmitSound(self,"vj_hlr/crack_fx/bodysplat.wav", 90, math.random(100,100))
	VJ_EmitSound(self, "vj_base/gib/splat.wav", 90, math.random(100,100))
	return false
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
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh1.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,10))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh2.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,14))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh3.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,5))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh4.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,20))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_b_gib.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,17))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_guts.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,20))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_hmeat.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,7))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_lung.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,5))})
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPriorToKilled(dmginfo, hitgroup)
	if self.Legbone == true then
		self:SetBodygroup(0,1)
		self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/hgib_legbone.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,0)),CollideSound={""}})
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, corpseEnt)
	VJ.HLR_ApplyCorpseSystem(self, corpseEnt)
end