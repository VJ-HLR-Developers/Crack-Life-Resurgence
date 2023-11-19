AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2010-2023 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_hlr/cracklife/german1.mdl","models/vj_hlr/cracklife/german2.mdl","models/vj_hlr/cracklife/german3.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.HullType = HULL_HUMAN
ENT.VJ_NPC_Class = {"CLASS_CRACKLIFE_GERMAN"} -- NPCs with the same class with be allied to each other

ENT.RangeDistance = 3020 -- This is how far away it can shoot
ENT.MeleeAttackDistance = 20 -- How close does it have to be until it attacks?

ENT.VJC_Data = {
    ThirdP_Offset = Vector(-5, 0, -15), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "Bip01 Head", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(5, 0, 5), -- The offset for the controller when the camera is in first person
}
ENT.StartHealth = 80
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.CustomBlood_Particle = {"vj_hlr_blood_red"}
ENT.CustomBlood_Decal = {"VJ_HLR_Blood_Red"}

ENT.AnimTbl_Death = {ACT_DIEBACKWARD,ACT_DIEFORWARD,ACT_DIESIMPLE,ACT_DIE_GUTSHOT} -- Death Animations
ENT.NextRangeAttackTime = 0
ENT.SpawnHat = true
ENT.CanUseHD = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.SoundTbl_FootStep = {"vj_hlr/crack_fx/npc_step1.wav","vj_hlr/crack_fx/npc_step2.wav","vj_hlr/crack_fx/npc_step3.wav","vj_hlr/crack_fx/npc_step4.wav"}
	self.SoundTbl_BeforeRangeAttack = {""}
	self.SoundTbl_RangeAttack = {""}
	self.SoundTbl_Idle = {"vj_hlr/crack_npc/germansoldier/slv_word1.wav","vj_hlr/crack_npc/germansoldier/slv_word2.wav","vj_hlr/crack_npc/germansoldier/slv_word3.wav","vj_hlr/crack_npc/germansoldier/slv_word4.wav","vj_hlr/crack_npc/germansoldier/slv_word5.wav","vj_hlr/crack_npc/germansoldier/slv_word6.wav","vj_hlr/crack_npc/germansoldier/slv_word7.wav","vj_hlr/crack_npc/germansoldier/slv_word8.wav"}
	self.SoundTbl_IdleDialogue = {"vj_hlr/crack_npc/germansoldier/slv_word1.wav","vj_hlr/crack_npc/germansoldier/slv_word2.wav","vj_hlr/crack_npc/germansoldier/slv_word3.wav","vj_hlr/crack_npc/germansoldier/slv_word4.wav","vj_hlr/crack_npc/germansoldier/slv_word5.wav","vj_hlr/crack_npc/germansoldier/slv_word6.wav","vj_hlr/crack_npc/germansoldier/slv_word7.wav","vj_hlr/crack_npc/germansoldier/slv_word8.wav"}
	self.SoundTbl_IdleDialogueAnswer = {"vj_hlr/crack_npc/germansoldier/slv_word1.wav","vj_hlr/crack_npc/germansoldier/slv_word2.wav","vj_hlr/crack_npc/germansoldier/slv_word3.wav","vj_hlr/crack_npc/germansoldier/slv_word4.wav","vj_hlr/crack_npc/germansoldier/slv_word5.wav","vj_hlr/crack_npc/germansoldier/slv_word6.wav","vj_hlr/crack_npc/germansoldier/slv_word7.wav","vj_hlr/crack_npc/germansoldier/slv_word8.wav"}
	self.SoundTbl_Alert = {"vj_hlr/crack_npc/germansoldier/slv_alert1.wav","vj_hlr/crack_npc/germansoldier/slv_alert2.wav","vj_hlr/crack_npc/germansoldier/slv_alert4.wav"}
	self.SoundTbl_Pain = {"vj_hlr/crack_npc/germansoldier/slv_pain1.wav"}
	self.SoundTbl_Death = {"vj_hlr/crack_npc/germansoldier/slv_die1.wav","vj_hlr/crack_npc/germansoldier/slv_die2.wav"}
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	//print(key)
	if key == "event_emit step" or key == "step" then
		self:FootStepSoundCode()
	elseif key == "right" or key == "left" then
		self:MeleeAttackCode()
	elseif key == "shoot" then
		self:RangeAttackCode()
		VJ_EmitSound(self, "vj_hlr/hl1_npc/hassault/hw_shoot1.wav", 75, 150)
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
	util.Effect("VJ_HLR_Electric_Charge", elec)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRangeAttack_AfterStartTimer() end
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
	util.Effect("VJ_HLR_Electric",elec)
	
	elec = EffectData()
	elec:SetStart(startpos)
	elec:SetOrigin(hitpos)
	elec:SetEntity(self)
	elec:SetAttachment(2)
	util.Effect("VJ_HLR_Electric",elec)
	
	util.VJ_SphereDamage(self, self, hitpos, 30, 10, DMG_SHOCK, true, false, {Force=90})
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnSchedule()
	if !self.Dead && self.Vort_RunAway == true && !self:IsBusy() && !self.VJ_IsBeingControlled then
		self.Vort_RunAway = false
		self:VJ_TASK_COVER_FROM_ENEMY("TASK_RUN_PATH",function(x) x.RunCode_OnFail = function() self.NextDoAnyAttackT = 0 end end)
		self.NextDoAnyAttackT = CurTime() + 5
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_AfterDamage(dmginfo, hitgroup)
	if (self.NextDoAnyAttackT + 2) > CurTime() then return end
	self.Vort_RunAway = true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo, hitgroup)
	self.HasDeathSounds = false
	if self.HasGibDeathParticles == true then
		local bloodeffect = EffectData()
		bloodeffect:SetOrigin(self:GetPos() + self:OBBCenter())
		bloodeffect:SetColor(VJ_Color2Byte(Color(130,19,10)))
		bloodeffect:SetScale(120)
		util.Effect("VJ_Blood1",bloodeffect)
		
		local bloodspray = EffectData()
		bloodspray:SetOrigin(self:GetPos())
		bloodspray:SetScale(8)
		bloodspray:SetFlags(3)
		bloodspray:SetColor(0)
		util.Effect("bloodspray",bloodspray)
		util.Effect("bloodspray",bloodspray)
		
	end
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh1.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh2.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh3.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh4.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_b_bone.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,50))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_b_gib.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_guts.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_hmeat.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,45))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_lung.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,45))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_skull.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,60))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_legbone.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,15))})
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomGibOnDeathSounds(dmginfo, hitgroup)
	VJ_EmitSound(self,"vj_hlr/crack_fx/bodysplat.wav", 90, math.random(100,100))
	VJ_EmitSound(self, "vj_gib/default_gib_splat.wav", 90, 100)
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomDeathAnimationCode(dmginfo, hitgroup)
	if hitgroup == HITGROUP_HEAD then
		self.AnimTbl_Death = {ACT_DIE_HEADSHOT}
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, corpseEnt)
	VJ.HLR_ApplyCorpseSystem(self, corpseEnt, nil)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPriorToKilled(dmginfo, hitgroup)
	if self.SpawnHat == true then
		self:SetBodygroup(1,1)
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/cracklife/w_mp44.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,0)),CollideSound={""}})
		self.SpawnHat = false
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomDeathAnimationCode(dmginfo, hitgroup)
	if hitgroup == HITGROUP_HEAD then
		self.AnimTbl_Death = {ACT_DIE_GUTSHOT,ACT_DIE_HEADSHOT}
	else
		self.AnimTbl_Death = {ACT_DIEBACKWARD,ACT_DIEFORWARD,ACT_DIESIMPLE}
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2010-2023 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/