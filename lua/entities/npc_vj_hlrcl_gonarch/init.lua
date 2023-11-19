AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2010-2023 by oteek, All rights reserved. ***
	No parts of this code or any of its contselfs may be reproduced, copied, modified or adapted,
	without the prior written consself of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_hlr/cracklife/big_mom.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
local sdCBirth = {"vj_hlr/crack_npc/gonarch/gon_birth1.wav","vj_hlr/crack_npc/gonarch/gon_birth2.wav","vj_hlr/crack_npc/gonarch/gon_birth3.wav"}
local sdCBabyDeath = {"vj_hlr/crack_npc/gonarch/gon_childdie1.wav", "vj_hlr/crack_npc/gonarch/gon_childdie2.wav", "vj_hlr/crack_npc/gonarch/gon_childdie3.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(100, 100, 200), Vector(-100, -100, 0))
	self.Gonarch_NextBirthT = CurTime() + 3
	self.Gonarch_NumBabies = 0
	self.Gonarch_BabyLimit = GetConVar("vj_hlr1_gonarch_babylimit"):GetInt()
	self.SoundTbl_FootStep = {"vj_hlr/crack_npc/gonarch/gon_step1.wav","vj_hlr/crack_npc/gonarch/gon_step2.wav","vj_hlr/crack_npc/gonarch/gon_step3.wav"}
	self.SoundTbl_Idle = {"vj_hlr/crack_npc/gonarch/gon_sack1.wav","vj_hlr/crack_npc/gonarch/gon_sack2.wav","vj_hlr/crack_npc/gonarch/gon_sack3.wav"}
	self.SoundTbl_Alert = {"vj_hlr/crack_npc/gonarch/gon_alert1.wav","vj_hlr/crack_npc/gonarch/gon_alert2.wav","vj_hlr/crack_npc/gonarch/gon_alert3.wav"}
	self.SoundTbl_BeforeMeleeAttack = {"vj_hlr/crack_npc/gonarch/gon_attack1.wav","vj_hlr/crack_npc/gonarch/gon_attack2.wav","vj_hlr/crack_npc/gonarch/gon_attack3.wav"}
	self.SoundTbl_MeleeAttackMiss = {"vj_hlr/hl1_npc/zombie/claw_miss1.wav","vj_hlr/hl1_npc/zombie/claw_miss2.wav"}
	self.SoundTbl_BeforeRangeAttack = {"vj_hlr/crack_npc/gonarch/gon_attack1.wav","vj_hlr/crack_npc/gonarch/gon_attack2.wav","vj_hlr/crack_npc/gonarch/gon_attack3.wav"}
	self.SoundTbl_RangeAttack = {"vj_hlr/crack_npc/gonarch/gon_sack1.wav","vj_hlr/crack_npc/gonarch/gon_sack2.wav","vj_hlr/crack_npc/gonarch/gon_sack3.wav"}
	self.SoundTbl_Pain = {"vj_hlr/crack_npc/gonarch/gon_pain2.wav","vj_hlr/crack_npc/gonarch/gon_pain4.wav","vj_hlr/crack_npc/gonarch/gon_pain5.wav"}
	self.SoundTbl_Death = {"vj_hlr/crack_npc/gonarch/gon_die1.wav"}
	
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	//print(key)
	if key == "Step" then
		util.ScreenShake(self:GetPos(), 10, 100, 0.4, 2000)
		self:FootStepSoundCode()
	end
	if key == "spawn" then -- Create baby headcrabs
		for i = 1,3 do
			VJ_EmitSound(self, sdCBirth, 80)
			if self.Gonarch_NumBabies < self.Gonarch_BabyLimit then -- Default: 20 babies max
				local bCrab = ents.Create("npc_vj_hlr1_headcrab_baby")
				if i == 1 then
					bCrab:SetPos(self:GetPos() + self:GetUp()*20)
				elseif i == 2 then
					bCrab:SetPos(self:GetPos() + self:GetUp()*20 + self:GetRight()*25)
				elseif i == 3 then
					bCrab:SetPos(self:GetPos() + self:GetUp()*20 + self:GetRight()*-25)
				end
				bCrab:SetAngles(self:GetAngles())
				bCrab.BabH_Mother = self
				bCrab:Spawn()
				bCrab:Activate()
				bCrab:SetOwner(self)
				self.Gonarch_NumBabies = self.Gonarch_NumBabies + 1
			end
		end
		self.Gonarch_NextBirthT = CurTime() + 10
	end
	if key == "mattack leftA" or key == "mattack rightA" then -- Hit Ground
		self.MeleeAttackWorldShakeOnMiss = true
		self:MeleeAttackCode()
	elseif key == "mattack leftB" or key == "mattack rightB" then -- Swipe Air
		self.MeleeAttackWorldShakeOnMiss = false
		self:MeleeAttackCode()
	end
	if key == "rattack" then
		self:RangeAttackCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Gonarch_BabyDeath()
	-- Play a sound when one of the babies dies!
	self.Gonarch_NumBabies = self.Gonarch_NumBabies - 1
	if CurTime() > self.Gonarch_NextDeadBirthT then
		self.AllyDeathSoundT = 0
		self:PlaySoundSystem("AllyDeath", sdCBabyDeath)
		self.Gonarch_NextDeadBirthT = CurTime() + 10
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomGibOnDeathSounds(dmginfo,hitgroup)
	VJ_EmitSound(self,"vj_hlr/crack_fx/bodysplat.wav", 90, math.random(100,100))
	VJ_EmitSound(self, "vj_gib/default_gib_splat.wav", 90, math.random(100,100))
	return false
end
/*-----------------------------------------------
	*** Copyright (c) 2010-2023 by oteek, All rights reserved. ***
	No parts of this code or any of its contselfs may be reproduced, copied, modified or adapted,
	without the prior written consself of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/