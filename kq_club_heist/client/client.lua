
-- 651.76 149.35 -65.20

function CheckDependencies()
    if Config.useSecuritySystems and GetResourceState('kq_security') ~= 'started' then
        Config.useSecuritySystems = false
        print('^1KQ_SECURITY is enabled but not running on this server. Disabling this option!')
    end
    if Config.useLasers and GetResourceState('kq_lasers') ~= 'started' then
        Config.useLasers = false
        print('^1KQ_LASERS is enabled but not running on this server. Disabling this option!')
    end
    if Config.useAdvancedPedLooting and GetResourceState('kq_ped_loot') ~= 'started' then
        Config.useAdvancedPedLooting = false
        print('^1KQ_PED_LOOT is enabled but not running on this server. Disabling this option!')
    end
end
CheckDependencies()

function SetupHeist()
    Citizen.CreateThread(function()
        RenderInterior()

        Citizen.Wait(100)
        PrepareDoors()

        Citizen.Wait(100)
        SetupLasers()

        if Config.useSecuritySystems then
            Citizen.Wait(100)
            SetupAlarms()
            Citizen.Wait(100)
            SetupController()
        end

        Citizen.Wait(100)
        SpawnProps()
    end)
end
SetupHeist()

RegisterNetEvent('kq_club_heist:client:triggerHeist')
AddEventHandler('kq_club_heist:client:triggerHeist', function()
    TriggerServerEvent('kq_club_heist:server:start')
    HeistTriggered()
end)

function HeistTriggered()
    CreateClubBlip()
    Notify(L('~p~The location of the club has been marked'))
end


Citizen.CreateThread(function()
    while true do
        local sleep = 5000

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        if GlobalState.kq_club_heist_started then
            sleep = 2000

            local entranceCoords = Settings.entrance.coords
            local distance = GetDistanceBetweenCoords(playerCoords, entranceCoords, 1)

            if distance < 40.0 then
                sleep = 200
                if distance < 20.0 then
                    TriggerHandler(Settings.entrance.coords, distance, 20, L('~p~[~w~{KEYBIND}~p~]~w~ Enter the club'), function()
                        EnterClub()
                    end)
                    sleep = 1
                end
            end

            local keypadCoords = Settings.security.accessCardKeypad.coords
            local distanceToKeypad = GetDistanceBetweenCoords(playerCoords, keypadCoords, 1)
            if distanceToKeypad < 10 then
                sleep = math.min(sleep, 200)
                if distanceToKeypad < 2 and not GlobalState.kq_club_heist_door_unlocked then
                    sleep = 1
                    Draw3DText(keypadCoords, L('~p~[~w~{KEYBIND}~p~]~w~ Unlock the doors'):gsub('{KEYBIND}', Config.keybinds.trigger.label), 0.05)
                    Draw3DText(keypadCoords + vector3(0.0, 0.0, -0.1), L('~r~Keycard required*'), 0.02)
                    if IsControlJustReleased(0, Config.keybinds.trigger.input) then
                        TriggerServerEvent('kq_club_heist:server:unlockDoors')
                    end
                end
            end
        end

        for k, teleport in pairs(Settings.teleports) do
            local distance = GetDistanceBetweenCoords(playerCoords, teleport.entrance, 1)

            if distance < 10.0 then
                sleep = math.min(sleep, 200)
                if distance < 10.0 then
                    TriggerHandler(teleport.entrance, distance, 10, L(teleport.label), function()
                        TriggerServerEvent('kq_club_heist:server:exit')
                        SmoothTeleport(playerPed, teleport.exit.coords, teleport.exit.heading)
                    end)
                    sleep = 1
                end
            end
        end

        Citizen.Wait(sleep)
    end
end)

function TriggerHandler(coords, distance, maxDistance, label, cb)
    local playerPed = PlayerPedId()

    DrawDistanceMarker(coords, distance, maxDistance)
    if not IsPedInAnyVehicle(playerPed) and not IsPedRagdoll(playerPed) and not IsPedDeadOrDying(playerPed, 1) and distance < 2.0 then
        Draw3DText(coords, label:gsub('{KEYBIND}', Config.keybinds.trigger.label), 0.05)
        if IsControlJustReleased(0, Config.keybinds.trigger.input) then
            cb()
        end
    end
end

function DrawDistanceMarker(coords, distance, maxDistance)
    DrawMarker(1, coords + vector3(0.0, 0.0, -1.0), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.2, 1.2, 0.5, 94, 59, 163, math.min(130, math.floor(((maxDistance - distance) * 0.3) * 130)), 0, 1, 0, 0)
end

function EnterClub()
    local playerPed = PlayerPedId()

    SmoothTeleport(playerPed, Settings.club.exit.coords, Settings.club.exit.heading)
    TriggerServerEvent('kq_club_heist:server:entered')
end


RegisterNetEvent('kq_club_heist:client:toggleDoors')
AddEventHandler('kq_club_heist:client:toggleDoors', function(state)
    for k, door in pairs(Settings.doors) do
        if door.accessCardUnlockable then
            if state then
                UnlockDoor(k)
            else
                LockDoor(k)
            end
        end
    end
end)
