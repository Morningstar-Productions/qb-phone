RegisterNUICallback('GetAvailableTaxiDrivers', function(_, cb)
    lib.callback('qb-phone:server:GetAvailableTaxiDrivers', false, function(drivers)
        cb(drivers)
    end)
end)