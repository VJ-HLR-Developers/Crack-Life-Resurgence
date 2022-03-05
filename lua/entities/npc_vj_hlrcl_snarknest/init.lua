AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2022 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_hlr/cracklife/sqknest.mdl"}
ENT.VJ_NPC_Class = {"CLASS_CRACKLIFE"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(15, 15, 18), Vector(-15, -15, 0))
	self.SoundTbl_Idle = {"vj_hlr/crack_npc/snark/dick.wav"}
	self.Nest_SpawnEnt = "npc_vj_hlrcl_snark"
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnKilled(dmginfo, hitgroup)
	if self.Snark_Type == 0 then
		util.VJ_SphereDamage(self, self, self:GetPos(), 50, 15, DMG_ACID, true, true)
		local effectBlood = EffectData()
		effectBlood:SetOrigin(self:GetPos() + self:OBBCenter())
		effectBlood:SetColor(VJ_Color2Byte(Color(255,221,35)))
		effectBlood:SetScale(40)
		util.Effect("VJ_Blood1",effectBlood)
			
		local bloodspray = EffectData()
		bloodspray:SetOrigin(self:GetPos() + self:OBBCenter())
		bloodspray:SetScale(6)
		bloodspray:SetFlags(3)
		bloodspray:SetColor(1)
		util.Effect("bloodspray",bloodspray)
		util.Effect("bloodspray",bloodspray)
			
		local effectdata = EffectData()
		effectdata:SetOrigin(self:GetPos() + self:OBBCenter())
		effectdata:SetScale(0.4)
		util.Effect("StriderBlood",effectdata)
		util.Effect("StriderBlood",effectdata)
	end
	
	if math.random(1,1000) == 1 then -- =)
		if self.Nest_SpawnEnt == "npc_vj_hlrcl_snark" then
			self.Nest_SpawnEnt = "npc_vj_hlrcl_blackscary"
		end
	end
	
	for _ = 1, math.random(4,16) do
		local ent = ents.Create(self.Nest_SpawnEnt)
		ent:SetPos(self:GetPos())
		ent:SetAngles(self:GetAngles())
		ent:SetVelocity(self:GetUp()*math.Rand(250,350) + self:GetRight()*math.Rand(-100,100) + self:GetForward()*math.Rand(-100,100))
		ent:Spawn()
		ent:Activate()
		if self.Nest_SpawnEnt == "npc_vj_hlrcl_blackscary" then
			ent.EntitiesToNoCollide = {"npc_vj_hlrcl_blackscary"}
		end
	end
end