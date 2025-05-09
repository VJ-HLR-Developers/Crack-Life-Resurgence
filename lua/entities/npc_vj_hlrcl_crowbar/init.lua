include("entities/npc_vj_hlr1_xen_tree/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2010-2025 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_hlr/cracklife/tree.mdl" -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.SightDistance = 300

ENT.MeleeAttackDamage = 60
ENT.MeleeAttackDistance = 160 -- How close an enemy has to be to trigger a melee attack | false = Let the base auto calculate on initialize based on the NPC's collision bounds
ENT.MeleeAttackAngleRadius = 15 -- What is the attack angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC

ENT.BloodColor = ""
ENT.HasBloodParticle = false
ENT.HasCollisionDecal = false

---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.SoundTbl_MeleeAttack = {"vj_hlr/crack_npc/crowbar/cbar_hitbod1.wav","vj_hlr/crack_npc/crowbar/cbar_hitbod2.wav","vj_hlr/crack_npc/crowbar/cbar_hitbod3.wav"}
	self.SoundTbl_MeleeAttackMiss = {"vj_hlr/crack_npc/crowbar/cbar_hit1.wav","vj_hlr/crack_npc/crowbar/cbar_hit2.wav"}
	self.SoundTbl_BeforeMeleeAttack = {"vj_hlr/crack_npc/crowbar/cbar_miss1.wav"}
	self:SetCollisionBounds(Vector(25, 25, 190), Vector(-25, -25, 0))
	self:AddFlags(FL_NOTARGET)
end
---------------------------------------------------------------------------------------------------------------------------------------------
local vec = Vector(0, 0, 0)
--
function ENT:CustomOnTakeDamage_BeforeImmuneChecks(dmginfo, hitgroup)
	if dmginfo:GetDamagePosition() != vec then
		local rico = EffectData()
		rico:SetOrigin(dmginfo:GetDamagePosition())
		rico:SetScale(4) -- Size
		rico:SetMagnitude(math.random(1, 2)) -- Effect type | 1 = Animated | 2 = Basic
		util.Effect("VJ_HLR_Rico", rico)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_AfterChecks(hitEnt) end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeImmuneChecks(dmginfo, hitgroup)
	if !dmginfo:IsDamageType(DMG_BLAST) then
		dmginfo:SetDamage(0)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local gibsCollideSd = {"vj_hlr/gsrc/fx/metal1.wav","vj_hlr/gsrc/fx/metal2.wav","vj_hlr/gsrc/fx/metal3.wav","vj_hlr/gsrc/fx/metal4.wav","vj_hlr/gsrc/fx/metal5.wav"}
--
function ENT:HandleGibOnDeath(dmginfo, hitgroup)
	self.HasDeathSounds = false
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p1.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,5)),CollideSound=gibsCollideSd})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p2.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,10)),CollideSound=gibsCollideSd})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p3.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,20)),CollideSound=gibsCollideSd})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p4.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,30)),CollideSound=gibsCollideSd})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p5.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound=gibsCollideSd})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p6.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,45)),CollideSound=gibsCollideSd})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p7.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,55)),CollideSound=gibsCollideSd})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p8.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,65)),CollideSound=gibsCollideSd})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p9.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,85)),CollideSound=gibsCollideSd})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p10.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,100)),CollideSound=gibsCollideSd})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p11.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,120)),CollideSound=gibsCollideSd})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p1.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,5)),CollideSound=gibsCollideSd})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p2.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,10)),CollideSound=gibsCollideSd})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p3.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,20)),CollideSound=gibsCollideSd})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p4.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,30)),CollideSound=gibsCollideSd})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p5.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound=gibsCollideSd})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p6.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,45)),CollideSound=gibsCollideSd})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p7.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,55)),CollideSound=gibsCollideSd})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p8.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,65)),CollideSound=gibsCollideSd})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p9.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,85)),CollideSound=gibsCollideSd})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p10.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,100)),CollideSound=gibsCollideSd})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/metalgib_p11.mdl",{CollisionDecal=false,Pos=self:LocalToWorld(Vector(0,0,120)),CollideSound=gibsCollideSd})
	self:PlaySoundSystem("Gib", "vj_hlr/gsrc/npc/rgrunt/rb_gib.wav")
	self:PlaySoundSystem("Gib", "vj_hlr/crack_fx/bodysplat.wav")
	return true, {AllowSound = false}
end