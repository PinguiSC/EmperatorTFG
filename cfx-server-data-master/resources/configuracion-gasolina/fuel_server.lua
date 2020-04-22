ESX = nil

if Config.UseESX then
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

    RegisterServerEvent('fuel:comprar')
    AddEventHandlet('fuel:comprar', function(price)
        local xPlayer = ESX.GetPlayerFromId(source)
        local amount = ESX.Math.Round(price)

        if price > 0 then 
            xPlayer.removeMoney(mount)
        end
    end)
end