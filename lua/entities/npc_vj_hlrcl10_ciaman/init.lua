AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2010-2025 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_hlr/cracklife10/ciaman.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 130
ENT.ControllerParams = {
    ThirdP_Offset = Vector(-5, 0, -15), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "Bip01 Head", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(5, 0, 5), -- The offset for the controller when the camera is in first person
}
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.CustomBlood_Particle = {"vj_hlr_blood_red"}
ENT.CustomBlood_Decal = {"VJ_HLR1_Blood_Red"} -- Decals to spawn when it's damaged
ENT.HasBloodPool = false -- Does it have a blood pool?
ENT.VJ_NPC_Class = {"CLASS_CRACKLIFE_SCHIZO"} -- NPCs with the same class with be allied to each other

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDistance = 30 -- How close an enemy has to be to trigger a melee attack | false = Let the base auto calculate on initialize based on the NPC's collision bounds
ENT.MeleeAttackDamageDistance = 50 -- How far does the damage go | false = Let the base auto calculate on initialize based on the NPC's collision bounds
ENT.MeleeAttackDamage = 20

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.AnimTbl_RangeAttack = ACT_RANGE_ATTACK1 -- Range Attack Animations
ENT.DisableDefaultRangeAttackCode = true

ENT.NextRangeAttackTime = 2 -- How much time until it can use a range attack?
ENT.RangeDistance = 512 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 100 -- How close does it have to be until it uses melee?

ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
//ENT.DeathAnimationTime = 0.8 -- Time until the SNPC spawns its corpse and gets removed
	-- ====== Flinching Variables ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = ACT_SMALL_FLINCH -- If it uses normal based animation, use this
ENT.AnimTbl_Death = ACT_DIESIMPLE

ENT.HasExtraMeleeAttackSounds = true
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"vj_hlr/crack_fx/npc_step1.wav","vj_hlr/crack_fx/npc_step2.wav","vj_hlr/crack_fx/npc_step3.wav","vj_hlr/crack_fx/npc_step4.wav"}
ENT.SoundTbl_Alert = {"vj_hlr/crack10_npc/ciaman/cia_alert1.wav", "vj_hlr/crack10_npc/ciaman/cia_alert2.wav", "vj_hlr/crack10_npc/ciaman/cia_alert3.wav"}
ENT.SoundTbl_Death = {"vj_hlr/crack10_npc/generic/death.wav"}
ENT.SoundTbl_BeforeRangeAttack = {"vj_hlr/crack10_npc/ciaman/cia_attack1.wav", "vj_hlr/crack10_npc/ciaman/cia_attack2.wav", "vj_hlr/crack10_npc/ciaman/cia_attack3.wav"}

ENT.GeneralSoundPitch1 = 100
-- Custom
ENT.SCI_NextMouthMove = 0
ENT.SCI_NextMouthDistance = 0
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self._dynamicLight = ents.Create("light_dynamic")
	self._dynamicLight:SetKeyValue("brightness", "4")
	self._dynamicLight:SetKeyValue("distance", "150")
	self._dynamicLight:SetKeyValue("style", 5)
	self._dynamicLight:SetLocalPos(self:GetPos() + self:GetUp() * 50 + self:GetForward() * 50)
	self._dynamicLight:SetLocalAngles(self:GetAngles())
	self._dynamicLight:Fire("Color", "0 255 0")
	self._dynamicLight:SetParent(self)
	self._dynamicLight:Spawn()
	self._dynamicLight:Activate()
	self._dynamicLight:SetParent(self)
	self._dynamicLight:Fire("TurnOn")
	self:DeleteOnRemove(self._dynamicLight)
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
    elseif key == "shoot" then
        for i = 0, 0.5, 0.1 do
			timer.Simple(i,function()
				if self:IsValid() then
					self:RangeAttackCode()
				end
			end)
		end
        VJ_EmitSound(self, "vj_hlr/gsrc/fx/beamstart3.wav", 85, 100)
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
function ENT:CustomRangeAttackCode()
	if self.Dead then return end
	local startpos = self:GetAttachment(self:LookupAttachment("rhand")).Pos + Vector(0,0,100)
	local tr = util.TraceLine({
		start = startpos,
		endpos = self:GetEnemy():GetPos() + self:GetEnemy():OBBCenter(),
		filter = self
	})
	local hitpos = tr.HitPos
	
	local elec = EffectData()
	elec:SetStart(startpos)
	elec:SetOrigin(hitpos)
	elec:SetEntity(self)
	elec:SetAttachment(2)
	util.Effect("VJ_HLR_CIALASER", elec)

	local att = self:GetAttachment(self:LookupAttachment("rhand"))
	local muzzleFlash = ents.Create("env_sprite")
	muzzleFlash:SetKeyValue("model", "vj_hl/sprites/animglow01.vmt")
	muzzleFlash:SetKeyValue("scale", tostring(math.Rand(0.5, 0.65)))
	muzzleFlash:SetKeyValue("rendermode", "3")
	muzzleFlash:SetKeyValue("renderfx", "14")
	muzzleFlash:SetKeyValue("renderamt", "255")
	muzzleFlash:SetKeyValue("rendercolor", "255 255 0")
	muzzleFlash:SetKeyValue("spawnflags", "0")
	muzzleFlash:SetParent(self)
	muzzleFlash:SetOwner(self)
	muzzleFlash:SetPos(att.Pos)
	muzzleFlash:SetAngles(Angle(math.random(-100, 100), math.random(-100, 100), math.random(-100, 100)))
	muzzleFlash:Spawn()
	muzzleFlash:Fire("Kill","",0.15)
	self:DeleteOnRemove(muzzleFlash)

	VJ.ApplyRadiusDamage(self, self, hitpos, 30, 4, DMG_ENERGYBEAM, true, false, {Force=20})

    local slowDuration = 0.7 -- seconds
    local slowAmount = 0.5 -- 50% speed

    for _, ent in ipairs(ents.FindInSphere(hitpos, 30)) do
		if ent._slowed then return end
        if ent:IsPlayer() && !ent._slowed then
			ent._slowed = true

            ent._originalRunSpeed = ent:GetRunSpeed()
            ent._originalWalkSpeed = ent:GetWalkSpeed()

            if ent:IsPlayer() then
                ent:SetRunSpeed(ent:GetRunSpeed() * slowAmount)
                ent:SetWalkSpeed(ent:GetWalkSpeed() * slowAmount)
            end

            -- restore
            timer.Simple(slowDuration, function()
                if IsValid(ent) then
                    if ent:IsPlayer() then
                        if ent._originalRunSpeed then ent:SetRunSpeed(ent._originalRunSpeed) end
                        if ent._originalWalkSpeed then ent:SetWalkSpeed(ent._originalWalkSpeed) end
                    end
					ent._slowed = false
                end
            end)
        end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnFlinch_BeforeFlinch(dmginfo, hitgroup)
	if dmginfo:GetDamage() > 30 then
		self.AnimTbl_Flinch = ACT_BIG_FLINCH
	else
		self.AnimTbl_Flinch = ACT_SMALL_FLINCH
	end
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
	self._dynamicLight:Fire("TurnOff")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomGibOnDeathSounds(dmginfo, hitgroup)
	VJ_EmitSound(self,"vj_hlr/crack_fx/bodysplat.wav", 90, math.random(100,100))
	VJ_EmitSound(self, "vj_base/gib/splat.wav", 90, 100)
	return false
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