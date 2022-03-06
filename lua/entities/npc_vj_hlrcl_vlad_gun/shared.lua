ENT.Base 			= "npc_vj_tankg_base"
ENT.Type 			= "ai"
ENT.PrintName 		= "Admin Vladimir"
ENT.Author 			= "DrVrej, oteek"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= "Spawn it and fight with it!"
ENT.Instructions 	= "Click on the spawnicon to spawn it."
ENT.Category		= "Crack-Life Resurgence"

if CLIENT then
	local Name = "Admin Vladimir"
	local LangName = "npc_vj_hlrcl_vlad_gun"
	language.Add(LangName, Name)
	killicon.Add(LangName,"HUD/killicons/default",Color(255,80,0,255))
	language.Add("#"..LangName, Name)
	killicon.Add("#"..LangName,"HUD/killicons/default",Color(255,80,0,255))
end
---------------------------------------------------------------------------------------------------------------------------------------------
local vec = Vector(220, 0, 210)
--
net.Receive("vj_hlr1_m1a1abrams_shooteffects", function()
	local ent = net.ReadEntity()
	if IsValid(ent) then
		ent.Emitter = ParticleEmitter(ent:GetPos())
		ent.SmokeEffect2 = ent.Emitter:Add("particles/smokey", ent:LocalToWorld(vec))
		ent.SmokeEffect2:SetVelocity(ent:GetForward()*math.Rand(0, -50) + Vector(0, -30, math.Rand(-10, -20)) + ent:GetVelocity())
		ent.SmokeEffect2:SetDieTime(2)
		ent.SmokeEffect2:SetStartAlpha(30)
		ent.SmokeEffect2:SetEndAlpha(0)
		ent.SmokeEffect2:SetStartSize(3)
		ent.SmokeEffect2:SetEndSize(50)
		ent.SmokeEffect2:SetRoll(math.Rand(-0.2, 0.2))
		ent.SmokeEffect2:SetColor(150, 150, 150, 255)
		ent.Emitter:Finish()
	end
end)