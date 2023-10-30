local QBCore = exports['qb-core']:GetCoreObject()
local ped = PlayerPedId()
local counter = 1
local Coords = Config.Blips[counter].coords
local grapeCoords = Config.Pick_Grape[counter].coords

local function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.4, 0.4)
    SetTextFont(1)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end
local function distance(counter)
    local ped = PlayerPedId()
    local Coord1 = grapeCoords
    local coord = GetEntityCoords(ped)
    local distance = #(Coord1 - coord)
    
    return distance

end

local function addBlip(coords, text)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, 93)
    SetBlipColour(blip, 7)
    SetBlipDisplay(blip, 3)
    SetBlipAlpha(blip, 250)
    SetBlipScale(blip, 0.8)
    SetBlipAsShortRange(blip, false)
    PulseBlip(blip)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
    return blip
end
 --[[ local function checkgrapecount()
    TriggerServerEvent('Checkgrape')
    AddEventHandler('grapecounted',function ()
        
    end)

 end ]]--


Citizen.CreateThread( function ()
    addBlip(Config.Blips[1].coords,"Üzüm Toplama")
    RegisterNetEvent('addgrape')
   --[[  RegisterNetEvent("Checkgrape") ]]--
    
    
    while true do
    grapeCoords = Config.Pick_Grape[counter].coords    
    Citizen.Wait(1)
    local distance = distance(counter)
    local sleep = true
    if distance < 15 then
        sleep = false
        DrawText3D(Config.Pick_Grape[counter].coords[1],Config.Pick_Grape[counter].coords[2],Config.Pick_Grape[counter].coords[3],'Üzüm Topla ~g~E~s~')
        if IsControlJustPressed(0,38) then
            --[[ checkgrapecount() ]]--
            QBCore.Functions.Progressbar("Uzum Topla","Üzüm Topluyorsun",5000,false,true,{
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },{animDict = "amb@prop_human_bum_bin@idle_a",
            anim = "idle_a",
            flags = 6,},{},{},function ()
                ClearPedTasks(ped)
                TriggerServerEvent('addgrape')
                if counter < Config.GrapePickcount then
                    counter += 1
                else 
                    counter -=1
                end

            end,function ()
                ClearPedTasks(ped)
                QBCore.Functions.Notify("Üzüm Toplamayı Bıraktın", "primary", 3000)
                
            end)
            

        end
    if sleep then
    Citizen.Wait(1000) 
    end
end
end
end)





