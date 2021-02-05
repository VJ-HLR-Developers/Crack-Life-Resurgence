AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_hlr/cracklife/skellington.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.VJ_NPC_Class = {"CLASS_CRACKLIFE"} -- NPCs with the same class with be allied to each other
ENT.Bleeds = false

ENT.HasIdleSounds = false
ENT.HasAlertSounds = false

ENT.SoundTbl_BeforeMeleeAttack = {"vj_hlr/null.wav","vj_hlr/null.wav"}
ENT.SoundTbl_Pain = {"vj_hlr/crack_npc/spooky/s_pain1.wav","vj_hlr/crack_npc/spooky/s_pain2.wav","vj_hlr/crack_npc/spooky/s_pain3.wav"}
ENT.SoundTbl_Death = {"vj_hlr/crack_npc/spooky/s_die.wav","vj_hlr/crack_npc/spooky/s_die2.wav","vj_hlr/crack_npc/spooky/s_die3.wav"}
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/