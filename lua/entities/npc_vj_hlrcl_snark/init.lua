AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2023 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_hlr/cracklife/snark.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.VJ_NPC_Class = {"CLASS_CRACKLIFE"}
ENT.EntitiesToNoCollide = {"npc_vj_hlrcl_snark","npc_vj_hlrcl_joj"}
ENT.CanUseHD = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Snark_CustomOnInitialize()
	self:SetCollisionBounds(Vector(5, 5, 10), Vector(-5, -5, 0))
	self.Snark_Type = 0
	self.SoundTbl_Idle = {"vj_hlr/crack_npc/snark/dick.wav"}
	self.SoundTbl_Alert = {"vj_hlr/crack_npc/snark/dick.wav"}
end