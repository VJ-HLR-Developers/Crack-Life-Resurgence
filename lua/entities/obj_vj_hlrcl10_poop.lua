/*--------------------------------------------------
	*** Copyright (c) 2012-2024 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "obj_vj_projectile_base"
ENT.PrintName		= "Dung"
ENT.Author 			= "oteek"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Information		= "Projectile, usually used for NPCs & Weapons"
ENT.Category		= "Projectiles"

if CLIENT then
	local Name = "Dung"
	local LangName = "obj_vj_hlrcl10_poop"
	language.Add(LangName, Name)
	killicon.Add(LangName,"HUD/killicons/default",Color(255,80,0,255))
	language.Add("#"..LangName, Name)
	killicon.Add("#"..LangName,"HUD/killicons/default",Color(255,80,0,255))
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if !SERVER then return end

ENT.Model = { "models/vj_hlr/cracklife10/poop1.mdl", "models/vj_hlr/cracklife10/poop2.mdl", "models/vj_hlr/cracklife10/poop3.mdl" } -- The models it should spawn with | Picks a random one from the table
ENT.DoesRadiusDamage = true -- Should it do a blast damage when it hits something?
ENT.RadiusDamageRadius = 90 -- How far the damage go? The farther away it's from its enemy, the less damage it will do | Counted in world units
ENT.RadiusDamage = 17 -- How much damage should it deal? Remember this is a radius damage, therefore it will do less damage the farther away the entity is from its enemy
ENT.RadiusDamageUseRealisticRadius = true -- Should the damage decrease the farther away the enemy is from the position that the projectile hit?
ENT.RadiusDamageType = DMG_ACID -- Damage type
ENT.DecalTbl_DeathDecals = {"VJ_HLR_Spit_Acid"}
ENT.SoundTbl_OnCollide = {"vj_hlr/fx/bustflesh1.wav", "vj_hlr/fx/bustflesh2.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomPhysicsObjectOnInitialize(phys)
	phys:Wake()
	phys:SetMass(1)
	phys:SetBuoyancyRatio(0)
	phys:EnableDrag(false)
	phys:EnableGravity(true)
    phys:AddAngleVelocity(Vector(math.random(-400,400),math.random(-400,400),math.random(-400,400)))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.Scale = math.Rand(0.5, 1.15)
	
    local sprIdle = ents.Create("env_sprite")
    sprIdle:SetKeyValue("model","vj_hl/sprites/bigspit.vmt")
    sprIdle:SetKeyValue("rendercolor","255 255 255")
    sprIdle:SetKeyValue("GlowProxySize","5.0")
    sprIdle:SetKeyValue("HDRColorScale","1.0")
    sprIdle:SetKeyValue("renderfx","0")
    sprIdle:SetKeyValue("rendermode","2")
    sprIdle:SetKeyValue("renderamt","255")
    sprIdle:SetKeyValue("disablereceiveshadows","0")
    sprIdle:SetKeyValue("mindxlevel","0")
    sprIdle:SetKeyValue("maxdxlevel","0")
    sprIdle:SetKeyValue("framerate","40.0")
    sprIdle:SetKeyValue("spawnflags","0")
    sprIdle:SetKeyValue("scale",tostring(self.Scale))
    sprIdle:SetPos(self:GetPos())
    sprIdle:Spawn()
    sprIdle:SetParent(self)
    self:DeleteOnRemove(sprIdle)
	self:SetAngles(self:GetVelocity():GetNormal():Angle())
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DeathEffects(data, phys)
	local spr = ents.Create("env_sprite")
	spr:SetKeyValue("model","vj_hl/sprites/bigspit_impact.vmt")
	spr:SetKeyValue("GlowProxySize","2.0")
	spr:SetKeyValue("HDRColorScale","1.0")
	spr:SetKeyValue("renderfx","0")
	spr:SetKeyValue("rendermode","2")
	spr:SetKeyValue("renderamt","255")
	spr:SetKeyValue("disablereceiveshadows","0")
	spr:SetKeyValue("mindxlevel","0")
	spr:SetKeyValue("maxdxlevel","0")
	spr:SetKeyValue("framerate","15.0")
	spr:SetKeyValue("spawnflags","0")
	spr:SetKeyValue("scale",tostring(self.Scale *0.6))
	spr:SetPos(data.HitPos + Vector(0,0,10))
	spr:Spawn()
	spr:Fire("Kill","",0.3)
	timer.Simple(0.3, function() if IsValid(spr) then spr:Remove() end end)

	//ParticleEffect("vj_hl_spit_bullsquid_impact", data.HitPos, Angle(0,0,0), nil)
end