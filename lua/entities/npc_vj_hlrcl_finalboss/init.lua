include("entities/npc_vj_hlr1_garg/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2010-2025 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_hlr/cracklife/finalboss.mdl"
ENT.BloodColor = ""
ENT.HasBloodParticle = false
ENT.HasCollisionDecal = false
ENT.Bleeds = false
ENT.VJ_NPC_Class = {"CLASS_CRACKLIFE"} -- NPCs with the same class with be allied to each other
ENT.StartHealth = 66666
ENT.HasSoundTrack = true
ENT.PropAP_MaxSize = 10
ENT.SoundTbl_SoundTrack = {"vj_hlr/crack_npc/finalboss/finalboss.mp3"}

ENT.EntitiesToNoCollide = {"npc_vj_hlrcl_bonewheel","npc_vj_hlrcl_zombozo","npc_vj_hlrcl_pinkpanther","npc_vj_hlrcl_evilsci","npc_vj_hlrcl_terror","npc_vj_hlrcl_houndeye","npc_vj_hlrcl_alienslave","npc_vj_hlrcl10_zombie"}

ENT.Garg_Type = 2
ENT.F_NextSpawn = 0 -- Max 4
ENT.CanUseHD = false

local sdExplosions = {"vj_hlr/crack_fx/explode3.wav","vj_hlr/crack_fx/explode4.wav","vj_hlr/crack_fx/explode5.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Init()
	self:SetCollisionBounds(Vector(80,70,170),Vector(-45,-70,0))
	local glow1 = ents.Create("env_sprite")
	glow1:SetKeyValue("model", "vj_hl/sprites/gargeye1.vmt")
	glow1:SetKeyValue("GlowProxySize", "2.0") -- Size of the glow to be rendered for visibility testing.
	glow1:SetKeyValue("renderfx", "14")
	glow1:SetKeyValue("rendermode", "3") -- Set the render mode to "3" (Glow)
	glow1:SetKeyValue("disablereceiveshadows", "0") -- Disable receiving shadows
	glow1:SetKeyValue("spawnflags", "0")
	glow1:SetParent(self)
	glow1:Fire("SetParentAttachment", "eyes")
	glow1:Spawn()
	glow1:Activate()
	self:DeleteOnRemove(glow1)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInput(key,activator,caller,data)
	//print(key)
	if key == "step" then
		self:FootStepSoundCode()
	end
	if key == "melee" then
		self:MeleeAttackCode()
	end
	if key == "laser" then
		self:RangeAttackCode()
		for i = 0, 0.5, 0.1 do
			timer.Simple(i,function()
				if self:IsValid() then
					self:Shelling()
					if GetConVar("vj_hlrcl_allyspawn_finalboss"):GetInt() == 1 then
						self:F_SpawnAlly()
					end
				end
			end)
		end
		timer.Simple(0.5,function()
			for i = 0, 0.1, 0.05 do
				timer.Simple(i,function()
					if self:IsValid() then
						self:Shelling()
					end
				end)
			end
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Shelling()
	if self:IsValid() && IsValid(self:GetEnemy()) then
		local proj = ents.Create("obj_vj_hlr1_grenade_40mm")
		proj:SetPos(self:GetAttachment(self:LookupAttachment("eyes")).Pos + Vector(math.random(-10,10),math.random(-100,100),math.random(-50,10)))
		proj:SetAngles(self:GetAngles())
		proj:SetOwner(self)
		proj:Spawn()
		proj:Activate()
		proj.SoundTbl_OnRemove = sdExplosions
		local phys = proj:GetPhysicsObject()
		if phys:IsValid() then
			phys:Wake()
			--phys:SetVelocity(self:GetOwner():CalculateProjectile("Curve", pos, self:GetOwner():GetEnemy():GetPos() + self:GetOwner():GetEnemy():OBBCenter(), 1000))
			phys:SetVelocity(self:GetOwner():CalculateProjectile("Curve", self:GetPos() + self:GetUp(), self:GetEnemy():GetPos() + self:GetEnemy():OBBCenter(), 1000))
		end
		VJ.EmitSound(self, {"vj_hlr/gsrc/wep/mp5/glauncher.wav","vj_hlr/gsrc/wep/mp5/glauncher2.wav"}, 90)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnDeath(dmginfo, hitgroup, status)
	if status == "Init" then
		-- Death sequence (With explosions)
		for i = 0.3, 3.5, 0.5 do
			timer.Simple(i, function()
				if IsValid(self) then
					local myPos = self:GetPos()
					local spr = ents.Create("env_sprite")
					spr:SetKeyValue("model", "vj_hl/sprites/zerogxplode.vmt")
					spr:SetKeyValue("GlowProxySize", "2.0")
					spr:SetKeyValue("HDRColorScale", "1.0")
					spr:SetKeyValue("renderfx", "14")
					spr:SetKeyValue("rendermode", "5")
					spr:SetKeyValue("renderamt", "255")
					spr:SetKeyValue("disablereceiveshadows", "0")
					spr:SetKeyValue("mindxlevel", "0")
					spr:SetKeyValue("maxdxlevel", "0")
					spr:SetKeyValue("framerate", "15.0")
					spr:SetKeyValue("spawnflags", "0")
					spr:SetKeyValue("scale", self.Garg_Type == 1 and "3" or "6")
					spr:SetPos(myPos + self:GetUp()*(self.Garg_Type == 1 and math.random(60, 120) or math.random(120, 200)))
					spr:Spawn()
					spr:Fire("Kill", "", 0.9)
					util.BlastDamage(self, self, myPos, 150, 50)
					util.ScreenShake(myPos, 100, 200, 1, 2500)
					VJ.EmitSound(self, sdExplosions, 90, 100)
				end
			end)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local sdMetalCollision = {"vj_hlr/gsrc/fx/metal1.wav", "vj_hlr/gsrc/fx/metal2.wav", "vj_hlr/gsrc/fx/metal3.wav", "vj_hlr/gsrc/fx/metal4.wav", "vj_hlr/gsrc/fx/metal5.wav"}
--
function ENT:HandleGibOnDeath(dmginfo,hitgroup)
	timer.Simple(3.6,function()
		if IsValid(self) then
			if self.HasGibOnDeathEffects then
				local effectdata = EffectData()
				effectdata:SetOrigin(self:GetPos() + self:OBBCenter())
				util.Effect("HelicopterMegaBomb", effectdata)
				ParticleEffect("explosion_turret_break_fire", self:GetPos() +self:GetUp() *50, Angle(0,0,0))
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
				spr:SetKeyValue("scale","6")
				spr:SetPos(self:GetPos() + self:GetUp()*150)
				spr:Spawn()
				spr:Fire("Kill","",0.9)
				timer.Simple(0.9,function() if IsValid(spr) then spr:Remove() end end)
			end
			
			util.BlastDamage(self,self,self:GetPos(),150,80)
			util.ScreenShake(self:GetPos(),100,200,1,2500)
			
			VJ.EmitSound(self, sdExplosions, 90, math.random(100,100))
			VJ.EmitSound(self, "vj_hlr/gsrc/npc/rgrunt/rb_gib.wav", 80, math.random(100,100))
			
			util.Decal("VJ_HLR_Scorch", self:GetPos(), self:GetPos() + self:GetUp()*-100, self)
			
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p1.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound=sdMetalCollision})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p2.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound=sdMetalCollision})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p3.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,50)),CollideSound=sdMetalCollision})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p4.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound=sdMetalCollision})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p5.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound=sdMetalCollision})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p6.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,100)),CollideSound=sdMetalCollision})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p7.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,100)),CollideSound=sdMetalCollision})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p8.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,100)),CollideSound=sdMetalCollision})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p9.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,100)),CollideSound=sdMetalCollision})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p10.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,100)),CollideSound=sdMetalCollision})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p11.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,100)),CollideSound=sdMetalCollision})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p1.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound=sdMetalCollision})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p2.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound=sdMetalCollision})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p3.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,50)),CollideSound=sdMetalCollision})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p4.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound=sdMetalCollision})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p5.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound=sdMetalCollision})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p6.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,100)),CollideSound=sdMetalCollision})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p7.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,100)),CollideSound=sdMetalCollision})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p8.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,100)),CollideSound=sdMetalCollision})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p9.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,100)),CollideSound=sdMetalCollision})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p10.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,100)),CollideSound=sdMetalCollision})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p11.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,100)),CollideSound=sdMetalCollision})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/rgib_cog1.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,60)),CollideSound=sdMetalCollision})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/rgib_cog2.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,15)),CollideSound=sdMetalCollision})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/rgib_rib.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,15)),CollideSound=sdMetalCollision})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/rgib_screw.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,15)),CollideSound=sdMetalCollision})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/rgib_screw.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,15)),CollideSound=sdMetalCollision})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/rgib_screw.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,15)),CollideSound=sdMetalCollision})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/rgib_spring.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,15)),CollideSound=""})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/rgib_cog1.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,60)),CollideSound=sdMetalCollision})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/rgib_cog2.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,15)),CollideSound=sdMetalCollision})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/rgib_rib.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,15)),CollideSound=sdMetalCollision})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/rgib_screw.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,15)),CollideSound=sdMetalCollision})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/rgib_screw.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,15)),CollideSound=sdMetalCollision})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/rgib_screw.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,15)),CollideSound=sdMetalCollision})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/rgib_spring.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,15)),CollideSound=""})
			util.BlastDamage(self,self,self:GetPos(),150,20) -- To make the gibs FLY
		end
	end)
	return true, {AllowAnim = true, AllowSound = false}
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:F_CreateAlly()
	local tr = util.TraceLine({
		start = self:GetPos(),
		endpos = self:GetPos() + self:GetForward() * math.Rand(-700, 700) + self:GetRight() * math.Rand(-700, 700) + self:GetUp() * 60,
		filter = self,
		mask = MASK_ALL,
	})
	local spawnpos = tr.HitPos + tr.HitNormal*30
	local type = VJ_PICK({"npc_vj_hlrcl_bonewheel","npc_vj_hlrcl_zombozo","npc_vj_hlrcl_pinkpanther","npc_vj_hlrcl_evilsci","npc_vj_hlrcl_terror","npc_vj_hlrcl_houndeye","npc_vj_hlrcl_alienslave","npc_vj_hlrcl10_zombie"})
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
function ENT:Controller_IntMsg(ply, controlEnt)
	if self.Garg_Type == 1 then return end
	ply:ChatPrint("Right Mouse + CTRL: Preform Stomp attack + Shell the fuck out of someone + Spawn minions")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:F_SpawnAlly()
	-- Can have a total of 5, only 1 can be spawned at a time with a delay until another one is spawned
	if !IsValid(self.F_Ally1) then
		self.F_Ally1 = self:F_CreateAlly()
		return 15
	elseif !IsValid(self.F_Ally2) then
		self.F_Ally2 = self:F_CreateAlly()
		return 15
	elseif !IsValid(self.F_Ally3) then
		self.F_Ally3 = self:F_CreateAlly()
		return 15
	elseif !IsValid(self.F_Ally4) then
		self.F_Ally4 = self:F_CreateAlly()
		return 15
	elseif !IsValid(self.F_Ally5) then
		self.F_Ally5 = self:F_CreateAlly()
		return 15
	elseif !IsValid(self.F_Ally6) then
		self.F_Ally6 = self:F_CreateAlly()
		return 15
	end
	return 8
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	if !self.Dead then
		if IsValid(self.F_Ally1) then self.F_Ally1:Remove() end
		if IsValid(self.F_Ally2) then self.F_Ally2:Remove() end
		if IsValid(self.F_Ally3) then self.F_Ally3:Remove() end
		if IsValid(self.F_Ally4) then self.F_Ally4:Remove() end
		if IsValid(self.F_Ally5) then self.F_Ally5:Remove() end
		if IsValid(self.F_Ally6) then self.F_Ally6:Remove() end
	end
end