AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_hlr/cracklife/islave.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 100
ENT.SoundTbl_BeforeRangeAttack = {"vj_hlr/crack_npc/aslave/disco.wav"}
ENT.VJ_NPC_Class = {"CLASS_CRACKLIFE"}
ENT.CanUseHD = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	//print(key)
	if key == "event_emit step" or key == "step" then
		self:FootStepSoundCode()
	elseif key == "right" or key == "left" then
		self:MeleeAttackCode()
	elseif key == "shoot" then
		self:RangeAttackCode()
	elseif key == "body" then
		VJ_EmitSound(self, "vj_hlr/crack_fx/bodydrop.wav", 75, 100)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Vort_DoElecEffect(sp, hp, hn, a, t)
	local elec = EffectData()
	elec:SetStart(sp)
	elec:SetOrigin(hp)
	elec:SetNormal(hn)
	elec:SetEntity(self)
	elec:SetAttachment(a)
	elec:SetScale(2.2 - t)
	util.Effect("VJ_HLR_Electric_Charge_Disco", elec)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomRangeAttackCode()
	local startpos = self:GetPos() + self:GetUp()*45 + self:GetForward()*40
	local tr = util.TraceLine({
		start = startpos,
		endpos = self:GetEnemy():GetPos() + self:GetEnemy():OBBCenter(),
		filter = self
	})
	local hitpos = tr.HitPos
	
	local elec = EffectData()
	elec:SetStart(startpos)
	elec:SetOrigin(hitpos)
	elec:SetEntity(self)
	elec:SetAttachment(1)
	util.Effect("VJ_HLR_Electric_Disco",elec)
	
	elec = EffectData()
	elec:SetStart(startpos)
	elec:SetOrigin(hitpos)
	elec:SetEntity(self)
	elec:SetAttachment(2)
	util.Effect("VJ_HLR_Electric_Disco",elec)
	
	util.VJ_SphereDamage(self, self, hitpos, 30, 40, DMG_SHOCK, true, false, {Force=90})
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomGibOnDeathSounds(dmginfo, hitgroup)
	VJ_EmitSound(self, "vj_hlr/crack_fx/bodysplat.wav", 90, 100)
	VJ_EmitSound(self, "vj_gib/default_gib_splat.wav", 90, 100)
	return false
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/