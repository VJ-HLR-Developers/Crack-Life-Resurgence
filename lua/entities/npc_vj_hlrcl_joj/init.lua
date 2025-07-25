AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2010-2025 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
local combatDistance = 3000 -- When closer then this, it will stop chasing and start firing

ENT.Model = {"models/vj_hlr/cracklife/ufo.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.VJ_IsHugeMonster = true
ENT.StartHealth = 3000 -- The starting health of the NPC
ENT.HullType = HULL_LARGE
ENT.SightAngle = 180 -- The sight angle | Example: 180 would make the it see all around it | Measured in degrees and then converted to radians
ENT.TurningSpeed = 20 -- How fast it can turn
ENT.EntitiesToNoCollide = {"npc_vj_hlrcl_agrunt","npc_vj_hlrcl_snark","npc_vj_hlrcl_snarknest"}
	-- ====== Movement Variables ====== --
ENT.MovementType = VJ_MOVETYPE_AERIAL -- How does the SNPC move?
ENT.Aerial_FlyingSpeed_Alerted = 600 -- The speed it should fly with, when it's chasing an enemy, moving away quickly, etc. | Basically running compared to ground SNPCs
ENT.Aerial_FlyingSpeed_Calm = ENT.Aerial_FlyingSpeed_Alerted -- The speed it should fly with, when it's wandering, moving slowly, etc. | Basically walking compared to ground SNPCs
ENT.Aerial_AnimTbl_Calm = {nil} -- Animations it plays when it's wandering around while idle
ENT.Aerial_AnimTbl_Alerted = {nil} -- Animations it plays when it's moving while alerted
ENT.AA_GroundLimit = 500 -- If the NPC's distance from itself to the ground is less than this, it will attempt to move up
ENT.AA_MinWanderDist = 200 -- Minimum distance that the NPC should go to when wandering
ENT.AA_MoveAccelerate = 8 -- The NPC will gradually speed up to the max movement speed as it moves towards its destination | Calculation = FrameTime * x
ENT.AA_MoveDecelerate = 4 -- The NPC will slow down as it approaches its destination | Calculation = MaxSpeed / x
ENT.ControllerParams = {
	ThirdP_Offset = Vector(-400, 0, -15), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "Bone14", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(-50, 0, -40), -- The offset for the controller when the camera is in first person
	FirstP_ShrinkBone = false, -- Should the bone shrink? Useful if the bone is obscuring the player's view
}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_CRACKLIFE"} -- NPCs with the same class with be allied to each other
ENT.FindEnemy_UseSphere = true -- Should the SNPC be able to see all around him? (360) | Objects and walls can still block its sight!
ENT.AnimTbl_IdleStand = {ACT_IDLE} -- The idle animation table when AI is enabled | DEFAULT: {ACT_IDLE}
ENT.PoseParameterLooking_InvertYaw = true -- Inverts the yaw pose parameters (Y)
ENT.ConstantlyFaceEnemy = true -- Should it face the enemy constantly?
ENT.NoChaseAfterCertainRange = true -- Should the SNPC not be able to chase when it"s between number x and y?
ENT.NoChaseAfterCertainRange_FarDistance = combatDistance -- How far until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_CloseDistance = 0 -- How near until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.Bleeds = false
ENT.Immune_AcidPoisonRadiation = true -- Immune to Acid, Poison and Radiation
ENT.ImmuneDamagesTable = {DMG_PHYSGUN}
ENT.BringFriendsOnDeath = false -- Should the SNPC's friends come to its position before it dies?
ENT.HasMeleeAttack = false -- Should the SNPC have a melee attack?

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.DisableDefaultRangeAttackCode = true
ENT.RangeDistance = combatDistance -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 1 -- How close does it have to be until it uses melee?
ENT.RangeAttackAngleRadius = 100 -- What is the attack angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
ENT.TimeUntilRangeAttackProjectileRelease = 0 -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = 5 -- How much time until it can use a range attack?
ENT.RangeAttackReps = 1 -- How many times does it run the projectile code?
ENT.RangeAttackExtraTimers = {0} -- Extra range attack timers, EX: {1, 1.4} | it will run the projectile code after the given amount of seconds
ENT.DisableRangeAttackAnimation = true -- if true, it will disable the animation code

ENT.HasDeathRagdoll = false
ENT.Medic_CanBeHealed = false -- If set to false, this SNPC can't be healed!\
ENT.SoundTbl_SoundTrack = {"vj_hlr/crack_npc/joj/xfiles.mp3"}
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_Death = {"vj_hlr/gsrc/wep/mortar/mortarhit.wav"}
local sdExplosions = {"vj_hlr/crack_fx/explode3.wav","vj_hlr/crack_fx/explode4.wav","vj_hlr/crack_fx/explode5.wav"}

ENT.GeneralSoundPitch1 = 100
ENT.DeathSoundLevel = 100
---------------------------------------------------------------------------------------------------------------------------------------------
local spawnPos = Vector(0, 0, 400)
local colorYellow = Color(255,255,0,255)
--
function ENT:CustomOnInitialize()
	self.ConstantlyFaceEnemyDistance = self.SightDistance
	
	self:SetCollisionBounds(Vector(224, 236, 46), Vector(-224, -236, -17))
	self:SetPos(self:GetPos() + spawnPos)
	self.Immune_Bullet = true
	self.Immune_Blast = true
	if GetConVar("vj_hlrcl_skipufointro"):GetInt() == 1 then
		if GetConVar("vj_npc_snd_track"):GetInt() == 1 then
			self.HasSoundTrack = true
			self:StartSoundTrack()
		end
		if GetConVar("vj_hlrcl_allyspawn_joj"):GetInt() == 1 then
			timer.Create("jojufo_agruntsp"..self:EntIndex(), 3, 0, function() self:F_SpawnAlly() end)
			timer.Create("jojufo_snarksp"..self:EntIndex(), 1, 0, function() self:S_SpawnAlly() end)
		end
		self.Immune_Bullet = false
		self.Immune_Blast = false
		self.UFOSD_Engine = VJ_CreateSound(self, "vj_hlr/crack_npc/joj/engine.wav", 100)
	end
	
	if IsValid(self) && GetConVar("vj_hlrcl_skipufointro"):GetInt() == 0 then
		self.UFOSD_IntroSound = VJ_CreateSound(self, "vj_hlr/crack_npc/joj/JOJbossintro.wav", 100)
		//self.UFOSD_IntroSound = CreateSound(self, "HLRCL_UFOSD_IntroSound")
		self.shield = ents.Create("prop_dynamic")
		self.shield:SetPos(self:GetPos())
		self.shield:SetAngles(self:GetAngles())
		self.shield:SetModel("models/vj_hlr/cracklife/ufo_shield.mdl")
		self.shield:SetSolid(SOLID_VPHYSICS)
		self.shield:SetRenderMode(RENDERMODE_TRANSCOLOR)
		self.shield:Spawn()
		self.shield:Activate()
		self.Immune_Bullet = true
		self.Immune_Blast = true
		self:SetParent(self.shield)
		self:SetState(VJ_STATE_FREEZE)
		timer.Create("jojufo_intro"..self:EntIndex(), 19, 1, function() 
			self:SetParent(NULL)
			if GetConVar("vj_npc_snd_track"):GetInt() == 1 then
				self.HasSoundTrack = true
				self:StartSoundTrack()
			end
			self:SetState()			-- activates the AI
			if GetConVar("vj_hlrcl_allyspawn_joj"):GetInt() == 1 then
				timer.Create("jojufo_agruntsp"..self:EntIndex(), 3, 0, function() self:F_SpawnAlly() end)
				timer.Create("jojufo_snarksp"..self:EntIndex(), 1, 0, function() self:S_SpawnAlly() end)
			end
			self.shield:SetSolid(SOLID_NONE)
			self.shield:SetColor(Color(0,0,0,0))
			self.Immune_Bullet = false
			self.Immune_Blast = false
			self.UFOSD_Engine = VJ_CreateSound(self, "vj_hlr/crack_npc/joj/engine.wav", 100)
			if IsValid(self.shield) then self.shield:Remove() end
			for _,v in pairs(player.GetHumans()) do
				v:ScreenFade(SCREENFADE.IN, colorYellow, 0.5, 0)
			end
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:AttackVJAerialNPCs() -- this is retarded but it works and i do not care (subject to change)
	local startpos = self:GetPos()
	local tr2 = util.TraceLine({
		start = startpos,
		endpos = self:GetEnemy():GetPos() + self:GetEnemy():OBBCenter(),
		filter = self
	})
	local hitpos2 = tr2.HitPos
	local elec = EffectData()
	elec:SetStart(startpos)
	elec:SetOrigin(hitpos2)
	elec:SetEntity(self)
	elec:SetAttachment(1)
	util.Effect("VJ_HLR_UFO_Aerial",elec)
	--util.VJ_SphereDamage(self,self,hitpos2,1,1,DMG_SHOCK,true,false,{Force=90})
	self.UFOSD_Laser = VJ_CreateSound(self, "vj_hlr/crack_npc/joj/laser.wav", 120)
	self.HackyShitBecauseIAmLazy = ents.Create("prop_dynamic")
	self.HackyShitBecauseIAmLazy:SetPos(hitpos2)
	self.HackyShitBecauseIAmLazy:SetAngles(self:GetAngles())
	self.HackyShitBecauseIAmLazy:SetModel("models/effects/teleporttrail.mdl")
	self.HackyShitBecauseIAmLazy:SetSolid(SOLID_NONE)
	self.HackyShitBecauseIAmLazy:SetRenderMode(RENDERMODE_TRANSCOLOR)
	self.HackyShitBecauseIAmLazy:SetColor(Color(0,0,0,0))
	self.HackyShitBecauseIAmLazy:Spawn()
	self.HackyShitBecauseIAmLazy:Activate()
	timer.Create("jojufo_explbeam"..self:EntIndex(), 0.1, 1, function()
		util.BlastDamage(self, self, hitpos2, 400, 200)
		util.Decal("VJ_HLR_Scorch",tr2.HitPos+tr2.HitNormal,tr2.HitPos-tr2.HitNormal)
		VJ_EmitSound(self.HackyShitBecauseIAmLazy,{"vj_hlr/crack_fx/explode3.wav","vj_hlr/crack_fx/explode4.wav","vj_hlr/crack_fx/explode5.wav"},90)
		VJ_STOPSOUND(self.UFOSD_Laser)
		self.HackyShitBecauseIAmLazy:Remove()
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
		spr:SetKeyValue("scale","10")
		spr:SetPos(hitpos2 + self:GetUp()*150)
		spr:Spawn()
		spr:Fire("Kill","",0.9)
		timer.Simple(0.9,function() if IsValid(spr) then spr:Remove() end end)
		util.ScreenShake(self:GetPos(), 100, 200, 1, 2500)
		end)
	return hitpos2
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomRangeAttackCode()
	local controlled = self.VJ_IsBeingControlled
	local startpos = self:GetPos()
	local tr = util.TraceLine({
			start = startpos,
			endpos = self:GetEnemy():GetPos() + self:GetUp()*-200,
			filter = self
	})
	local hitpos = tr.HitPos
	
	self.OrbSprite = ents.Create("env_sprite")
	self.OrbSprite:SetKeyValue("model","vj_hl/sprites/exit1.vmt")
	//self.OrbSprite:SetKeyValue("rendercolor","255 128 0")
	self.OrbSprite:SetKeyValue("GlowProxySize","2.0")
	self.OrbSprite:SetKeyValue("HDRColorScale","1.0")
	self.OrbSprite:SetKeyValue("renderfx","14")
	self.OrbSprite:SetKeyValue("rendermode","3")
	self.OrbSprite:SetKeyValue("renderamt","255")
	self.OrbSprite:SetKeyValue("disablereceiveshadows","0")
	self.OrbSprite:SetKeyValue("mindxlevel","0")
	self.OrbSprite:SetKeyValue("maxdxlevel","0")
	self.OrbSprite:SetKeyValue("framerate","15.0")
	self.OrbSprite:SetKeyValue("spawnflags","0")
	self.OrbSprite:SetKeyValue("scale","0.5")
	self.OrbSprite:SetParent(self)
	self.OrbSprite:Fire("SetParentAttachment", "point")
	--self.OrbSprite:Fire("Alpha", "255")
	self.OrbSprite:Spawn()
	self.OrbSprite:Fire("Kill","",2)
	timer.Simple(2,function() if IsValid(self.OrbSprite) then self.OrbSprite:Remove() end end)
	self:DeleteOnRemove(self.OrbSprite)
	
	if IsValid(self:GetEnemy()) && self:GetEnemy().MovementType == VJ_MOVETYPE_AERIAL then
		for i = 0.05, 1.95, 0.05 do
			timer.Simple(i,function()
				if IsValid(self) && IsValid(self:GetEnemy()) then
					local hitpos = self:AttackVJAerialNPCs()
				end
			end)
		end
	else
	
	local elec = EffectData()
	elec:SetStart(startpos)
	elec:SetOrigin(hitpos)
	elec:SetEntity(self)
	elec:SetAttachment(1)
	self.UFOSD_Laser = VJ_CreateSound(self, "vj_hlr/crack_npc/joj/laser.wav", 120)
	util.Effect("VJ_HLR_UFO_Electric",elec)
	util.VJ_SphereDamage(self, self, hitpos, 30, 1, DMG_SHOCK, true, false, {Force=1})
	self.HackyShitBecauseIAmLazy = ents.Create("prop_dynamic")
	self.HackyShitBecauseIAmLazy:SetPos(hitpos)
	self.HackyShitBecauseIAmLazy:SetAngles(self:GetAngles())
	self.HackyShitBecauseIAmLazy:SetModel("models/effects/teleporttrail.mdl")
	self.HackyShitBecauseIAmLazy:SetSolid(SOLID_NONE)
	self.HackyShitBecauseIAmLazy:SetRenderMode(RENDERMODE_TRANSCOLOR)
	self.HackyShitBecauseIAmLazy:SetColor(Color(0,0,0,0))
	self.HackyShitBecauseIAmLazy:Spawn()
	self.HackyShitBecauseIAmLazy:Activate()
	sound.EmitHint(SOUND_DANGER, hitpos, 500, 1, self)
	timer.Create("jojufo_explbeam"..self:EntIndex(), 2, 1, function()
		util.BlastDamage(self, self, hitpos, 400, 200)
		util.Decal("VJ_HLR_Scorch",tr.HitPos+tr.HitNormal,tr.HitPos-tr.HitNormal)
		VJ_EmitSound(self.HackyShitBecauseIAmLazy,{"vj_hlr/crack_fx/explode3.wav","vj_hlr/crack_fx/explode4.wav","vj_hlr/crack_fx/explode5.wav"},90)
		VJ_STOPSOUND(self.UFOSD_Laser)
		self.HackyShitBecauseIAmLazy:Remove()
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
		spr:SetKeyValue("scale","10")
		spr:SetPos(hitpos + self:GetUp()*150)
		spr:Spawn()
		spr:Fire("Kill","",0.9)
		timer.Simple(0.9,function() if IsValid(spr) then spr:Remove() end end)
		util.ScreenShake(self:GetPos(), 100, 200, 1, 2500)
	end)
end
end
---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
local vec = Vector(0, 0, 0)
--
function ENT:CustomOnTakeDamage_BeforeImmuneChecks(dmginfo, hitgroup)
	if dmginfo:GetDamagePosition() != vec then
		local rico = EffectData()
		rico:SetOrigin(dmginfo:GetDamagePosition())
		rico:SetScale(4) -- Size
		rico:SetMagnitude(math.random(1, 2)) -- Effect type | 1 = Animated | 2 = Basic
		util.Effect("VJ_HLR_Rico", rico)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local colorHeliExp = Color(255, 255, 192, 128)
local sdGibCollide = {"vj_hlr/crack_fx/concrete1.wav"}
local UfoExpGibs = {
	"models/vj_hlr/cracklife/doritos.mdl"
}
--
function ENT:CustomOnInitialKilled(dmginfo, hitgroup)
	local deathCorpse = ents.Create("prop_vj_animatable")
	deathCorpse:SetModel(self:GetModel())
	deathCorpse:SetPos(self:GetPos())
	deathCorpse:SetAngles(self:GetAngles())
	function deathCorpse:Initialize()
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetMoveCollide(MOVECOLLIDE_FLY_BOUNCE)
		self:SetCollisionGroup(COLLISION_GROUP_NONE)
		self:SetSolid(SOLID_CUSTOM)
		local phys = self:GetPhysicsObject()
		if IsValid(phys) then
			phys:Wake()
			phys:EnableGravity(true)
			phys:SetBuoyancyRatio(0)
			phys:SetVelocity(self:GetVelocity())
			phys:AddAngleVelocity(Vector(math.Rand(-20, 20), math.Rand(-20, 20), 200))
		end
	end
	deathCorpse.NextExpT = 0
	deathCorpse:Spawn()
	deathCorpse:Activate()
	
	-- Explode as it goes down
	function deathCorpse:Think()
		self:ResetSequence("idle")
		if CurTime() > self.NextExpT then
			self.NextExpT = CurTime() + 0.2
			local expPos = self:GetPos() + Vector(math.Rand(-150, 150), math.Rand(-150, 150), math.Rand(-150, -50))
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
			spr:SetKeyValue("scale","5")
			spr:SetPos(expPos)
			spr:Spawn()
			spr:Fire("Kill", "", 0.9)
			timer.Simple(0.9, function() if IsValid(spr) then spr:Remove() end end)
			
			util.BlastDamage(self, self, expPos, 300, 100)
			VJ_EmitSound(self, sdExplosions, 100, 100)
		end
	
		self:NextThink(CurTime())
		return true
	end
	
	-- Get destroyed when it collides with something
	function deathCorpse:PhysicsCollide(data, phys)
		if self.Dead then return end
		self.Dead = true
		
		-- Create gibs
		local gibTbl = UfoExpGibs
		for _ = 1, 35 do
			local gib = ents.Create("obj_vj_gib")
			gib:SetModel(VJ_PICK(gibTbl))
			gib:SetPos(self:GetPos() + Vector(math.random(-100, 100), math.random(-100, 100), math.random(20, 150)))
			gib:SetAngles(Angle(math.Rand(-180, 180), math.Rand(-180, 180), math.Rand(-180, 180)))
			gib.CollisionDecal = false
			gib.CollisionSound = sdGibCollide
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
		
		local expPos = self:GetPos() + Vector(0,0,math.Rand(150, 150))
		local spr = ents.Create("env_sprite")
		spr:SetKeyValue("model","vj_hl/sprites/fexplo1.vmt")
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
		spr:SetKeyValue("scale","15")
		spr:SetPos(expPos)
		spr:Spawn()
		spr:Fire("Kill", "", 1.19)
		timer.Simple(1.19, function() if IsValid(spr) then spr:Remove() end end)
		util.BlastDamage(self, self, expPos, 800, 800)
		VJ_EmitSound(self, "vj_hlr/crack_npc/joj/JOJdie.wav", 100, 100)
		
		-- flags 0 = No fade!
		effects.BeamRingPoint(self:GetPos(), 0.4, 0, 1500, 32, 0, colorHeliExp, {material="vj_hl/sprites/shockwave", framerate=0, flags=0})
		
		self:Remove()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_IntMsg(ply, controlEnt)
	ply:ChatPrint("Your troops spawn automatically.")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPriorToKilled(dmginfo, hitgroup)
	local expPos = self:GetAttachment(self:LookupAttachment("point")).Pos
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
	spr:SetKeyValue("scale","5")
	spr:SetPos(expPos)
	spr:Spawn()
	spr:Fire("Kill", "", 0.9)
	timer.Simple(0.9, function() if IsValid(spr) then spr:Remove() end end)
	
	util.BlastDamage(self, self, expPos, 300, 100)
	VJ_EmitSound(self, sdExplosions, 100, 100)
end
---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
-- too lazy to merge in to one
function ENT:F_CreateAlly()
	local type = "npc_vj_hlrcl_agrunt"
	local tr = util.TraceLine({
		start = self:GetPos(),
		endpos = self:GetPos() + self:GetForward() * math.Rand(-1500, -900) + self:GetRight() * math.Rand(-900, 900) + self:GetUp() * -60,
		filter = {self, type},
		mask = MASK_ALL,
	})
	local spawnpos = tr.HitPos + tr.HitNormal*300
	local ally = ents.Create(type)
	ally:SetPos(spawnpos)
	ally:SetAngles(self:GetAngles())
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
function ENT:S_CreateAlly()
	local randnest = math.random(1,10)
	if randnest == 1 then
		self.stype = "npc_vj_hlrcl_snarknest"
	else
		self.stype = "npc_vj_hlrcl_snark"
	end
	local tr = util.TraceLine({
		start = self:GetPos(),
		endpos = self:GetPos() + self:GetForward() * math.Rand(-700, -400) + self:GetRight() * math.Rand(-700, 700) + self:GetUp() * -60,
		filter = {self, self.stype},
		mask = MASK_ALL,
	})
	local spawnpos = tr.HitPos + tr.HitNormal*300
	local ally = ents.Create(self.stype)
	ally:SetPos(spawnpos)
	ally:SetAngles(self:GetAngles())
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
	if !IsValid(self.UFOAlly1) && !IsValid(self.UFOAlly2) then
		self.UFOAlly1 = self:F_CreateAlly()
		self.UFOAlly2 = self:F_CreateAlly()
		return 150
	end
	return 15
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:S_SpawnAlly()
	if !IsValid(self.SnarkAlly1) then
		self.SnarkAlly1 = self:S_CreateAlly()
		return 15
	elseif !IsValid(self.SnarkAlly2) then
		self.SnarkAlly2 = self:S_CreateAlly()
		return 15
	elseif !IsValid(self.SnarkAlly3) then
		self.SnarkAlly3 = self:S_CreateAlly()
		return 15
	end
	return 8
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	timer.Remove("jojufo_explbeam"..self:EntIndex())
	timer.Remove("jojufo_intro"..self:EntIndex())
	timer.Remove("jojufo_agruntsp"..self:EntIndex())
	timer.Remove("jojufo_snarksp"..self:EntIndex())
	if IsValid(self.shield) then self.shield:Remove() end
	if IsValid(self.HackyShitBecauseIAmLazy) then self.HackyShitBecauseIAmLazy:Remove() end
	//if IsValid(self.UFOSD_IntroSound) then self.UFOSD_IntroSound:Stop() end
	VJ_STOPSOUND(self.UFOSD_IntroSound)
	VJ_STOPSOUND(self.UFOSD_Engine)
	VJ_STOPSOUND(self.UFOSD_Laser)
	if !self.Dead then
		if IsValid(self.UFOAlly1) then self.UFOAlly1:Remove() end
		if IsValid(self.UFOAlly2) then self.UFOAlly2:Remove() end
		if IsValid(self.SnarkAlly1) then self.SnarkAlly1:Remove() end
		if IsValid(self.SnarkAlly2) then self.SnarkAlly2:Remove() end
		if IsValid(self.SnarkAlly3) then self.SnarkAlly3:Remove() end
	end
end