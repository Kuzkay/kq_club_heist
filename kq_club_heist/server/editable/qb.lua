if Config.qbSettings.enabled then

    QBCore = exports['qb-core']:GetCoreObject()

    function DoesPlayerHaveItem(player, item, amount)
        local xPlayer = QBCore.Functions.GetPlayer(player)
        TriggerClientEvent('inventory:client:ItemBox', player, QBCore.Shared.Items[item], 'remove', amount or 1)

        local playerItem = xPlayer.Functions.GetItemByName(item)
        return playerItem and ((playerItem.amount or playerItem.count) >= (amount or 1))
    end

    function RemovePlayerItem(player, item, amount)
        local xPlayer = QBCore.Functions.GetPlayer(tonumber(player))
        xPlayer.Functions.RemoveItem(item, amount or 1)
    end
end
