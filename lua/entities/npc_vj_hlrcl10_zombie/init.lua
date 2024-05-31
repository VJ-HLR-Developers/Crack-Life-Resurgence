include("entities/npc_vj_hlr1_zombie/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2010-2024 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_hlr/cracklife10/zombie.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.CustomBlood_Particle = {"vj_hlr_blood_yellow"}
ENT.CustomBlood_Decal = {"VJ_HLR_Blood_Yellow"} -- Decals to spawn when it's damaged
ENT.VJ_NPC_Class = {"CLASS_CRACKLIFE"} -- NPCs with the same class with be allied to each other
ENT.StartHealth = 200

ENT.HasRangeAttack = true
ENT.RangeAttackEntityToSpawn = nil
ENT.NextRangeAttackTime = 5
ENT.DisableDefaultRangeAttackCode = true

ENT.RangeDistance = 1024 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 0 -- How close does it have to be until it uses melee?

ENT.SoundTbl_FootStep = {"vj_hlr/crack_fx/npc_step1.wav","vj_hlr/crack_fx/npc_step2.wav","vj_hlr/crack_fx/npc_step3.wav","vj_hlr/crack_fx/npc_step4.wav"}
ENT.SoundTbl_Idle = {"vj_hlr/crack10_npc/zombie/zo_idle1.wav","vj_hlr/crack10_npc/zombie/zo_idle2.wav","vj_hlr/crack10_npc/zombie/zo_idle3.wav","vj_hlr/crack10_npc/zombie/zo_idle4.wav"}
ENT.SoundTbl_Alert = {"vj_hlr/crack10_npc/zombie/zo_alert10.wav","vj_hlr/crack10_npc/zombie/zo_alert20.wav","vj_hlr/crack10_npc/zombie/zo_alert30.wav","vj_hlr/crack10_npc/zombie/zo_alert40.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"vj_hlr/crack10_npc/zombie/zo_attack1.wav","vj_hlr/crack10_npc/zombie/zo_attack2.wav","vj_hlr/crack10_npc/zombie/zo_attack3.wav"}
ENT.SoundTbl_Pain = {"vj_hlr/crack10_npc/zombie/zo_pain1.wav","vj_hlr/crack10_npc/zombie/zo_pain2.wav","vj_hlr/crack10_npc/zombie/zo_pain3.wav"}
ENT.SoundTbl_Death = {"vj_hlr/crack10_npc/zombie/zo_death1.wav","vj_hlr/crack10_npc/zombie/zo_death2.wav","vj_hlr/crack10_npc/zombie/zo_death3.wav"}

ENT.CanUseHD = false
ENT.DrawnShotgun = false
ENT.DroppedHat = false

---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnSchedule()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	//print(key)
	if key == "step" then
		self:FootStepSoundCode()
		self:SetBodygroup(1,0)
		self.DrawnShotgun = false
	elseif key == "melee" then
		self:MeleeAttackCode()
		self:SetBodygroup(1,0)
		self.DrawnShotgun = false
	elseif key == "body" then
		VJ_EmitSound(self, "vj_hlr/crack_fx/bodydrop.wav", 85, 100)
	elseif key == "draw" then
		self.DrawnShotgun = true
		self:SetBodygroup(1,1)
	elseif key == "shoot" then
		self:RangeAttackCode()
		VJ_EmitSound(self, "vj_hlr/crack10_npc/zombie/sshotgun_shoot.wav", 85, 100)
		VJ_EmitSound(self, "vj_hlr/crack10_npc/zombie/sshotgun_distant.wav", 140, 100, 100, 1)
	elseif key == "holster" then
		self.DrawnShotgun = false
		self:SetBodygroup(1,0)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()

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
			Num = 18
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
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
	self.HasDeathSounds = false
	if self.HasGibDeathParticles == true then
		local bloodeffect = EffectData()
		bloodeffect:SetOrigin(self:GetPos() +self:OBBCenter())
		bloodeffect:SetColor(VJ_Color2Byte(Color(255,221,35)))
		bloodeffect:SetScale(120)
		util.Effect("VJ_Blood1",bloodeffect)
		
		local bloodspray = EffectData()
		bloodspray:SetOrigin(self:GetPos() +self:OBBCenter())
		bloodspray:SetScale(8)
		bloodspray:SetFlags(3)
		bloodspray:SetColor(1)
		util.Effect("bloodspray",bloodspray)
		util.Effect("bloodspray",bloodspray)
		
		local effectdata = EffectData()
		effectdata:SetOrigin(self:GetPos() +self:OBBCenter())
		effectdata:SetScale(1)
		util.Effect("StriderBlood",effectdata)
		util.Effect("StriderBlood",effectdata)
	end
	
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib1.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib2.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,20))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib3.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,30))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib4.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,35))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib5.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,50))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib6.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,55))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib7.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib8.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,45))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib9.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,25))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib10.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,15))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/zombiegib.mdl",{BloodType="Red",BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,15))})

	return true -- Return to true if it gibbed!
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomGibOnDeathSounds(dmginfo,hitgroup)
	VJ_EmitSound(self,"vj_hlr/crack_fx/bodysplat.wav", 90, math.random(100,100))
	VJ_EmitSound(self, "vj_gib/default_gib_splat.wav", 90, math.random(100,100))
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialKilled(dmginfo, hitgroup)
	self.DrawnShotgun = false
	self:SetBodygroup(1,0)
end
/*-----------------------------------------------
	*** Copyright (c) 2010-2024 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/