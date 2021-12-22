/*--------------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
AddCSLuaFile()

ENT.Base 			= "base_entity"
ENT.Type 			= "ai"
ENT.PrintName 		= "Skrillyd's Player"
ENT.Author 			= "DrVrej"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= "Used to make simple props and animate them, since prop_dynamic doesn't work properly in Garry's Mod."
ENT.Instructions 	= "Don't change anything."
ENT.Category		= "VJ Base"

function ENT:Draw() self:DrawModel() end
---------------------------------------------------------------------------------------------------------------------------------------------
if (!SERVER) then return end

ENT.VJ_NPC_Class = {"CLASS_CRACKLIFE_CHAV"} -- NPCs with the same class with be allied to each other

-- Custom
ENT.Assignee = NULL -- Is another entity the owner of this crystal?
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Initialize()
	self:SetPos(self:GetPos() + self:GetUp()*40)
		
	self:SetModel("models/vj_hlr/cracklife/recorder.mdl")
	self:SetMoveType(MOVETYPE_FLY)
	self:SetSolid(SOLID_VPHYSICS)
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
	self:EmitSound(VJ_PICK({"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal3.wav"}), 70)
	if self:Health() <= 0 then
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p1.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,5)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p2.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,10)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p3.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,20)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p4.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,30)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p5.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p6.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,45)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p7.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,55)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p8.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,65)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p9.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,85)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p10.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,100)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p11.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,120)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p1.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,5)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p2.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,10)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p3.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,20)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p4.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,30)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p5.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p6.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,45)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p7.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,55)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p8.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,65)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p9.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,85)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p10.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,100)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p11.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,120)),CollideSound=gibsCollideSd})
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
	// self:CreateGibEntity("prop_ragdoll", "", {Pos=self:LocalToWorld(Vector(0,3,0)), Ang=self:GetAngles(), Vel=})
	if self.AllowedToGib == false then return end
	local bloodType = "Red"
	class = class or "obj_vj_gib"
	if models == "UseAlien_Small" then
		models =  VJ_PICK(gib_mdlASmall)
		bloodType = "Yellow"
	elseif models == "UseAlien_Big" then
		models =  VJ_PICK(gib_mdlABig)
		bloodType = "Yellow"
	elseif models == "UseHuman_Small" then
		models =  VJ_PICK(gib_mdlHSmall)
	elseif models == "UseHuman_Big" then
		models =  VJ_PICK(gib_mdlHBig)
	else -- Custom models
		models = VJ_PICK(models)
		if VJ_HasValue(gib_mdlAAll, models) then
			bloodType = "Yellow"
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
		bloodType = extraOptions.BloodType or bloodType -- Certain entities such as the VJ Gib entity, you can use this to set its gib type
		local removeOnCorpseDelete = extraOptions.RemoveOnCorpseDelete or false -- Should the entity get removed if the corpse is removed?
	local gib = ents.Create(class)
	gib:SetModel(models)
	gib:SetPos(extraOptions.Pos or (self:GetPos() + self:OBBCenter()))
	gib:SetAngles(extraOptions.Ang or Angle(math.Rand(-180, 180), math.Rand(-180, 180), math.Rand(-180, 180)))
	if gib:GetClass() == "obj_vj_gib" then
		gib.BloodType = bloodType
		gib.Collide_Decal = extraOptions.BloodDecal or "Default"
		gib.CollideSound = extraOptions.CollideSound or "Default"
	end
	gib:Spawn()
	gib:Activate()
	gib.IsVJBase_Gib = true
	gib.RemoveOnCorpseDelete = removeOnCorpseDelete
	if GetConVar("vj_npc_gibcollidable"):GetInt() == 0 then gib:SetCollisionGroup(1) end
	local phys = gib:GetPhysicsObject()
	if IsValid(phys) then
		phys:AddVelocity(vel)
		phys:AddAngleVelocity(extraOptions.AngVel or Vector(math.Rand(-200, 200), math.Rand(-200, 200), math.Rand(-200, 200)))
	end
	if extraOptions.NoFade != true && GetConVar("vj_npc_fadegibs"):GetInt() == 1 then
		if gib:GetClass() == "obj_vj_gib" then timer.Simple(GetConVar("vj_npc_fadegibstime"):GetInt(), function() SafeRemoveEntity(gib) end)
		elseif gib:GetClass() == "prop_ragdoll" then gib:Fire("FadeAndRemove", "", GetConVar("vj_npc_fadegibstime"):GetInt())
		elseif gib:GetClass() == "prop_physics" then gib:Fire("kill", "", GetConVar("vj_npc_fadegibstime"):GetInt()) end
	end
	if removeOnCorpseDelete == true then //self.Corpse:DeleteOnRemove(extraent)
		self.ExtraCorpsesToRemove_Transition[#self.ExtraCorpsesToRemove_Transition + 1] = gib
	end
	if (customFunc) then customFunc(gib) end
end
---------------------------------------------------------------------------------------------------------------------------------------------