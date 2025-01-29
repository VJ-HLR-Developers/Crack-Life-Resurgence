AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2010-2024 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_hlr/cracklife/garg_viking.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 1000
ENT.HullType = HULL_HUMAN
ENT.VJ_IsHugeMonster = true -- Is this a huge monster?
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_CRACKLIFE"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.CustomBlood_Particle = {"vj_hlr_blood_yellow_large"}
ENT.CustomBlood_Decal = {"VJ_HLR_Blood_Yellow"} -- Decals to spawn when it's damaged
ENT.HasBloodPool = false -- Does it have a blood pool?

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDamage = 90 -- How close an enemy has to be to trigger a melee attack | false = Let the base auto calculate on initialize based on the NPC's collision bounds
ENT.MeleeAttackDamageType = DMG_CRUSH -- How close an enemy has to be to trigger a melee attack | false = Let the base auto calculate on initialize based on the NPC's collision bounds
ENT.MeleeAttackDistance = 65 -- How close an enemy has to be to trigger a melee attack | false = Let the base auto calculate on initialize based on the NPC's collision bounds
ENT.MeleeAttackDamageDistance = 165 -- How far does the damage go | false = Let the base auto calculate on initialize based on the NPC's collision bounds
ENT.MeleeAttackKnockBack_Forward1 = 500 -- How far it will push you forward | First in math.random
ENT.MeleeAttackKnockBack_Forward2 = 500 -- How far it will push you forward | Second in math.random

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.RangeAttackEntityToSpawn = "obj_vj_hlr1_garg_stomp" -- The entity that is spawned when range attacking
ENT.RangeDistance = 2000 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 65 -- How close does it have to be until it uses melee?
ENT.TimeUntilRangeAttackProjectileRelease = false -- How much time until the projectile code is ran?
ENT.RangeAttackPos_Up = 10 -- Up/Down spawning position for range attack
ENT.RangeAttackPos_Forward = 50 -- Forward/Backward spawning position for range attack
ENT.RangeAttackPos_Right = -20 -- Right/Left spawning position for range attack

ENT.HasWorldShakeOnMove = true -- Should the world shake when it's moving?
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events
ENT.GibOnDeathDamagesTable = {"All"} -- Damages that it gibs from | "UseDefault" = Uses default damage types | "All" = Gib from any damage
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.DeathAnimationTime = 3.7 -- Time until the SNPC spawns its corpse and gets removed
ENT.AnimTbl_Death = ACT_DIESIMPLE -- Death Animations
	-- ====== Flinching Variables ====== --
ENT.CanFlinch = 2 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchDamageTypes = {DMG_BLAST} -- If it uses damage-based flinching, which types of damages should it flinch from?
ENT.FlinchChance = 2 -- Chance of it flinching from 1 to x | 1 will make it always flinch
ENT.AnimTbl_Flinch = ACT_BIG_FLINCH -- If it uses normal based animation, use this
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"vj_hlr/hl1_npc/garg/gar_step1.wav","vj_hlr/hl1_npc/garg/gar_step2.wav"}
ENT.SoundTbl_Idle = {"vj_hlr/crack_npc/garg_viking/gar_breathe1.wav","vj_hlr/crack_npc/garg_viking/gar_breathe2.wav","vj_hlr/crack_npc/garg_viking/gar_breathe3.wav","vj_hlr/crack_npc/garg_viking/gar_idle1.wav","vj_hlr/crack_npc/garg_viking/gar_idle2.wav","vj_hlr/crack_npc/garg_viking/gar_idle3.wav","vj_hlr/crack_npc/garg_viking/gar_idle4.wav","vj_hlr/crack_npc/garg_viking/gar_idle5.wav"}
ENT.SoundTbl_Alert = {"vj_hlr/crack_npc/garg_viking/gar_alert1.wav","vj_hlr/crack_npc/garg_viking/gar_alert2.wav","vj_hlr/crack_npc/garg_viking/gar_alert3.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"vj_hlr/crack_npc/garg_viking/gar_attack1.wav","vj_hlr/crack_npc/garg_viking/gar_attack2.wav","vj_hlr/crack_npc/garg_viking/gar_attack3.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"vj_hlr/hl1_npc/zombie/claw_strike1.wav","vj_hlr/hl1_npc/zombie/claw_strike2.wav","vj_hlr/hl1_npc/zombie/claw_strike3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_hlr/hl1_npc/zombie/claw_miss1.wav","vj_hlr/hl1_npc/zombie/claw_miss2.wav"}
ENT.SoundTbl_Pain = {"vj_hlr/crack_npc/garg_viking/gar_pain1.wav","vj_hlr/crack_npc/garg_viking/gar_pain2.wav","vj_hlr/crack_npc/garg_viking/gar_pain3.wav"}
ENT.SoundTbl_Death = {"vj_hlr/crack_npc/garg_viking/gar_die1.wav","vj_hlr/crack_npc/garg_viking/gar_die2.wav"}

ENT.GeneralSoundPitch1 = 100
ENT.ExtraMeleeSoundPitch1 = 80
ENT.ExtraMeleeSoundPitch2 = 80
ENT.IdleSoundLevel = 100
ENT.AlertSoundLevel = 100
ENT.PainSoundLevel = 100
ENT.DeathSoundLevel = 100

ENT.Garg_NextStompAttackT = 0
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(70,70,210),Vector(-70,-70,0))
	
	self.Glow1 = ents.Create("env_sprite")
	self.Glow1:SetKeyValue("model","vj_hl/sprites/gargeye1.vmt")
	self.Glow1:SetKeyValue("GlowProxySize","2.0") -- Size of the glow to be rendered for visibility testing.
	self.Glow1:SetKeyValue("renderfx","14")
	self.Glow1:SetKeyValue("rendermode","3") -- Set the render mode to "3" (Glow)
	self.Glow1:SetKeyValue("disablereceiveshadows","0") -- Disable receiving shadows
	self.Glow1:SetKeyValue("spawnflags","0")
	self.Glow1:SetParent(self)
	self.Glow1:Fire("SetParentAttachment","eyes")
	self.Glow1:Spawn()
	self.Glow1:Activate()
	self:DeleteOnRemove(self.Glow1)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	//print(key)
	if key == "step" then
		self:FootStepSoundCode()
	end
	if key == "melee" or key == "kick" then
		self:MeleeAttackCode()
	end
	if key == "laser" then
		self:RangeAttackCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	local r = math.random(1,3)
	if r == 1 then
		self.AnimTbl_MeleeAttack = {"vjseq_smash"}
		self.HasMeleeAttackKnockBack = false
	elseif r == 2 then
		self.AnimTbl_MeleeAttack = {"vjseq_attack"}
		self.HasMeleeAttackKnockBack = true
		self.MeleeAttackKnockBack_Up1 = 10
		self.MeleeAttackKnockBack_Up2 = 10
	elseif r == 3 then
		self.AnimTbl_MeleeAttack = {"vjseq_kickcar"}
		self.HasMeleeAttackKnockBack = true
		self.MeleeAttackKnockBack_Up1 = 300
		self.MeleeAttackKnockBack_Up2 = 300
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPriorToKilled(dmginfo,hitgroup)
	for i = 0.3, 3.5, 0.5 do
		timer.Simple(i,function()
			if IsValid(self) then
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
				spr:SetKeyValue("scale","6")
				spr:SetPos(self:GetPos() + self:GetUp()*math.random(120,200))
				spr:Spawn()
				spr:Fire("Kill","",0.9)
				
				util.BlastDamage(self,self,self:GetPos(),150,50)
				util.ScreenShake(self:GetPos(),100,200,1,2500)
				VJ_EmitSound(self,{"vj_hlr/hl1_weapon/explosion/explode3.wav","vj_hlr/hl1_weapon/explosion/explode4.wav","vj_hlr/hl1_weapon/explosion/explode5.wav"}, 90, math.random(100,100))
			end
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeImmuneChecks(dmginfo,hitgroup)
	local rico = EffectData()
	rico:SetOrigin(dmginfo:GetDamagePosition())
	rico:SetScale(5) -- Size
	rico:SetMagnitude(math.random(1, 2)) -- Effect type | 1 = Animated | 2 = Basic
	util.Effect("VJ_HLR_Rico", rico)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:HandleGibOnDeath(dmginfo,hitgroup)
	timer.Simple(3.6,function()
		if IsValid(self) then
			if self.HasGibDeathParticles == true then
				local bloodeffect = EffectData()
				bloodeffect:SetOrigin(self:GetPos() +self:OBBCenter())
				bloodeffect:SetColor(VJ_Color2Byte(Color(255,221,35)))
				bloodeffect:SetScale(120)
				util.Effect("VJ_Blood1",bloodeffect)
				
				local bloodspray = EffectData()
				bloodspray:SetOrigin(self:GetPos() +self:OBBCenter())
				bloodspray:SetScale(8)
				bloodspray:SetFlags(3)
				bloodspray:SetColor(1)
				util.Effect("bloodspray",bloodspray)
				util.Effect("bloodspray",bloodspray)
				
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
				spr:SetKeyValue("scale","6")
				spr:SetPos(self:GetPos() + self:GetUp()*150)
				spr:Spawn()
				spr:Fire("Kill","",0.9)
				timer.Simple(0.9,function() if IsValid(spr) then spr:Remove() end end)
			end
			
			util.BlastDamage(self,self,self:GetPos(),150,80)
			util.ScreenShake(self:GetPos(),100,200,1,2500)
			
			VJ_EmitSound(self,{"vj_hlr/hl1_weapon/explosion/explode3.wav","vj_hlr/hl1_weapon/explosion/explode4.wav","vj_hlr/hl1_weapon/explosion/explode5.wav"}, 90, math.random(100,100))
			VJ_EmitSound(self, "vj_base/gib/splat.wav", 90, math.random(100,100))
			
			util.Decal("VJ_HLR_Scorch", self:GetPos(), self:GetPos() + self:GetUp()*-100, self)
			
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib1.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,40))})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib2.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,20))})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib3.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,30))})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib4.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,35))})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib1.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,100))})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib2.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,100))})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib3.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,100))})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib4.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,100))})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib1.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,100))})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib2.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,100))})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib3.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,100))})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib4.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,100))})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib5.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,50))})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib6.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,55))})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib7.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,40))})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib8.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,45))})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib9.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,25))})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib10.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,15))})
			
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p1.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p2.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p3.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,50)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p4.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p5.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p6.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,100)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p7.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,100)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p8.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,100)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p9.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,100)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p10.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,100)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p11.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,100)),CollideSound={"vj_hlr/fx/metal1.wav","vj_hlr/fx/metal2.wav","vj_hlr/fx/metal3.wav","vj_hlr/fx/metal4.wav","vj_hlr/fx/metal5.wav"}})
			util.BlastDamage(self,self,self:GetPos(),150,20) -- To make the gibs FLY
		end
	end)
	return true, {DeathAnim=true}-- Return to true if it gibbed!
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomGibOnDeathSounds(dmginfo,hitgroup)
	return false
end
/*-----------------------------------------------
	*** Copyright (c) 2010-2024 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/