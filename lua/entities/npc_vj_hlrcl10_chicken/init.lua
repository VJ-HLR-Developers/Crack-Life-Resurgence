AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2010-2025 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_hlr/cracklife10/chicken.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.CustomBlood_Particle = {"vj_hlr_blood_red"}
ENT.CustomBlood_Decal = {"VJ_HLR1_Blood_Red"}
ENT.VJ_NPC_Class = {"CLASS_CRACKLIFE_POLLO"} -- NPCs with the same class with be allied to each other
ENT.StartHealth = 40

ENT.ControllerParams = {
    ThirdP_Offset = Vector(-5, 0, -15), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "Head", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(0, 0, 5), -- The offset for the controller when the camera is in first person
}

ENT.HasRangeAttack = true
ENT.RangeAttackEntityToSpawn = nil
ENT.NextRangeAttackTime = 1
ENT.AnimTbl_RangeAttack = ACT_RANGE_ATTACK1 -- Range Attack Animations
ENT.DisableDefaultRangeAttackCode = true

ENT.RangeDistance = 650
ENT.RangeToMeleeDistance = 0.1

ENT.HasMeleeAttack = false

ENT.HasDeathRagdoll = false
ENT.GibOnDeathDamagesTable = {"All"}

ENT.SoundTbl_FootStep = {"vj_hlr/crack_fx/npc_step1.wav","vj_hlr/crack_fx/npc_step2.wav","vj_hlr/crack_fx/npc_step3.wav","vj_hlr/crack_fx/npc_step4.wav"}
ENT.SoundTbl_Alert = {
    "vj_hlr/crack10_npc/chicken/chicken_alert1.wav",
    "vj_hlr/crack10_npc/chicken/chicken_alert2.wav",
    "vj_hlr/crack10_npc/chicken/chicken_alert3.wav",
    "vj_hlr/crack10_npc/chicken/chicken_alert4.wav",
    "vj_hlr/crack10_npc/chicken/chicken_alert5.wav",
    "vj_hlr/crack10_npc/chicken/chicken_alert6.wav",
}
ENT.SoundTbl_Death = {"vj_hlr/crack10_npc/chicken/killChicken.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Init()
	self:SetCollisionBounds(Vector(10, 10, 20), Vector(-10, -10, 0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:TranslateActivity(act)
	if act == ACT_RUN then
		return ACT_WALK
	end
	return self.BaseClass.TranslateActivity(self, act)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	//print(key)
	if key == "step" then
		self:FootStepSoundCode()
	elseif key == "shoot" then
		self:RangeAttackCode()
		VJ_EmitSound(self, "vj_hlr/gsrc/wep/shotgun/sbarrel1.wav", 85, 100)
		VJ_EmitSound(self, "vj_hlr/gsrc/wep/shotgun/sbarrel1_distant2.wav", 140, 100, 100, 1)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomRangeAttackCode()
	local att = self:GetAttachment(1)
	local ene = self:GetEnemy()
	local sdir = (ene:GetPos() + ene:OBBCenter() - att.Pos):Angle():Forward()

	if IsValid(self) then
		self:FireBullets({
			Attacker = self,
			Dir = sdir,
			Spread = Vector(0.1,0.1,0),
			TracerName = "VJ_HLR_Tracer",
			AmmoType = "Shotgun",
			Distance = 2048,
			Src = att.Pos,
			HullSize = 1,
			Damage = 4,
			Force = 5,
			Num = 7
		})
	end
		local muz = ents.Create("env_sprite")
		muz:SetKeyValue("model","vj_hl/sprites/muzzleflash2.vmt")
		muz:SetKeyValue("scale",""..math.Rand(0.3, 0.5))
		muz:SetKeyValue("GlowProxySize","2.0") -- Size of the glow to be rendered for visibility testing.
		muz:SetKeyValue("HDRColorScale","1.0")
		muz:SetKeyValue("renderfx","14")
		muz:SetKeyValue("rendermode","3") -- Set the render mode to "3" (Glow)
		muz:SetKeyValue("renderamt","255") -- Transparency
		muz:SetKeyValue("disablereceiveshadows","0") -- Disable receiving shadows
		muz:SetKeyValue("framerate","10.0") -- Rate at which the sprite should animate, if at all.
		muz:SetKeyValue("spawnflags","0")
		muz:SetParent(self)
		muz:Fire("SetParentAttachment","muzzle")
		muz:SetAngles(Angle(math.random(-100, 100), math.random(-100, 100), math.random(-100, 100)))
		muz:Spawn()
		muz:Activate()
		muz:Fire("Kill","",0.08)

		local flash = ents.Create("light_dynamic")
		flash:SetKeyValue("brightness", 8)
		flash:SetKeyValue("distance", 300)
		flash:SetLocalPos(att.Pos)
		flash:SetLocalAngles(self:GetAngles())
		flash:Fire("Color","255 60 9 255")
		flash:Spawn()
		flash:Activate()
		flash:Fire("TurnOn", "", 0)
		flash:Fire("Kill", "", 0.07)
		self:DeleteOnRemove(flash)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:HandleGibOnDeath(dmginfo,hitgroup)
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

	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh1.mdl",{CollisionDecal="VJ_HLR1_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,10))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh2.mdl",{CollisionDecal="VJ_HLR1_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,5))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh3.mdl",{CollisionDecal="VJ_HLR1_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,10))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh4.mdl",{CollisionDecal="VJ_HLR1_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,12))})

	self:PlaySoundSystem("Gib", "vj_base/gib/splat.wav")
	self:PlaySoundSystem("Gib", "vj_hlr/crack_fx/bodysplat.wav")
	return true, {AllowSound = false}
end
/*-----------------------------------------------
	*** Copyright (c) 2010-2025 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/