include("entities/npc_vj_hlr1_zombie/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2010-2025 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_hlr/cracklife10/fedorasci.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.VJC_Data = {
    ThirdP_Offset = Vector(-5, 0, -15), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "Bip02 Head", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(5, 0, 5), -- The offset for the controller when the camera is in first person
}
ENT.StartHealth = 90
ENT.HullType = HULL_HUMAN
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.CustomBlood_Particle = {"vj_hlr_blood_red"}
ENT.CustomBlood_Decal = {"VJ_HLR1_Blood_Red"}
ENT.VJ_NPC_Class = {"CLASS_CRACKLIFE_REDDIT"} -- NPCs with the same class with be allied to each other

ENT.HasLeapAttack = true
-- ====== Distance Variables ====== --
ENT.LeapDistance = 150 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
ENT.LeapToMeleeDistance = 100 -- How close does it have to be until it uses melee?
ENT.LeapAttackDamageDistance = 100 -- How far does the damage go?
ENT.LeapAttackAngleRadius = 60 -- What is the attack angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC

ENT.LeapAttackVelocityForward = 50 -- How much forward force should it apply?
ENT.LeapAttackVelocityUp = 150 -- How much upward force should it apply?

ENT.TimeUntilLeapAttackDamage = false

ENT.HasRangeAttack = true
ENT.NextRangeAttackTime = 5
ENT.AnimTbl_RangeAttack = ACT_RANGE_ATTACK1
ENT.TimeUntilRangeAttackProjectileRelease = 0.4
ENT.RangeDistance = 400 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 200 -- How close does it have to be until it uses melee?

ENT.SoundTbl_FootStep = {"vj_hlr/crack_fx/npc_step1.wav","vj_hlr/crack_fx/npc_step2.wav","vj_hlr/crack_fx/npc_step3.wav","vj_hlr/crack_fx/npc_step4.wav"}
ENT.SoundTbl_Idle = {"vj_hlr/crack10_npc/scientist/amogus.wav","vj_hlr/crack10_npc/scientist/africa.wav","vj_hlr/crack10_npc/scientist/reddit.wav","vj_hlr/crack10_npc/scientist/cringe2.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"vj_hlr/gsrc/fx/null.wav","vj_hlr/gsrc/fx/null.wav"}
ENT.SoundTbl_Alert = {"vj_hlr/crack10_npc/scientist/fedora1.wav","vj_hlr/crack10_npc/scientist/fedora2.wav","vj_hlr/crack10_npc/scientist/fedora3.wav","vj_hlr/crack10_npc/scientist/fedora4.wav","vj_hlr/crack10_npc/scientist/fedora5.wav","vj_hlr/crack10_npc/scientist/fedora6.wav"}
ENT.SoundTbl_RangeAttack = {"vj_hlr/crack10_npc/scientist/fedora1.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"vj_hlr/gsrc/npc/zombie/claw_strike1.wav","vj_hlr/gsrc/npc/zombie/claw_strike2.wav","vj_hlr/gsrc/npc/zombie/claw_strike3.wav"}
ENT.SoundTbl_LeapAttackDamage = {"vj_hlr/gsrc/npc/zombie/claw_strike1.wav","vj_hlr/gsrc/npc/zombie/claw_strike2.wav","vj_hlr/gsrc/npc/zombie/claw_strike3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_hlr/gsrc/npc/zombie/claw_miss1.wav","vj_hlr/gsrc/npc/zombie/claw_miss2.wav"}
ENT.SoundTbl_LeapAttackDamageMiss = {"vj_hlr/gsrc/npc/zombie/claw_miss1.wav","vj_hlr/gsrc/npc/zombie/claw_miss2.wav"}
ENT.SoundTbl_Pain = {"vj_hlr/gsrc/npc/scientist/sci_pain1.wav","vj_hlr/gsrc/npc/scientist/sci_pain2.wav","vj_hlr/gsrc/npc/scientist/sci_pain3.wav","vj_hlr/gsrc/npc/scientist/sci_pain4.wav","vj_hlr/gsrc/npc/scientist/sci_pain5.wav"}
ENT.SoundTbl_Death = {"vj_hlr/gsrc/npc/scientist/sci_pain1.wav","vj_hlr/gsrc/npc/scientist/sci_pain2.wav","vj_hlr/gsrc/npc/scientist/sci_pain3.wav","vj_hlr/gsrc/npc/scientist/sci_pain4.wav","vj_hlr/gsrc/npc/scientist/sci_pain5.wav"}

ENT.MeleeAttackDamage = 33

ENT.NextLeapAttackTime = 0.5
ENT.LeapAttackDamage = 60

-- Custom
ENT.SCI_NextMouthMove = 0
ENT.SCI_NextMouthDistance = 0
ENT.SpawnHat = true
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Init()
	local randBG = math.random(0, 3)
	self:SetBodygroup(1, randBG)
	if randBG == 2 then
		self:SetSkin(1)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:TranslateActivity(act)
	return self.BaseClass.TranslateActivity(self, act)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnRangeAttackExecute(status, enemy, projectile)
	//print("nothing personnel, kid.")
	if status == "Init" then
		VJ.EmitSound(self, "vj_hlr/gsrc/fx/beamstart8.wav", 85, 100)

		local size = 1.5

		local spr = ents.Create("env_sprite")
		spr:SetKeyValue("model", "vj_hl/sprites/fexplo1.vmt")
		spr:SetKeyValue("scale", ""..size)
		spr:SetKeyValue("rendercolor", "77 210 130")
		spr:SetKeyValue("rendermode", "5") -- 5 = Additive render mode
		spr:SetKeyValue("renderamt", "255")
		spr:SetKeyValue("framerate", "10.0")
		spr:SetKeyValue("spawnflags", "2") -- 2 (SF_SPRITE_ONCE) = Makes it animate / display only once
		spr:SetPos(self:GetAttachment(self:LookupAttachment("__illumPosition")).Pos)
		spr:Spawn()
		spr:Fire("Kill", "", 1)


		local enemy = self:GetEnemy()
		if IsValid(enemy) and IsValid(self) then
			local enePos = enemy:GetPos()
			local eneForward = enemy:EyeAngles():Forward() * -120
			local mins, maxs = enemy:GetCollisionBounds()

			-- Calculate the position behind the player
			local newPos = enePos + eneForward - (mins)// * offset

			-- Set the new position for the entity
			self:SetPos(newPos)

			-- Check for collisions and adjust the position if needed
			local trace = util.TraceHull({
				start = newPos,
				endpos = newPos,
				mins = mins,
				maxs = maxs,
				filter = self
			})

			if trace.Hit then
				-- Adjust the position to avoid collisions
				self:SetPos(enemy:GetPos() + enemy:GetForward() * 50)
			end

			local lookAt = (enePos - self:GetPos()):Angle()
			lookAt.p = 0 -- Lock pitch to avoid tilting

			-- Set the new angles for the entity
			self:SetAngles(lookAt)

			timer.Simple(0.1, function()
				if IsValid(self) then
					local spr2 = ents.Create("env_sprite")
					spr2:SetKeyValue("model", "vj_hl/sprites/fexplo1.vmt")
					spr2:SetKeyValue("scale", ""..size)
					spr2:SetKeyValue("rendercolor", "77 210 130")
					spr2:SetKeyValue("rendermode", "5") -- 5 = Additive render mode
					spr2:SetKeyValue("renderamt", "255")
					spr2:SetKeyValue("framerate", "10.0")
					spr2:SetKeyValue("spawnflags", "2") -- 2 (SF_SPRITE_ONCE) = Makes it animate / display only once
					spr2:SetPos(self:GetAttachment(self:LookupAttachment("__illumPosition")).Pos)
					spr2:Spawn()
					spr2:Fire("Kill", "", 1)
				end
			end)
		end
		return true
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInput(key,activator,caller,data)
	//print(key)
	if key == "step" then
		self:PlayFootstepSound()
    elseif key == "melee" then
		self:ExecuteMeleeAttack()
    elseif key == "jumpmelee" then
		self:ExecuteLeapAttack()
    elseif key == "teleport" then
		//self:RangeAttackCode()
	elseif key == "body" then
		VJ_EmitSound(self, "vj_hlr/crack_fx/bodydrop.wav", 85, 100)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MeleeAttackKnockbackVelocity(hitEnt)
	return self:GetForward()*-25
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
function ENT:OnCreateSound(sdData, sdFile)
	self.SCI_NextMouthMove = CurTime() + SoundDuration(sdFile)
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
local animDeathHead = {ACT_DIE_GUTSHOT, ACT_DIE_HEADSHOT}
local animDeathDef = {ACT_DIEBACKWARD, ACT_DIEFORWARD, ACT_DIESIMPLE}
--
function ENT:OnDeath(dmginfo, hitgroup, status)
	if self.SpawnHat == true then
		self:SetBodygroup(0,1)
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/cracklife10/katana.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,0)),CollideSound={""}})
		self.SpawnHat = false
	end
	if status == "DeathAnim" then
		if hitgroup == HITGROUP_HEAD then
			self.AnimTbl_Death = animDeathHead
		else
			self.AnimTbl_Death = animDeathDef
		end
	end
end