AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2010-2025 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_hlr/cracklife/vlad_tank_bdy.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.DeathCorpseModel = {"models/vj_hlr/hl1/tank_body_destroyed.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 5000
ENT.VJC_Data = {
    ThirdP_Offset = Vector(-20, 0, 40), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "static _prop", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(-17, 0, 90), -- The offset for the controller when the camera is in first person
	FirstP_ShrinkBone = false, -- Should the bone shrink? Useful if the bone is obscuring the player's view
}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_CRACKLIFE_SOVIET"} -- NPCs with the same class with be allied to each other\

ENT.HasSoundTrack = true
ENT.SoundTbl_SoundTrack = {"vj_hlr/crack_npc/vlad/vladboss.mp3"}
ENT.SoundTbl_Breath = {"vj_hlr/crack_npc/vlad/engine.wav"}
ENT.SoundTbl_Idle = {"vj_hlr/gsrc/npc/hgrunt/gr_idle1.wav","vj_hlr/gsrc/npc/hgrunt/gr_idle2.wav","vj_hlr/gsrc/npc/hgrunt/gr_idle3.wav"}
ENT.SoundTbl_CombatIdle = {"vj_hlr/crack_npc/hgrunt/taunt1.wav","vj_hlr/crack_npc/hgrunt/taunt2.wav","vj_hlr/crack_npc/hgrunt/taunt3.wav","vj_hlr/crack_npc/hgrunt/taunt4.wav","vj_hlr/crack_npc/hgrunt/taunt5.wav","vj_hlr/crack_npc/hgrunt/taunt6.wav"}
ENT.SoundTbl_OnReceiveOrder = {"vj_hlr/crack_npc/hgrunt/charge3.wav","vj_hlr/crack_npc/hgrunt/charge4.wav"}
ENT.SoundTbl_Investigate = {"vj_hlr/gsrc/npc/hgrunt/gr_investigate.wav"}
ENT.SoundTbl_Alert = {"vj_hlr/crack_npc/hgrunt/alien2.wav","vj_hlr/crack_npc/hgrunt/alien3.wav"}
ENT.SoundTbl_CallForHelp = {"vj_hlr/crack_npc/hgrunt/cover2.wav"}
ENT.SoundTbl_OnGrenadeSight = {"vj_hlr/crack_npc/hgrunt/cover1.wav","vj_hlr/crack_npc/hgrunt/cover2.wav","vj_hlr/crack_npc/hgrunt/cover3.wav"}
ENT.SoundTbl_Death = {"vj_hlr/crack_fx/explode3.wav","vj_hlr/crack_fx/explode4.wav","vj_hlr/crack_fx/explode5.wav"}

-- Tank Base
ENT.Tank_SoundTbl_DrivingEngine = {"vj_hlr/gsrc/npc/tanks/tankdrive.wav"}
ENT.Tank_SoundTbl_Track = {"vj_hlr/gsrc/npc/tanks/tanktrack.wav"}

ENT.Tank_GunnerENT = "npc_vj_hlrcl_vlad_gun"
ENT.Tank_AngleDiffuseNumber = 0
ENT.Tank_CollisionBoundSize = 110
ENT.Tank_CollisionBoundUp = 245
ENT.Tank_DeathSoldierModels = {"models/vj_hlr/cracklife/hgrunt.mdl"} -- The corpses it will spawn on death (Example: A soldier) | false = Don't spawn anything
ENT.Tank_DeathDecal = {"VJ_HLR_Scorch"} -- The decal that it places on the ground when it dies


ENT.Tank_DrivingSpeed = 200 -- How fast the tank drives
ENT.Tank_TurningSpeed = 1

util.AddNetworkString("vj_hlr1_m1a1abrams_moveeffects")

ENT.Tank_SeeClose = 1500 -- If the enemy is closer than this number, than move by either running over them or moving away for the gunner to fire
ENT.Tank_DistRanOver = 1000 -- If the enemy is within self.Tank_SeeClose & this number & not high up, then run over them!

-- Custom
ENT.Bradley_DmgForce = 0
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Tank_GunnerSpawnPosition()
	return self:GetPos() - Vector(0,0,10)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:StartMoveEffects()
	net.Start("vj_hlr1_m1a1abrams_moveeffects")
	net.WriteEntity(self)
	net.Broadcast()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomInitialize_CustomTank()
	if GetConVar("vj_hlrcl_allyspawn_vlad"):GetInt() == 1 then
		timer.Create("vlad_spawnracists"..self:EntIndex(), 10, 0, function() self:F_SpawnAlly() end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GetNearDeathSparkPositions()
	local randpos = math.random(1,5)
	if randpos == 1 then
		self.Spark1:SetLocalPos(self:GetPos() + self:GetRight()*15 + self:GetForward()*-16 + self:GetUp()*100)
	elseif randpos == 2 then
		self.Spark1:SetLocalPos(self:GetPos() + self:GetRight()*42 + self:GetForward()*123 + self:GetUp()*50)
	elseif randpos == 3 then
		self.Spark1:SetLocalPos(self:GetPos() + self:GetRight()*-42 + self:GetForward()*123 + self:GetUp()*50)
	elseif randpos == 4 then
		self.Spark1:SetLocalPos(self:GetPos() + self:GetRight()*105 + self:GetForward()*-40 + self:GetUp()*50)
	elseif randpos == 5 then
		self.Spark1:SetLocalPos(self:GetPos() + self:GetRight()*-105 + self:GetForward()*-40 + self:GetUp()*50)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local expPos = Vector(0, 0, 150)
--
function ENT:Tank_OnInitialDeath(dmginfo, hitgroup)
	self.Bradley_DmgForce = dmginfo:GetDamageForce()
	for i=0,1,0.5 do
		timer.Simple(i, function()
			if IsValid(self) then
				VJ_EmitSound(self, self.SoundTbl_Death, 100)
				VJ_EmitSound(self, "vj_hlr/hl1_weapon/explosion/debris"..math.random(1,3)..".wav", 100)
				util.BlastDamage(self, self, self:GetPos(), 200, 40)
				util.ScreenShake(self:GetPos(), 100, 200, 1, 2500)
				
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
				spr:SetKeyValue("framerate","15.0")
				spr:SetKeyValue("spawnflags","0")
				spr:SetKeyValue("scale","4")
				spr:SetPos(self:GetPos() + expPos)
				spr:Spawn()
				spr:Fire("Kill","",0.9)
				timer.Simple(0.9,function() if IsValid(spr) then spr:Remove() end end)
			end
		end)
	end
	
	timer.Simple(1.5, function()
		if IsValid(self) then
			VJ_EmitSound(self, self.SoundTbl_Death, 100)
			util.BlastDamage(self, self, self:GetPos(), 200, 40)
			util.ScreenShake(self:GetPos(), 100, 200, 1, 2500)
			
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
			spr:SetKeyValue("framerate","15.0")
			spr:SetKeyValue("spawnflags","0")
			spr:SetKeyValue("scale","4")
			spr:SetPos(self:GetPos() + expPos)
			spr:Spawn()
			spr:Fire("Kill","",0.9)
			timer.Simple(0.9,function() if IsValid(spr) then spr:Remove() end end)
		end
	end)
	return false
end
local vec = Vector(0, 0, 0)
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeImmuneChecks(dmginfo, hitgroup)
	if dmginfo:GetDamagePosition() != vec then
		local rico = EffectData()
		rico:SetOrigin(dmginfo:GetDamagePosition())
		rico:SetScale(5) -- Size
		rico:SetMagnitude(math.random(1, 2)) -- Effect type | 1 = Animated | 2 = Basic
		util.Effect("VJ_HLR_Rico", rico)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Tank_CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, corpseEnt)
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p1_g.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,80)),CollideSound={"vj_hlr/crack_fx/metal1.wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p2_g.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,81)),CollideSound={"vj_hlr/crack_fx/metal1.wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p3_g.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,82)),CollideSound={"vj_hlr/crack_fx/metal1.wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p4_g.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,83)),CollideSound={"vj_hlr/crack_fx/metal1.wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p5_g.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,84)),CollideSound={"vj_hlr/crack_fx/metal1.wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p6_g.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,85)),CollideSound={"vj_hlr/crack_fx/metal1.wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p7_g.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,86)),CollideSound={"vj_hlr/crack_fx/metal1.wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p8_g.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,87)),CollideSound={"vj_hlr/crack_fx/metal1.wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p9_g.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,88)),CollideSound={"vj_hlr/crack_fx/metal1.wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p10_g.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,89)),CollideSound={"vj_hlr/crack_fx/metal1.wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p11_g.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,90)),CollideSound={"vj_hlr/crack_fx/metal1.wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p1_g.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,91)),CollideSound={"vj_hlr/crack_fx/metal1.wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p2_g.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,92)),CollideSound={"vj_hlr/crack_fx/metal1.wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p3_g.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,93)),CollideSound={"vj_hlr/crack_fx/metal1.wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p4_g.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,94)),CollideSound={"vj_hlr/crack_fx/metal1.wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p5_g.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,95)),CollideSound={"vj_hlr/crack_fx/metal1.wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p6_g.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,96)),CollideSound={"vj_hlr/crack_fx/metal1.wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p7_g.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,97)),CollideSound={"vj_hlr/crack_fx/metal1.wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p8_g.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,98)),CollideSound={"vj_hlr/crack_fx/metal1.wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p9_g.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,99)),CollideSound={"vj_hlr/crack_fx/metal1.wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p10_g.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,80)),CollideSound={"vj_hlr/crack_fx/metal1.wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p11_g.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,80)),CollideSound={"vj_hlr/crack_fx/metal1.wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/rgib_cog1.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,1,80)),CollideSound={"vj_hlr/crack_fx/metal1.wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/rgib_cog2.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,2,80)),CollideSound={"vj_hlr/crack_fx/metal1.wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/rgib_rib.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,3,80)),CollideSound={"vj_hlr/crack_fx/metal1.wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/rgib_screw.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,4,80)),CollideSound={"vj_hlr/crack_fx/metal1.wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/rgib_screw.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,5,80)),CollideSound={"vj_hlr/crack_fx/metal1.wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/rgib_screw.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,6,80)),CollideSound={"vj_hlr/crack_fx/metal1.wav"}})
	util.BlastDamage(self, self, self:GetPos() + self:GetUp()*80, 200, 10)
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Tank_CustomOnDeath_AfterDeathSoldierSpawned(dmginfo, hitgroup, soldierCorpse)
	soldierCorpse:SetSkin(math.random(0, 1))
	soldierCorpse:SetBodygroup(2, 2)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Tank_CustomOnDeath_AfterCorpseSpawned_Effects(dmginfo, hitgroup, corpseEnt)
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
	spr:SetKeyValue("framerate","15.0")
	spr:SetKeyValue("spawnflags","0")
	spr:SetKeyValue("scale","4")
	spr:SetPos(self:GetPos() + expPos)
	spr:Spawn()
	spr:Fire("Kill","",0.9)
	timer.Simple(0.9,function() if IsValid(spr) then spr:Remove() end end)
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:F_CreateAlly()
	local type = "npc_vj_hlrcl_sgrunt"
	local tr = util.TraceLine({
		start = self:GetPos(),
		endpos = self:GetPos() + self:GetForward() * math.Rand(-700, -400) + self:GetRight() * math.Rand(-700, 700) + self:GetUp() * 40,
		filter = {self, type},
		mask = MASK_ALL,
	})
	local spawnpos = tr.HitPos + tr.HitNormal*300
	local ally = ents.Create(type)
	ally:SetPos(spawnpos)
	ally:SetAngles(Angle(0, 0, 0))
	//print(ally:GetAngles())
	ally:Spawn()
	ally:Activate()
	ally.VJ_NPC_Class = self.VJ_NPC_Class
	//ally:SetMaxHealth(ally:GetHealth() + 100)
	//ally:SetHealth(ally:GetHealth() + 100)
	
	local effectTeleport = VJ.HLR1_Effect_Portal(spawnpos + Vector(0,0,20))
	effectTeleport:Fire("Kill","",1)
	
	return ally
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:F_SpawnAlly()
	-- Can have a total of 3, only 1 can be spawned at a time with a delay until another one is spawned
	if !IsValid(self.SovietAlly1) then
		self.SovietAlly1 = self:F_CreateAlly()
		return 15
	elseif !IsValid(self.SovietAlly2) then
		self.SovietAlly2 = self:F_CreateAlly()
		return 15
	elseif !IsValid(self.SovietAlly3) then
		self.SovietAlly3 = self:F_CreateAlly()
		return 15
	end
	return 8
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	VJ_STOPSOUND(self.CurrentTankMovingSound)
	VJ_STOPSOUND(self.CurrentTankTrackSound)
	if IsValid(self.Gunner) then
		self.Gunner:Remove()
	end
	timer.Remove("vlad_spawnracists"..self:EntIndex())
	if !self.Dead then
		if IsValid(self.SovietAlly1) then self.SovietAlly1:Remove() end
		if IsValid(self.SovietAlly2) then self.SovietAlly2:Remove() end
		if IsValid(self.SovietAlly3) then self.SovietAlly3:Remove() end
	end
end