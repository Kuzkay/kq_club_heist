
-- This function is responsible for all the tooltips displayed on top right of the screen, you could
-- replace it with a custom notification etc.
function Notify(message)
    SetTextComponentFormat("STRING")
    AddTextComponentString(message)
    EndTextCommandDisplayHelp(0, 0, 0, 5000)
end

RegisterNetEvent('kq_club_heist:client:notify')
AddEventHandler('kq_club_heist:client:notify', function(message)
    Notify(message)
end)

function DoRequestModel(model)
    local hash = GetHashKey(model)
    RequestModel(hash)
    local timeout = 3000
    while not HasModelLoaded(hash) and timeout > 0 do
        Citizen.Wait(20)
        timeout = timeout - 20
    end
end

function DeleteNearestOfType(coords, model)
    local objExists = true

    local obj = GetClosestObjectOfType(coords.x, coords.y, coords.z, 10.0, model, 0, 0, 0)
    while obj ~= 0 do

        SetEntityAsMissionEntity(obj, 1, 1)
        DeleteEntity(obj)

        obj = GetClosestObjectOfType(coords.x, coords.y, coords.z, 10.0, model, 0, 0, 0)

        Citizen.Wait(10)
    end
end

function L(text)
    if Locale and Locale[text] then
        return Locale[text]
    end

    return text
end

function Debug(...)
    if Config.debug then
        print(...)
    end
end
