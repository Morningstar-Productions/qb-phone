local CasinoTable = {}
local BetNumber = 0

RegisterNetEvent('Renewed-Phone:server:CasinoAddBet', function(data)
    BetNumber += 1
    CasinoTable[BetNumber] = {['Name'] = data.name, ['chanse'] = data.chanse, ['id'] = BetNumber}
    TriggerClientEvent('Renewed-Phone:client:addbetForAll', -1, CasinoTable)
end)

local CasinoBetList = {}
local casino_status = true

RegisterNetEvent('Renewed-Phone:server:BettingAddToTable', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local amount = tonumber(data.amount)
    local CSN = Player.PlayerData.citizenid
    if casino_status then
        if Player.PlayerData.money.bank >= amount then
            if not CasinoBetList[CSN] then
                Player.Functions.RemoveMoney('bank', amount, "Casino Betting")
                CasinoBetList[CSN] = {['csn'] = CSN, ['amount'] = amount, ['player'] = data.player, ['chanse'] = data.chanse, ['id'] = data.id}
            else
                TriggerClientEvent('QBCore:Notify', src, "You are already betting...", "error")
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "You do not have enough money!", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Betting is not active...", "error")
    end
end)

RegisterNetEvent('Renewed-Phone:server:DeleteAndClearTable', function()
    local src = source
    CasinoTable = {}
    CasinoBetList = {}
    BetNumber = 0
    TriggerClientEvent('Renewed-Phone:client:addbetForAll', -1, CasinoTable)
    TriggerClientEvent('QBCore:Notify', src, "Done", "primary")
end)

lib.callback.register('Renewed-Phone:server:CheckHasBetTable', function(_)
    return CasinoTable
end)


RegisterNetEvent('Renewed-Phone:server:casino_status', function()
    casino_status = not casino_status
end)

lib.callback.register('Renewed-Phone:server:CheckHasBetStatus', function(_)
    return casino_status
end)

RegisterNetEvent('Renewed-Phone:server:WineridCasino', function(data)
    local Winer = data.id
    for _, v in pairs(CasinoBetList) do
        if v.id == Winer then
            local OtherPly = QBCore.Functions.GetPlayerByCitizenId(v.csn)
            if OtherPly then
                local amount = v.amount * v.chanse
                OtherPly.Functions.AddMoney('casino', tonumber(amount), "Casino Winner")
            end
        end
    end
end)