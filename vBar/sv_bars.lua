ESX = nil 

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent('vBar:bar')
AddEventHandler('vBar:bar', function(item,price)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xMoney = xPlayer.getMoney()
    local name = GetPlayerName(source)

    if xMoney >= price then
        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent('esx:showNotification', source, "~g~Achats~w~ effectué !")
    else
         TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~r~d\'argent")
    end
end)
