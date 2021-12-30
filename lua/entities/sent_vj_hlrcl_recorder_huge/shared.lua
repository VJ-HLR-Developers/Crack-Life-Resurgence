ENT.Base 			= "base_entity"
ENT.Type 			= "ai"
ENT.PrintName 		= "Skrillyd's Player"
ENT.Author 			= "DrVrej"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= "Spawn it and fight with it!"
ENT.Instructions 	= "Click on the spawnicon to spawn it."
ENT.Category		= "Half-Life Resurgence"

function ENT:Draw() self:DrawModel() end

if (!SERVER) then return end

if (CLIENT) then
	local Name = "Skrillyd's Player"
	local LangName = "sent_vj_hlrcl_recorder_huge"
	language.Add(LangName, Name)
	killicon.Add(LangName,"HUD/killicons/default",Color(255,80,0,255))
	language.Add("#"..LangName, Name)
	killicon.Add("#"..LangName,"HUD/killicons/default",Color(255,80,0,255))
end