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
if CLIENT then
	language.Add("sent_vj_hlrcl_recorder_huge", "Skrillyd's Player" )
end

function ENT:Draw() self:DrawModel() end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DrawTranslucent() self:Draw() end
---------------------------------------------------------------------------------------------------------------------------------------------
if CLIENT then
	local Name = "Skrillyd's Player"
	local LangName = "sent_vj_hlrcl_recorder_huge"
	language.Add(LangName, Name)
	killicon.Add(LangName,"HUD/killicons/default",Color(255,80,0,255))
	language.Add("#"..LangName, Name)
	killicon.Add("#"..LangName,"HUD/killicons/default",Color(255,80,0,255))
end
---------------------------------------------------------------------------------------------------------------------------------------------
if (!SERVER) then return end

ENT.VJ_NPC_Class = {"CLASS_CRACKLIFE_CHAV"} -- NPCs with the same class with be allied to each other
--ENT.VJ_IsHugeMonster = true

-- Custom
ENT.Assignee = NULL -- Is another entity the owner of this recorder?
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Initialize()
	self:SetPos(self:GetPos() + self:GetUp())
	self:SetModel("models/vj_hlr/cracklife/recorder_huge.mdl")
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetMaxHealth(3000)
	self:SetHealth(3000)
	self:SetAngles(Angle(0,0,0))
	
	self.IdleSd = CreateSound(self, "vj_hlr/crack_npc/skrillex/skrilly.wav")
	self.IdleSd:SetSoundLevel(75)
	self.IdleSd:Play()
	self:ResetSequence("rise")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Think()
	util.ScreenShake(self:GetPos(), 10, 100, 0.4, 2000)
	util.VJ_SphereDamage(self, self, self:GetPos(), 1500, 2, DMG_NEVERGIB, true, true)
	self:NextThink(CurTime() + 0.5)
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
local vecZ80 = Vector(0, 0, 180)
function ENT:OnTakeDamage(dmginfo)
	local gibsCollideSd = {"vj_hlr/crack_fx/metal1.wav"}
	self:SetHealth(self:Health() - dmginfo:GetDamage())
	self:EmitSound(VJ_PICK({"vj_hlr/gsrc/fx/metal1.wav","vj_hlr/gsrc/fx/metal3.wav"}), 70)
	if self:Health() <= 0 then
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p1.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,5)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p2.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(5,5,10)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p3.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(10,10,20)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p4.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(20,20,30)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p5.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(50,50,40)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p6.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,45)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p7.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,55)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p8.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,65)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p9.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,85)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p10.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(10,0,100)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p11.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(20,0,120)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p1.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,50,5)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p2.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,10)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p3.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,20)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p4.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,30)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p5.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p6.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,40,45)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p7.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,55)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p8.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,65)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p9.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,85)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p10.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,140)),CollideSound=gibsCollideSd})
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p11.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,150)),CollideSound=gibsCollideSd})
		self:EmitSound(VJ_PICK({"vj_hlr/crack_fx/bustmetal1.wav","vj_hlr/crack_fx/bustmetal2.wav"}), 100)
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
		spr:SetKeyValue("scale","8")
		spr:SetPos(self:GetPos() + vecZ80)
		spr:Spawn()
		spr:Fire("Kill","",0.9)
		timer.Simple(0.9, function() if IsValid(spr) then spr:Remove() end end)
		VJ_EmitSound(self, "vj_hlr/hl1_weapon/mortar/mortarhit.wav", 100, 100)
		effects.BeamRingPoint(self:GetPos(), 0.4, 0, 900, 64, 0, Color(255, 255, 192, 128), {material="vj_hl/sprites/shockwave", framerate=0, flags=0})
		--util.BlastDamage(self, self, self:GetPos() + Vector(0,0,150), 600, 200)
		util.VJ_SphereDamage(self, self, self:GetPos(), 500, 300, DMG_BLAST, false, true)
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
	gib.IsVJBaseCorpse_Gib = true
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