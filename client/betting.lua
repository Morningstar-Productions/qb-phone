local QBCore = exports['qb-core']:GetCoreObject()

-- NUI Callback

RegisterNUICallback('CasinoAddBet', function(data, cb)
    TriggerServerEvent('Renewed-Phone:server:CasinoAddBet', data)
    cb("ok")
end)

RegisterNetEvent('Renewed-Phone:client:addbetForAll', function(data)
    SendNUIMessage({
        action = "BetAddToApp",
        datas = data,
    })
end)

RegisterNUICallback('BettingAddToTable', function(data, cb)
    TriggerServerEvent('Renewed-Phone:server:BettingAddToTable', data)
    cb("ok")
end)

RegisterNUICallback('CasinoDeleteTable', function(_, cb)
    TriggerServerEvent('Renewed-Phone:server:DeleteAndClearTable')
    cb("ok")
end)

RegisterNUICallback('CheckHasBetTable', function(_, cb)
<<<<<<< Updated upstream
    QBCore.Functions.TriggerCallback('qb-phone:server:CheckHasBetTable', function(HasTable)
=======
    lib.callback('Renewed-Phone:server:CheckHasBetTable', false, function(HasTable)
>>>>>>> Stashed changes
        cb(HasTable)
    end)
end)

RegisterNUICallback('casino_status', function(_, cb)
    TriggerServerEvent('Renewed-Phone:server:casino_status')
    cb("ok")
end)

RegisterNUICallback('CheckHasBetStatus', function(_, cb)
<<<<<<< Updated upstream
    QBCore.Functions.TriggerCallback('qb-phone:server:CheckHasBetStatus', function(HasStatus)
=======
    lib.callback('Renewed-Phone:server:CheckHasBetStatus', false, function(HasStatus)
>>>>>>> Stashed changes
        cb(HasStatus)
    end)
end)

RegisterNUICallback('WineridCasino', function(data, cb)
    TriggerServerEvent('Renewed-Phone:server:WineridCasino', data)
    cb("ok")
end)