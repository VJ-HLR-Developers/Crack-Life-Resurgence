AddCSLuaFile()

---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base = "weapon_vj_base"
SWEP.PrintName = "Tec-9"
SWEP.Author = "oteek"
SWEP.Contact = "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose = "This weapon is made for NPCs"
SWEP.Instructions = "Controls are like a regular weapon."
SWEP.Category = "VJ Base"
	-- NPC Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.NPC_NextPrimaryFire = 0.8 -- Next time it can use primary fire
SWEP.NPC_ReloadSound = {"vj_hlr/hl1_weapon/glock/glock_reload.wav"} -- Sounds it plays when the base detects the SNPC playing a reload animation
SWEP.NPC_CanBePickedUp = false -- Can this weapon be picked up by NPCs? (Ex: Rebels)
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.MadeForNPCsOnly = true -- Is this weapon meant to be for NPCs only?
SWEP.WorldModel = "models/vj_hlr/cracklife/w_tec9.mdl"
SWEP.HoldType = "pistol"
SWEP.Spawnable = false
SWEP.AdminSpawnable = false
	-- World Model ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel_Invisible = false -- Should the world model be invisible?
SWEP.WorldModel_UseCustomPosition = true -- Should the gun use custom position? This can be used to fix guns that are in the crotch
SWEP.WorldModel_CustomPositionAngle = Vector(0, 0, 0)
SWEP.WorldModel_CustomPositionOrigin = Vector(0, 0, 0)
SWEP.WorldModel_CustomPositionBone = "Bip01 R Hands" -- The bone it will use as the main point
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage = 5 -- Damage
SWEP.Primary.ClipSize = 17 -- Max amount of bullets per clip
SWEP.Primary.Ammo = "SMG1" -- Ammo type
SWEP.Primary.Sound = {"vj_hlr/crack_npc/bigsmoke/fire1.wav"}
SWEP.PrimaryEffects_ShellType = "VJ_Weapon_PistolShell1"
SWEP.Primary.TracerType = "VJ_HLR_Tracer"

-- Custom
SWEP.HLR_ValidModels = {"models/vj_hlr/cracklife/bigsmoke.mdl"}
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnInitialize()
	timer.Simple(0.1,function() -- Minag mikani modelner tske, yete ooresh model-e, serpe as zenke
		if IsValid(self) && IsValid(self:GetOwner()) then
			if !VJ_HasValue(self.HLR_ValidModels,self:GetOwner():GetModel()) then
				if IsValid(self:GetOwner():GetCreator()) then
					self:GetOwner():GetCreator():PrintMessage(HUD_PRINTTALK,self.PrintName.." removed! It's made for specific NPCs only!")
				end
				self:Remove()
			else
				self.NPC_NextPrimaryFire = false
			end
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnDrawWorldModel() -- This is client only!
	if IsValid(self:GetOwner()) then
		self.WorldModel_Invisible = true
		return false
	else
		self.WorldModel_Invisible = false
		return true -- return false to not draw the world model
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnPrimaryAttackEffects()
	self.PrimaryEffects_MuzzleFlash = false
	local muz = ents.Create("env_sprite")
	muz:SetKeyValue("model","vj_hl/sprites/muzzleflash2.vmt")
	muz:SetKeyValue("scale",""..math.Rand(0.2,0.25))
	muz:SetKeyValue("GlowProxySize","2.0") -- Size of the glow to be rendered for visibility testing.
	muz:SetKeyValue("HDRColorScale","1.0")
	muz:SetKeyValue("renderfx","14")
	muz:SetKeyValue("rendermode","3") -- Set the render mode to "3" (Glow)
	muz:SetKeyValue("renderamt","255") -- Transparency
	muz:SetKeyValue("disablereceiveshadows","0") -- Disable receiving shadows
	muz:SetKeyValue("framerate","10.0") -- Rate at which the sprite should animate, if at all.
	muz:SetKeyValue("spawnflags","0")
	muz:SetParent(self)
	muz:Fire("SetParentAttachment",self.PrimaryEffects_MuzzleAttachment)
	muz:SetAngles(Angle(math.random(-100, 100), math.random(-100, 100), math.random(-100, 100)))
	muz:Spawn()
	muz:Activate()
	muz:Fire("Kill","",0.08)
	return true
end