AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_hlr/cracklife/finalboss.mdl"}
ENT.BloodColor = ""
ENT.HasBloodParticle = false
ENT.HasBloodDecal = false
ENT.VJ_NPC_Class = {"CLASS_CRACKLIFE"} -- NPCs with the same class with be allied to each other
ENT.StartHealth = 666666
ENT.HasSoundTrack = true
ENT.PropAP_MaxSize = 10
ENT.SoundTbl_SoundTrack = {"vj_hlr/crack_npc/finalboss/finalboss.mp3"}

---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(80,70,170),Vector(-45,-70,0))
	self.Glow1 = ents.Create("env_sprite")
	self.Glow1:SetKeyValue("model","vj_hl/sprites/gargeye1.vmt")
	self.Glow1:SetKeyValue("GlowProxySize","2.0") -- Size of the glow to be rendered for visibility testing.
	self.Glow1:SetKeyValue("renderfx","14")
	self.Glow1:SetKeyValue("rendermode","3") -- Set the render mode to "3" (Glow)
	self.Glow1:SetKeyValue("disablereceiveshadows","0") -- Disable receiving shadows
	self.Glow1:SetKeyValue("spawnflags","0")
	self.Glow1:SetParent(self)
	self.Glow1:Fire("SetParentAttachment","eyes")
	self.Glow1:Spawn()
	self.Glow1:Activate()
	self:DeleteOnRemove(self.Glow1)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	print(key)
	if key == "step" then
		self:FootStepSoundCode()
	end
	if key == "melee" then
		self:MeleeAttackCode()
	end
	if key == "laser" then
		self:RangeAttackCode()
			timer.Simple(0.1,function()
				if self:IsValid() then
					self:Shelling()
				end
			end)
			timer.Simple(0.2,function()
				if self:IsValid() then
					self:Shelling()
				end
			end)
			timer.Simple(0.3,function()
				if self:IsValid() then
					self:Shelling()
				end
			end)
			timer.Simple(0.4,function()
				if self:IsValid() then
					self:Shelling()
				end
			end)
			timer.Simple(0.5,function()
				if self:IsValid() then
					self:Shelling()
				end
			end)
			timer.Simple(0.55,function()
				if self:IsValid() then
					self:Shelling()
				end
			end)
			timer.Simple(0.6,function()
				if self:IsValid() then
					self:Shelling()
				end
			end)
			timer.Simple(0.65,function()
				if self:IsValid() then
					self:Shelling()
				end
			end)
			timer.Simple(0.7,function()
				if self:IsValid() then
					self:Shelling()
				end
			end)
			timer.Simple(0.75,function()
				if self:IsValid() then
					self:Shelling()
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
	local phys = proj:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
		--phys:SetVelocity(self:GetOwner():CalculateProjectile("Curve", pos, self:GetOwner():GetEnemy():GetPos() + self:GetOwner():GetEnemy():OBBCenter(), 1000))
		phys:SetVelocity(self:GetOwner():CalculateProjectile("Curve", self:GetPos() + self:GetUp(), self:GetEnemy():GetPos() + self:GetEnemy():OBBCenter(), 1000))
	end
	VJ_EmitSound(proj:GetOwner(),{"vj_hlr/hl1_weapon/mp5/glauncher.wav","vj_hlr/hl1_weapon/mp5/glauncher2.wav"},90)
end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
	timer.Simple(3.6,function()
		if IsValid(self) then
			if self.HasGibDeathParticles == true then
				local effectdata = EffectData()
				effectdata:SetOrigin(self:GetPos())
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
			
			VJ_EmitSound(self,{"vj_hlr/hl1_weapon/explosion/explode3.wav","vj_hlr/hl1_weapon/explosion/explode4.wav","vj_hlr/hl1_weapon/explosion/explode5.wav"},90,math.random(100,100))
			VJ_EmitSound(self,"vj_hlr/hl1_npc/rgrunt/rb_gib.wav",80,math.random(100,100))
			
			util.Decal("VJ_HLR_Scorch", self:GetPos(), self:GetPos() + self:GetUp()*-100, self)
			
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p1.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p2.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p3.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,50)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p4.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p5.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p6.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,100)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p7.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,100)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p8.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,100)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p9.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,100)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p10.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,100)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p11.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,100)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p1.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p2.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p3.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,50)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p4.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p5.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p6.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,100)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p7.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,100)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p8.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,100)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p9.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,100)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p10.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,100)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p11.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,100)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/rgib_cog1.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,60)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/rgib_cog2.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,15)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/rgib_rib.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,15)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/rgib_screw.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,15)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/rgib_screw.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,15)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/rgib_screw.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,15)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/rgib_spring.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,15)),CollideSound=""})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/rgib_cog1.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,60)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/rgib_cog2.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,15)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/rgib_rib.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,15)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/rgib_screw.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,15)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/rgib_screw.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,15)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/rgib_screw.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,15)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/rgib_spring.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,15)),CollideSound=""})
			util.BlastDamage(self,self,self:GetPos(),150,20) -- To make the gibs FLY
		end
	end)
	return true, {DeathAnim=true}-- Return to true if it gibbed!
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/