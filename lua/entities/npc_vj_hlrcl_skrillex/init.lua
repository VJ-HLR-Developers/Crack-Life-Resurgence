AddCSLuaFile("shared.lua")
include("shared.lua")
include("entities/npc_vj_hlr1_alienslave/init.lua")
/*-----------------------------------------------
	*** Copyright (c) 2010-2025 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/

-- TODO: make the skrillex recorders rise out of the ground with a sound effect

ENT.Model = {"models/vj_hlr/cracklife/skrillex.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.VJ_NPC_Class = {"CLASS_CRACKLIFE_CHAV"}
ENT.StartHealth = 3000

ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.CustomBlood_Particle = {"vj_hlr_blood_red"}
ENT.CustomBlood_Decal = {"VJ_HLR_Blood_Red"}

ENT.EntitiesToNoCollide = {"npc_vj_hlrcl_gopnik","npc_vj_hlrcl_gopnik_mega","npc_vj_hlrcl_gopnik_super"}

ENT.DisableWandering = true
ENT.DisableChasingEnemy = true

ENT.RangeToMeleeDistance = 0
ENT.NextRangeAttackTime = 5
ENT.RangeDistance = 1000

ENT.VJC_Data = {
    ThirdP_Offset = Vector(-5, 0, -15), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "Bip02 Head", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(5, 0, 5), -- The offset for the controller when the camera is in first person
}
ENT.VJ_IsHugeMonster = true

ENT.HasMeleeAttack = false
ENT.HasRangeAttack = false

ENT.HasSoundTrack = true
ENT.HasIdleDialogueSounds = false
ENT.HasIdleDialogueAnswerSounds = false
ENT.HasIdleSounds = false
ENT.HasPainSounds = false
ENT.HasAlertSounds = false

ENT.SoundTbl_FootStep = {"vj_hlr/crack_fx/npc_step1.wav","vj_hlr/crack_fx/npc_step2.wav","vj_hlr/crack_fx/npc_step3.wav","vj_hlr/crack_fx/npc_step4.wav"}
ENT.SoundTbl_SoundTrack = {"vj_hlr/crack_npc/skrillex/skrillexbattle.mp3"}
ENT.SoundTbl_BeforeRangeAttack = {"vj_hlr/crack_npc/skrillex/charge.wav"}
ENT.SoundTbl_RangeAttack = {"vj_hlr/crack_npc/skrillex/fire.wav"}
ENT.RangeAttackPitch = VJ_Set(100, 100)
-- Custom --
ENT.RadiosDestroyed = false
ENT.RadiosSpawned = false
ENT.SpawnHat = true
ENT.CanUseHD = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.SoundTbl_Death = {"vj_hlr/crack_npc/skrillex/skrillexbossdie.wav"}
	self.AnimTbl_Death = {ACT_DIESIMPLE}
	self:AddFlags(FL_NOTARGET)
	if GetConVar("vj_hlrcl_allyspawn_skrillex"):GetInt() == 1 then
		timer.Create("skrillex_spawngops"..self:EntIndex(), 3, 0, function()
			if IsValid(self) then
				self:F_SpawnAlly()
			end
		end)
	end
	-- Radios
	timer.Create("skrillyd_spawnradios"..self:EntIndex(), 1, 1, function()
		for i = 1, 2 do
			local trF = util.TraceLine({
				start = self:GetPos() + self:GetUp() * 170,
				endpos = (self:GetPos() + self:GetUp() * 170) + self:GetForward() * math.Rand(-10000, 10000) + self:GetRight() * math.Rand(-10000, 10000) + self:GetUp() * -3000,
				filter = {self, self.Radio1},
			})
			local tr = util.TraceLine({
				start = trF.HitPos,
				endpos = trF.HitPos + Vector(0, 0, -3000),
				filter = {self, self.Radio1},
			})
			-- HitNormal = Number between 0 to 1, use this to get the position the trace came from. Ex: Add it to the hit position to make it go farther away.
			local radio = ents.Create("sent_vj_hlrcl_recorder_huge")
			radio:SetPos(tr.HitPos) -- Take the HitNormal and minus it by 10 units to make it go inside the position a bit
			radio:SetAngles(tr.HitNormal:Angle() + Angle(math.Rand(60, 120), math.Rand(-15, 15), math.Rand(-15, 15))) -- 90 = middle and 30 degree difference to make the pitch rotate randomly | yaw and roll are applied a bit of a random number
			radio.Assignee = self
			radio:Spawn()
			radio:Activate()
			radio.VJ_NPC_Class = self.VJ_NPC_Class
			
			if i == 1 then
				self.Radio1 = radio
			elseif i == 2 then
				self.Radio2 = radio
			end
		end
		self.RadiosSpawned = true
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	if self.RadiosDestroyed == false && self.RadiosSpawned == true && !IsValid(self.Radio1) && !IsValid(self.Radio2) then
		self.RadiosDestroyed = true
		self.HasRangeAttack = true
		VJ_EmitSound(self, "vj_hlr/crack_npc/skrillex/earrape.wav", 120)
		self.DisableWandering = false
		self.DisableChasingEnemy = false
		self:RemoveFlags(FL_NOTARGET)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)
	if self.RadiosDestroyed == false then 
		dmginfo:SetDamage(0)
		if dmginfo:GetDamagePosition() != vec then
		local rico = EffectData()
		rico:SetOrigin(dmginfo:GetDamagePosition())
		rico:SetScale(5) -- Size
		rico:SetMagnitude(math.random(1, 2)) -- Effect type | 1 = Animated | 2 = Basic
		util.Effect("VJ_HLR_Rico", rico)
	return end
end end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	//print(key)
	if key == "step" then
		self:FootStepSoundCode()
	elseif key == "shoot" then
		self:RangeAttackCode()
	//elseif key == "spawn" then
	//	if GetConVar("vj_hlrcl_allyspawn_skrillex"):GetInt() == 1 then
	//		self:F_SpawnAlly()
	//	end
	elseif key == "body" then
		VJ_EmitSound(self, "vj_hlr/crack_fx/bodydrop.wav", 75, 100)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:F_CreateAlly()
		local type = "npc_vj_hlrcl_gopnik"
		local tr = util.TraceLine({
			start = self:GetPos(),
			endpos = self:GetPos() + self:GetForward() * math.Rand(-500, 500) + self:GetRight() * math.Rand(-500, 500) + self:GetUp() * 40,
			filter = {self, type},
			mask = MASK_ALL,
		})
		local spawnpos = tr.HitPos + tr.HitNormal*30
		local randChav = math.random(1,150)
		if randChav < 2 then
			type = "npc_vj_hlrcl_gopnik_mega"
		elseif randChav > 1 && randChav < 35 then
			type = "npc_vj_hlrcl_gopnik_super"
		end
		local ally = ents.Create(type)
		ally:SetPos(spawnpos)
		ally:SetAngles(self:GetAngles())
		ally:Spawn()
		ally:Activate()
		ally.VJ_NPC_Class = self.VJ_NPC_Class
		//ally:SetMaxHealth(ally:GetHealth() + 100)
		//ally:SetHealth(ally:GetHealth() + 100)
		
		local effectTeleport = VJ.HLR_Effect_Portal(spawnpos + Vector(0,0,20))
		effectTeleport:Fire("Kill","",1)
		
		return ally
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:F_SpawnAlly()
	-- Can have a total of 3, only 1 can be spawned at a time with a delay until another one is spawned
		if !IsValid(self.ChavAlly1) then
			self.ChavAlly1 = self:F_CreateAlly()
			return 15
		elseif !IsValid(self.ChavAlly2) then
			self.ChavAlly2 = self:F_CreateAlly()
			return 15
		elseif !IsValid(self.ChavAlly3) then
			self.ChavAlly3 = self:F_CreateAlly()
			return 15
		end
		return 8
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
	util.Effect("VJ_HLR_Electric_Charge_Skrilly", elec)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRangeAttack_AfterStartTimer()
	local myPos = self:GetPos()
	-- Tsakh --------------------------
	local tsakhSpawn = myPos + self:GetUp()*45 + self:GetRight()*20
	local tsakhLocations = {
		myPos + self:GetRight()*math.Rand(150, 500) + self:GetUp()*-200,
		myPos + self:GetRight()*math.Rand(150, 500) + self:GetUp()*-200 + self:GetForward()*-math.Rand(150, 500),
		myPos + self:GetRight()*math.Rand(150, 500) + self:GetUp()*-200 + self:GetForward()*math.Rand(150, 500),
		myPos + self:GetRight()*math.Rand(1, 150) + self:GetUp()*200 + self:GetForward()*math.Rand(-100, 100),
	}
	for i = 1, 4 do
		local randt = math.Rand(0, 0.6)
		timer.Simple(randt,function()
			if IsValid(self) then
				local tr = util.TraceLine({
					start = tsakhSpawn,
					endpos = tsakhLocations[i],
					filter = self
				})
				if tr.Hit == true then self:Vort_DoElecEffect(tr.StartPos, tr.HitPos, tr.HitNormal, 1, randt) end
			end
		end)
	end
	-- Ach --------------------------
	local achSpawn = myPos + self:GetUp()*45 + self:GetRight()*-20
	local achLocations = {
		myPos + self:GetRight()*-math.Rand(150, 500) + self:GetUp()*-200,
		myPos + self:GetRight()*-math.Rand(150, 500) + self:GetUp()*-200 + self:GetForward()*-math.Rand(150, 500),
		myPos + self:GetRight()*-math.Rand(150, 500) + self:GetUp()*-200 + self:GetForward()*math.Rand(150, 500),
		myPos + self:GetRight()*-math.Rand(1, 150) + self:GetUp()*200 + self:GetForward()*math.Rand(-100, 100),
	}
	for i = 1, 4 do
		local randt = math.Rand(0, 0.6)
		timer.Simple(randt,function()
			if IsValid(self) then
				local tr = util.TraceLine({
					start = achSpawn,
					endpos = achLocations[i],
					filter = self
				})
				if tr.Hit == true then self:Vort_DoElecEffect(tr.StartPos, tr.HitPos, tr.HitNormal, 1, randt) end
			end
		end)
	end
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
	util.Effect("VJ_HLR_Electric_Skrilly",elec)
	
	elec = EffectData()
	elec:SetStart(startpos)
	elec:SetOrigin(hitpos)
	elec:SetEntity(self)
	elec:SetAttachment(2)
	util.Effect("VJ_HLR_Electric_Skrilly",elec)
	
	util.VJ_SphereDamage(self, self, hitpos, 30, 100, DMG_SHOCK, true, false, {Force=90})
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:HandleGibOnDeath(dmginfo, hitgroup)
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
function ENT:CustomOnRemove()
	timer.Remove("skrillyd_spawnradios"..self:EntIndex())
	timer.Remove("skrillex_spawngops"..self:EntIndex())
	if IsValid(self.Radio1) then self.Radio1:Remove() end
	if IsValid(self.Radio2) then self.Radio2:Remove() end
	
	-- Remove allies if we were removed without being killed
	if !self.Dead then
		if IsValid(self.ChavAlly1) then self.ChavAlly1:Remove() end
		if IsValid(self.ChavAlly2) then self.ChavAlly2:Remove() end
		if IsValid(self.ChavAlly3) then self.ChavAlly3:Remove() end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPriorToKilled(dmginfo, hitgroup)
	--print("test")
	if self.SpawnHat == true then
		self:SetBodygroup(1,1)
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/cracklife/mac.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,0)),CollideSound={""}})
		self.SpawnHat = false
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomGibOnDeathSounds(dmginfo, hitgroup)
	VJ_EmitSound(self,"vj_hlr/crack_fx/bodysplat.wav", 90, math.random(100,100))
	VJ_EmitSound(self, "vj_base/gib/splat.wav", 90, 100)
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, corpseEnt)
	VJ.HLR_ApplyCorpseSystem(self, corpseEnt, nil)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomDeathAnimationCode(dmginfo, hitgroup)
	-- bro just don't do anything when headshot it's that simple
end
/*-----------------------------------------------
	*** Copyright (c) 2010-2025 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/