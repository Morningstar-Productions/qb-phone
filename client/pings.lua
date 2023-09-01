local Blip

-- NUI Callback

RegisterNetEvent("Renewed-Phone:client:sendPing", function(Name, pos)
    if Blip then RemoveBlip(Blip) Blip = nil end

    Blip = AddBlipForCoord(pos.x, pos.y, pos.z)
    SetBlipSprite(Blip, 280)
    SetBlipDisplay(Blip, 4)
    SetBlipScale(Blip, 1.1)
    SetBlipAsShortRange(Blip, false)
    SetBlipColour(Blip, 0)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Name..'\'s ping!')
    EndTextCommandSetBlipName(Blip)

    TriggerEvent('Renewed-Phone:client:CustomNotification',
        Name..'\'s Location Marked',
        "Ping Available For 5 Minutes",
        'fas fa-map-pin',
        '#b3e0f2',
        7500
    )
    SetTimeout(60000*5, function()
        RemoveBlip(Blip)
        Blip = nil
        TriggerEvent('Renewed-Phone:client:CustomNotification',
            Name..'\'s Location Removed',
            "Ping No Longer Available",
            'fas fa-map-pin',
            '#b3e0f2',
            7500
        )
    end)
end)

RegisterNUICallback('SendPingPlayer', function(data, cb)
    TriggerServerEvent('Renewed-Phone:server:sendPing', data.id)
    cb('ok')
end)

-- Events
RegisterNetEvent("Renewed-Phone:client:sendNotificationPing", function(info)
    PlaySound(-1, "Click_Fail", "WEB_NAVIGATION_SOUNDS_PHONE", 0, 0, 1)
    local success = exports['Renewed-Phone']:PhoneNotification(
        "PING",
        info.Name..' Incoming Ping',
        'fas fa-map-pin',
        '#b3e0f2',
        "NONE",
        'fas fa-check-circle',
        'fas fa-times-circle'
    )
    if success then
        TriggerServerEvent("Renewed-Phone:server:sendingPing", info.Other, info.Player, info.Name, info.OtherName)
    end
end)