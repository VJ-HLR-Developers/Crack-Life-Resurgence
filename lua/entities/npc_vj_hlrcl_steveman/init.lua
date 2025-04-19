AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2010-2025 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_hlr/cracklife/gman.mdl"} -- The game will pick a random model from the table when the SNPC is 
ENT.CanUseHD = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetBodygroup(0,1)
	self.SoundTbl_FootStep = {"vj_hlr/crack_fx/npc_step1.wav","vj_hlr/crack_fx/npc_step2.wav","vj_hlr/crack_fx/npc_step3.wav","vj_hlr/crack_fx/npc_step4.wav"}
	self.SoundTbl_IdleDialogue = {"vj_hlr/crack_npc/gman/gman_nasty.wav","vj_hlr/crack_npc/gman/gman_choose1.wav","vj_hlr/crack_npc/gman/gman_choose2.wav","vj_hlr/crack_npc/gman/gman_otherwise.wav","vj_hlr/crack_npc/gman/gman_stepin.wav"}
	self.SoundTbl_FollowPlayer = {"vj_hlr/crack_npc/gman/gman_potential.wav","vj_hlr/crack_npc/gman/gman_wise.wav","vj_hlr/crack_npc/gman/gman_noregret.wav"}
	self.SoundTbl_UnFollowPlayer = {"vj_hlr/crack_npc/gman/gman_nowork.wav"}
	self.SoundTbl_OnPlayerSight = {"vj_hlr/crack_npc/gman/gman_suit.wav"}
	self:AddFlags(FL_NOTARGET)
end