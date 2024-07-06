if Config.esxSettings.enabled then
    ESX = nil

    if Config.esxSettings.useNewESXExport then
        ESX = exports['es_extended']:getSharedObject()
    else
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end
    
    function DoesPlayerHaveItem(player, item, amount)
        local xPlayer = ESX.GetPlayerFromId(player)
        
        return xPlayer.getInventoryItem(item).count >= (amount or 1)
    end

    function RemovePlayerItem(player, item, amount)
        local xPlayer = ESX.GetPlayerFromId(tonumber(player))
        xPlayer.removeInventoryItem(item, amount or 1)
    end
end
