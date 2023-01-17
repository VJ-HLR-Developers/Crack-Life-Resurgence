AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2023 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
-- this will be the worst and the most annoying miniboss you will ever fight.

ENT.Model = {"models/vj_hlr/cracklife/2spooky.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 200
ENT.VJ_IsHugeMonster = true

--ENT.FlinchChance = 30 
ENT.MeleeAttackDistance = 40

ENT.HasSoundTrack = true
ENT.SoundTbl_SoundTrack = {"vj_hlr/crack_npc/spooky/3spooky5me.mp3"}
ENT.GeneralSoundPitch1 = 70
ENT.GeneralSoundPitch2 = 80
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(16,16,100),Vector(-16,-16,0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	//print(key)
	if key == "step" then
		self:FootStepSoundCode()
	end
	if key == "right" or key == "left" or key == "both" then
		self:MeleeAttackCode()
	end
	if key == "body" then
		VJ_EmitSound(self, "vj_hlr/crack_fx/bodydrop.wav", 85, 100)
	end
	if key == "summon" then
		self:SpawnItself()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnFlinch_AfterFlinch(dmginfo, hitgroup)
	if GetConVar("vj_hlrcl_selfspawn_2spooky"):GetInt() == 1 then
		timer.Create("skeletonmaster_cloning"..self:EntIndex(), 1.2, 1, function()
			if !self.Dead then
				self:VJ_ACT_PLAYACTIVITY(ACT_DEPLOY, true, false)
			end
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_AfterDamage(dmginfo, hitgroup)
	if GetConVar("vj_hlrcl_allyspawn_2spooky"):GetInt() == 1 then
		self:S_SpawnAlly()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SpawnItself()
	self.stype = "npc_vj_hlrcl_2spooky"
	local tr = util.TraceLine({
		start = self:GetPos(),
		endpos = self:GetPos() + self:GetForward() * math.Rand(-700, -400) + self:GetRight() * math.Rand(-700, 700) + self:GetUp() * 60,
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
	
	local effectTeleport = VJ_HLR_Effect_PortalSpawn(spawnpos + Vector(0,0,20))
	effectTeleport:Fire("Kill","",1)
	
	return ally
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:S_CreateAlly()
	local randnest = math.random(1,50)
	if randnest == 1 then
		self.stype = "npc_vj_hlrcl_bonewheel"
	else
		self.stype = "npc_vj_hlrcl_spooky"
	end
	local tr = util.TraceLine({
		start = self:GetPos(),
		endpos = self:GetPos() + self:GetForward() * math.Rand(-700, -400) + self:GetRight() * math.Rand(-700, 700) + self:GetUp() * 60,
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
	
	local effectTeleport = VJ_HLR_Effect_PortalSpawn(spawnpos + Vector(0,0,20))
	effectTeleport:Fire("Kill","",1)
	
	return ally
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:S_SpawnAlly()
	if !IsValid(self.SkAlly1) then
		self.SkAlly1 = self:S_CreateAlly()
		return 15
	elseif !IsValid(self.SkAlly2) then
		self.SkAlly2 = self:S_CreateAlly()
		return 15
	elseif !IsValid(self.SkAlly3) then
		self.SkAlly3 = self:S_CreateAlly()
		return 15
	elseif !IsValid(self.SkAlly4) then
		self.SkAlly4 = self:S_CreateAlly()
		return 15
	elseif !IsValid(self.SkAlly5) then
		self.SkAlly5 = self:S_CreateAlly()
		return 15
	elseif !IsValid(self.SkAlly6) then
		self.SkAlly6 = self:S_CreateAlly()
		return 15
	elseif !IsValid(self.SkAlly7) then
		self.SkAlly7 = self:S_CreateAlly()
		return 15
	elseif !IsValid(self.SkAlly8) then
		self.SkAlly8 = self:S_CreateAlly()
		return 15
	elseif !IsValid(self.SkAlly9) then
		self.SkAlly9 = self:S_CreateAlly()
		return 15
	elseif !IsValid(self.SkAlly10) then
		self.SkAlly10 = self:S_CreateAlly()
		return 15
	
	end
	return 8
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	timer.Remove("skeletonmaster_cloning"..self:EntIndex())
	if !self.Dead then
		if IsValid(self.SkAlly1) then self.SkAlly1:Remove() end
		if IsValid(self.SkAlly2) then self.SkAlly2:Remove() end
		if IsValid(self.SkAlly3) then self.SkAlly3:Remove() end
		if IsValid(self.SkAlly4) then self.SkAlly4:Remove() end
		if IsValid(self.SkAlly5) then self.SkAlly5:Remove() end
		if IsValid(self.SkAlly6) then self.SkAlly6:Remove() end
		if IsValid(self.SkAlly7) then self.SkAlly7:Remove() end
		if IsValid(self.SkAlly8) then self.SkAlly8:Remove() end
		if IsValid(self.SkAlly9) then self.SkAlly9:Remove() end
		if IsValid(self.SkAlly10) then self.SkAlly10:Remove() end
	end
end