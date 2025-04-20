AddCSLuaFile("shared.lua")
include("shared.lua")
include("entities/npc_vj_hlr1_alienslave/init.lua")
/*-----------------------------------------------
	*** Copyright (c) 2010-2025 by oteek, All rights reserved. ***
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
function ENT:OnRangeAttackExecute(status, enemy, projectile)
	if status == "Init" then
		local startpos = self:GetPos() + self:GetUp()*45 + self:GetForward()*40
		local tr = util.TraceLine({
			start = startpos,
			endpos = enemy:GetPos() + enemy:OBBCenter(),
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
		return true
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2010-2025 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/