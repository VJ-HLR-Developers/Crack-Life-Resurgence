ENT.Base 			= "npc_vj_tank_base"
ENT.Type 			= "ai"
ENT.PrintName 		= "Admin Vladimir"
ENT.Author 			= "DrVrej, oteek"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= "Spawn it and fight with it!"
ENT.Instructions 	= "Click on the spawnicon to spawn it."
ENT.Category		= "Crack-Life Resurgence"

---------------------------------------------------------------------------------------------------------------------------------------------
net.Receive("vj_hlr1_m1a1abrams_moveeffects", function()
	local ent = net.ReadEntity()
	if IsValid(ent) then
		ent.Emitter = ParticleEmitter(ent:GetPos())
		ent.MoveSmokeEffect1 = ent.Emitter:Add("particles/smokey", ent:GetPos() + ent:GetForward()*-180 + ent:GetRight()*80 + ent:GetUp()*1)
		ent.MoveSmokeEffect1:SetVelocity(ent:GetForward()*math.Rand(100,200) + Vector(math.Rand(5,-5),math.Rand(5,-5),math.Rand(5,-5)) + ent:GetVelocity())
		ent.MoveSmokeEffect1:SetDieTime(4)
		ent.MoveSmokeEffect1:SetStartAlpha(30)
		ent.MoveSmokeEffect1:SetEndAlpha(0)
		ent.MoveSmokeEffect1:SetStartSize(math.Rand(12,20))
		ent.MoveSmokeEffect1:SetEndSize(math.Rand(60,80))
		ent.MoveSmokeEffect1:SetRoll(math.Rand(-0.2,0.2))
		ent.MoveSmokeEffect1:SetColor(80,60,20)
		ent.MoveSmokeEffect1:SetAirResistance(300)
		ent.MoveSmokeEffect1:SetGravity(Vector(0,0,50))
		
		ent.MoveSmokeEffect2 = ent.Emitter:Add("particles/smokey", ent:GetPos() + ent:GetForward()*-180 + ent:GetRight()*-80 + ent:GetUp()*1)
		ent.MoveSmokeEffect2:SetVelocity(ent:GetForward()*math.Rand(100,200) + Vector(math.Rand(5,-5),math.Rand(5,-5),math.Rand(5,-5)) + ent:GetVelocity())
		ent.MoveSmokeEffect2:SetDieTime(4)
		ent.MoveSmokeEffect2:SetStartAlpha(30)
		ent.MoveSmokeEffect2:SetEndAlpha(0)
		ent.MoveSmokeEffect2:SetStartSize(math.Rand(12,20))
		ent.MoveSmokeEffect2:SetEndSize(math.Rand(60,80))
		ent.MoveSmokeEffect2:SetRoll(math.Rand(-0.2,0.2))
		ent.MoveSmokeEffect2:SetColor(80,60,20)
		ent.MoveSmokeEffect2:SetAirResistance(300)
		ent.MoveSmokeEffect2:SetGravity(Vector(0,0,50))
		ent.Emitter:Finish()
	end
end)