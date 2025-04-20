AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2010-2025 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_hlr/cracklife10/forklift.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 70
ENT.VJC_Data = {
    ThirdP_Offset = Vector(-5, 0, -15), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "Bip02 Head", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(5, 0, 5), -- The offset for the controller when the camera is in first person
}
ENT.Bleeds = false
ENT.BloodColor = ""
ENT.HasBloodParticle = false
ENT.HasBloodDecal = false
ENT.HasBloodPool = false -- Does it have a blood pool?
//ENT.VJ_NPC_Class = {"CLASS_CRACKLIFE_FL"} -- NPCs with the same class with be allied to each other
ENT.HasAllies = false

ENT.TurningSpeed = 10

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDistance = 90 -- How close an enemy has to be to trigger a melee attack | false = Let the base auto calculate on initialize based on the NPC's collision bounds
ENT.MeleeAttackDamageDistance = 120 -- How far does the damage go | false = Let the base auto calculate on initialize based on the NPC's collision bounds
ENT.MeleeAttackDamage = 5
ENT.HasMeleeAttackKnockBack = true

ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events
ENT.HasDeathRagdoll = false
ENT.GibOnDeathDamagesTable = {"All"}
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"vj_hlr/crack10_npc/generic/forklift.wav"}

ENT.GeneralSoundPitch1 = 100

-- Custom
ENT.SCI_NextMouthMove = 0
ENT.SCI_NextMouthDistance = 0
ENT.SpawnHat = true
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(80,28,117),Vector(-80,-28,0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	//print(key)
	if key == "drive" then
		self:FootStepSoundCode()
	elseif key == "lift" then
        self:MeleeAttackCode()
        VJ_EmitSound(self, "vj_hlr/crack10_fx/doormove4.wav", 100, 100)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MeleeAttackKnockbackVelocity(hitEnt)
	if hitEnt:IsPlayer() then
		return self:GetForward() * -25 + self:GetUp()*300
	else
		return self:GetUp()*300
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local gibsCollideSd = {"vj_hlr/gsrc/fx/metal1.wav","vj_hlr/gsrc/fx/metal2.wav","vj_hlr/gsrc/fx/metal3.wav","vj_hlr/gsrc/fx/metal4.wav","vj_hlr/gsrc/fx/metal5.wav"}
local computerGibs = {
    "models/vj_hlr/gibs/computergibs_comp1.mdl",
    "models/vj_hlr/gibs/computergibs_comp2.mdl",
    "models/vj_hlr/gibs/computergibs_comp3.mdl",
    "models/vj_hlr/gibs/computergibs_comp5.mdl",
    "models/vj_hlr/gibs/computergibs_comp6.mdl",
    "models/vj_hlr/gibs/computergibs_comp7.mdl",
    "models/vj_hlr/gibs/computergibs_comp8.mdl",
    "models/vj_hlr/gibs/computergibs_comp9.mdl",
    "models/vj_hlr/gibs/computergibs_comp10.mdl",
    "models/vj_hlr/gibs/computergibs_comp11.mdl",
    "models/vj_hlr/gibs/computergibs_comp12.mdl",
    "models/vj_hlr/gibs/computergibs_comp13.mdl",
}
function ENT:HandleGibOnDeath(dmginfo, hitgroup)
	self.HasDeathSounds = false
	if self.HasGibDeathParticles == true then
        local spr = ents.Create("env_sprite")
			spr:SetKeyValue("model","vj_hl/sprites/zerogxplode.vmt")
			spr:SetKeyValue("GlowProxySize","2.0")
			spr:SetKeyValue("HDRColorScale","1.0")
			spr:SetKeyValue("renderfx","14")
			spr:SetKeyValue("rendermode","5")
			spr:SetKeyValue("renderamt","255")
			spr:SetKeyValue("disablereceiveshadows","0")
			spr:SetKeyValue("mindxlevel","0")
			spr:SetKeyValue("maxdxlevel","0")
			spr:SetKeyValue("framerate","20.0")
			spr:SetKeyValue("spawnflags","0")
			spr:SetKeyValue("scale","2")
			spr:SetPos(self:GetPos() + self:GetUp()*60)
			spr:Spawn()
			spr:Fire("Kill","",0.7)
			timer.Simple(0.7, function() if IsValid(spr) then spr:Remove() end end)
	end
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh1.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh2.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh3.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh4.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_b_bone.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,50))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_b_gib.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_guts.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_hmeat.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,45))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_lung.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,45))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_skull.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,60))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_legbone.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,15))})
	for _ = 1, 30 do
			local gib = ents.Create("obj_vj_gib")
			gib:SetModel(VJ_PICK(computerGibs))
			gib:SetPos(self:GetPos() + Vector(math.random(-35, 35), math.random(-35, 35), math.random(10, 100)))
			gib:SetAngles(Angle(math.Rand(-180, 180), math.Rand(-180, 180), math.Rand(-180, 180)))
			gib.Collide_Decal = ""
			gib.CollideSound = gibsCollideSd
			gib:Spawn()
			gib:Activate()
			local myPhys = gib:GetPhysicsObject()
			if IsValid(myPhys) then
				myPhys:AddVelocity(Vector(math.Rand(-300, 300), math.Rand(-300, 300), math.Rand(150, 250)))
				myPhys:AddAngleVelocity(Vector(math.Rand(-200, 200), math.Rand(-200, 200), math.Rand(-200, 200)))
			end
			if GetConVar("vj_npc_gib_fade"):GetInt() == 1 then
				timer.Simple(GetConVar("vj_npc_gib_fadetime"):GetInt(), function() SafeRemoveEntity(gib) end)
			end
	end
	return true -- Return to true if it gibbed!
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomGibOnDeathSounds(dmginfo, hitgroup)
	VJ_EmitSound(self, "vj_hlr/crack10_fx/bustmetal"..math.random(1,2)..".wav", 100, 100)
    VJ_EmitSound(self,"vj_hlr/crack_fx/bodysplat.wav", 90, math.random(100,100))
	VJ_EmitSound(self, "vj_hlr/gsrc/npc/rgrunt/rb_gib.wav", 90, 85)
	return false
end
/*-----------------------------------------------
	*** Copyright (c) 2010-2025 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/