local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('addgrape')
--[[ RegisterNetEvent("Checkgrape")
RegisterNetEvent('grapecounted',cb) ]]--

--[[ AddEventHandler("Checkgrape",function (src)
    local source = src
    local player = QBCore.Functions.GetPlayer(src)
    local grapecount = player.Functions.GetItemsByName(src,'grape')
    print(grapecount)
    TriggerClientEvent('grapecounted',source,grapecount)
    
    
end) ]]--

AddEventHandler('addgrape',function(src)   
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['grape'], "add") 
    player.Functions.AddItem("grape",1--[[source,item,amount?,slot?,info?]])




end)
