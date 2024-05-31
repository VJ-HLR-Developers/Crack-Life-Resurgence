AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2010-2024 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_hlr/cracklife/superchav.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.HasIdleSounds = false
ENT.StartHealth = 150

ENT.SoundTbl_Alert = {"vj_hlr/crack_npc/superchav/zo_alert10.wav","vj_hlr/crack_npc/superchav/zo_alert20.wav","vj_hlr/crack_npc/superchav/zo_alert30.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"vj_hlr/crack_npc/superchav/zo_attack1.wav","vj_hlr/crack_npc/superchav/zo_attack2.wav"}
ENT.SoundTbl_Pain = {"vj_hlr/crack_npc/superchav/zo_pain1.wav","vj_hlr/crack_npc/superchav/zo_pain2.wav"}
ENT.SoundTbl_Death = {"vj_hlr/crack_npc/superchav/zo_pain1.wav","vj_hlr/crack_npc/superchav/zo_pain2.wav"}

ENT.ChavType = 1

/*-----------------------------------------------
	*** Copyright (c) 2010-2024 by oteek, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/