local display = false

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end

RegisterNUICallback("esci", function(source)
   TriggerServerEvent("esci")
end)

RegisterNUICallback("option1", function(data,source)
    
end)

RegisterNUICallback("option2", function(source)

end)

---------------------- start 
function bast()
    SetDisplay(false)
    FreezeEntityPosition(PlayerPedId(), false)
    SetCamActive(cam,  false)
    RenderScriptCams(false,  false,  0,  true,  true)
    FreezeEntityPosition(PlayerPedId(), false)
    DestroyAllCams(true)
    DisplayRadar(true)
end

function inizia()
    spawncamera()
	SetDisplay(not display)
end
------------------ end
Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        DisableControlAction(0, 1, display) -- LookLeftRight
        DisableControlAction(0, 2, display) -- LookUpDown
        DisableControlAction(0, 142, display) -- MeleeAttackAlternate
        DisableControlAction(0, 18, display) -- Enter
        DisableControlAction(0, 322, display) -- ESC
        DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
    end
end)


--------Camera

function spawncamera(PlayerpedID)
    FreezePedCameraRotation(PlayerPedId());
    FreezeEntityPosition(ped, true);
    FreezeEntityPosition(PlayerPedId(), true);
    SetEntityCoords(PlayerPedId(),398.68,  -1003.66, -100.0)
    SetEntityHeading(PlayerPedId(), 180.00);
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",398.48,-1005.19, -99.0, 0.00, 0.00, 0.00,70.0, false, 0)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 2000, true, true) 
    DisplayRadar(false)
end

----

RegisterNetEvent('exit:menu')
AddEventHandler('exit:menu', function()
    bast()
end)


RegisterNetEvent('backto:menu')
AddEventHandler('backto:menu', function()
    inizia()
end)
----------

AddEventHandler("playerSpawned", function(spawn)
    Citizen.CreateThread(function()
        inizia()
        SetPedComponentVariation(playerPed, 0, 0, 0, 2) --Face
        SetPedComponentVariation(playerPed, 2, 11, 4, 2) --Hair 
        SetPedComponentVariation(playerPed, 4, 1, 5, 2) -- Pantalon
        SetPedComponentVariation(playerPed, 6, 1, 0, 2) -- Shoes
        SetPedComponentVariation(playerPed, 11, 7, 2, 2) -- Jacket
    end)
end)