/*--------------------------------------------------
	*** Copyright (c) 2010-2025 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
AddCSLuaFile()

ENT.Base 			= "base_entity"
ENT.Type 			= "ai"
ENT.PrintName 		= "Skrillyd's Player"
ENT.Author 			= "oteek"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= "Used to make simple props and animate them, since prop_dynamic doesn't work properly in Garry's Mod."
ENT.Instructions 	= "Don't change anything."
ENT.Category		= "VJ Base"

function ENT:Draw() self:DrawModel() end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DrawTranslucent() self:Draw() end
---------------------------------------------------------------------------------------------------------------------------------------------
if CLIENT then
	local Name = "Skrillyd's Player"
	local LangName = "sent_vj_hlrcl_recorder"
	language.Add(LangName, Name)
	killicon.Add(LangName,"HUD/killicons/default",Color(255,80,0,255))
	language.Add("#"..LangName, Name)
	killicon.Add("#"..LangName,"HUD/killicons/default",Color(255,80,0,255))
end
---------------------------------------------------------------------------------------------------------------------------------------------
if (!SERVER) then return end

ENT.VJ_NPC_Class = {"CLASS_CRACKLIFE_CHAV"} -- NPCs with the same class with be allied to each other

-- Custom
ENT.Assignee = NULL -- Is another entity the owner of this crystal?
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Initialize()
	self:SetPos(self:GetPos() + self:GetUp()*40)
		
	self:SetModel("models/vj_hlr/cracklife/recorder.mdl")
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_BBOX)
	self:SetMaxHealth(200)
	self:SetHealth(200)
	self:SetAngles(Angle(0,0,0))
	
	self.IdleSd = CreateSound(self, "vj_hlr/crack_npc/skrillex/skrilly.wav")
	self.IdleSd:SetSoundLevel(80)
	self.IdleSd:Play()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Think()
	util.VJ_SphereDamage(self, self, self:GetPos(), 1024, 2, DMG_NEVERGIB, true, true)
	self:NextThink(CurTime() + 0.5)
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnTakeDamage(dmginfo)
	local gibsCollideSd = {"vj_hlr/crack_fx/metal1.wav"}
	self:SetHealth(self:Health() - dmginfo:GetDamage())
	self:EmitSound(VJ_PICK({"vj_hlr/gsrc/fx/metal1.wav","vj_hlr/gsrc/fx/metal3.wav"}), 80)
	if self:Health() <= 0 then
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p1.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,5)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p2.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(1,0,10)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p3.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,20)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p4.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(1,0,30)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p5.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p6.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(2,0,45)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p7.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,55)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p8.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(1,0,65)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p9.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,85)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p10.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,100)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p11.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(1,0,120)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p1.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,5)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p2.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,10)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p3.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,20)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p4.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(1,0,30)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p5.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p6.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,45)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p7.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(-1,0,55)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p8.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,65)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p9.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,85)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p10.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,100)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p11.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,120)),CollideSound=gibsCollideSd})
		self:EmitSound(VJ_PICK({"vj_hlr/crack_fx/bustmetal1.wav","vj_hlr/crack_fx/bustmetal2.wav"}), 100)
		self:Remove()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnRemove()
	VJ_STOPSOUND(self.IdleSd)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CreateGibEntity(class, models, extraOptions, customFunc)
	local bloodType = false
	if models == "UseAlien_Small" then
		models =  VJ.PICK(gib_mdlASmall)
		bloodType = VJ.BLOOD_COLOR_YELLOW
	elseif models == "UseAlien_Big" then
		models =  VJ.PICK(gib_mdlABig)
		bloodType = VJ.BLOOD_COLOR_YELLOW
	elseif models == "UseHuman_Small" then
		models =  VJ.PICK(gib_mdlHSmall)
		bloodType = VJ.BLOOD_COLOR_RED
	elseif models == "UseHuman_Big" then
		models =  VJ.PICK(gib_mdlHBig)
		bloodType = VJ.BLOOD_COLOR_RED
	else -- Custom models
		models = VJ.PICK(models)
		if VJ.HasValue(gib_mdlAAll, models) then
			bloodType = VJ.BLOOD_COLOR_YELLOW
		end
	end
	extraOptions = extraOptions or {}
		local vel = extraOptions.Vel or Vector(math.Rand(-100, 100), math.Rand(-100, 100), math.Rand(150, 250))
		if self.SavedDmgInfo then
			local dmgForce = self.SavedDmgInfo.force / 70
			if extraOptions.Vel_ApplyDmgForce != false && extraOptions.Vel != "UseDamageForce" then -- Use both damage force AND given velocity
				vel = vel + dmgForce
			elseif extraOptions.Vel == "UseDamageForce" then -- Use damage force
				vel = dmgForce
			end
		end
		bloodType = (extraOptions.BloodType or bloodType or self.BloodColor) -- Certain entities such as the VJ Gib entity, you can use this to set its gib type
	
	local gib = ents.Create(class or "obj_vj_gib")
	gib:SetModel(models)
	gib:SetPos(extraOptions.Pos or (self:GetPos() + self:OBBCenter()))
	gib:SetAngles(extraOptions.Ang or Angle(math.Rand(-180, 180), math.Rand(-180, 180), math.Rand(-180, 180)))
	if gib:GetClass() == "obj_vj_gib" then
		gib.BloodType = bloodType
		if extraOptions.CollisionDecal != nil then
			gib.CollisionDecal = extraOptions.CollisionDecal
		elseif extraOptions.CollisionDecal then -- Backwards compatibility
			gib.CollisionDecal = extraOptions.CollisionDecal
		end
		if extraOptions.CollisionSound != nil then
			gib.CollisionSound = extraOptions.CollisionSound
		elseif extraOptions.CollideSound then -- Backwards compatibility
			gib.CollisionSound = extraOptions.CollideSound
		end
		//gib.BloodData = {Color = bloodType, Particle = self.BloodParticle, Decal = self.CollisionDecal} -- For eating system
	end
	gib:Spawn()
	gib:Activate()
	gib.IsVJBaseCorpse_Gib = true
	local vj_npc_gib_collision = GetConVar("vj_npc_gib_collision")
	local vj_npc_gib_fade = GetConVar("vj_npc_gib_fade")
	local vj_npc_gib_fadetime = GetConVar("vj_npc_gib_fadetime")
	if vj_npc_gib_collision:GetInt() == 0 then gib:SetCollisionGroup(COLLISION_GROUP_DEBRIS) end
	local phys = gib:GetPhysicsObject()
	if IsValid(phys) then
		phys:AddVelocity(vel)
		phys:AddAngleVelocity(extraOptions.AngVel or Vector(math.Rand(-200, 200), math.Rand(-200, 200), math.Rand(-200, 200)))
	end
	if extraOptions.NoFade != true && vj_npc_gib_fade:GetInt() == 1 then
		if gib:GetClass() == "obj_vj_gib" then timer.Simple(vj_npc_gib_fadetime:GetInt(), function() SafeRemoveEntity(gib) end)
		elseif gib:GetClass() == "prop_ragdoll" then gib:Fire("FadeAndRemove", "", vj_npc_gib_fadetime:GetInt())
		elseif gib:GetClass() == "prop_physics" then gib:Fire("kill", "", vj_npc_gib_fadetime:GetInt()) end
	end
	if removeOnCorpseDelete then //self.Corpse:DeleteOnRemove(extraent)
		if !self.DeathCorpse_ChildEnts then self.DeathCorpse_ChildEnts = {} end -- If it doesn't exist, then create it!
		self.DeathCorpse_ChildEnts[#self.DeathCorpse_ChildEnts + 1] = gib
	end
	if (customFunc) then customFunc(gib) end
end
---------------------------------------------------------------------------------------------------------------------------------------------