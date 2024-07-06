SECURITY_PED = nil

GlobalState.kq_club_heist_door_unlocked = false

function ActiveThread()
    Citizen.CreateThread(function()
        local active = true
        while active do
            active = false

            -- Do not end the heist for 10 minutes after start regardless of inside player count
            if HEIST_START_TIME + (60 * 1000 * Config.starter.doorOpenTime) > GetGameTimer() then
                Debug('Heist started less than ' .. Config.starter.doorOpenTime .. ' min ago. Dont stop')
                active = true
            else
                -- Check if any players are inside. If so, do not end the heist
                Debug('Players still inside. Dont stop')
                for k, inside in pairs(PLAYERS_INSIDE) do
                    if inside then
                        active = true
                    end
                end
            end

            Citizen.Wait(30000)
        end

        -- Close the club entrance and stop the heist
        EndHeist()
    end)
end

function EndHeist()
    Debug('Heist ended')

    GlobalState.kq_club_heist_started = false
    GlobalState.kq_club_heist_door_unlocked = false

    TriggerClientEvent('kq_club_heist:client:toggleDoors', -1, false)

    RemoveLoot()
    DeleteSecurityPed()
    PLAYERS_INSIDE = {}
end


RegisterServerEvent('kq_club_heist:server:unlockDoors')
AddEventHandler('kq_club_heist:server:unlockDoors', function()
    local player = source
    if not DoesPlayerHaveItem(player, 'kq_club_card', 1) then
        TriggerClientEvent('kq_club_heist:client:notify', player, L('~r~You need an access card'))
        return
    end

    RemovePlayerItem(player, 'kq_club_card', 1)
    GlobalState.kq_club_heist_door_unlocked = true
    TriggerClientEvent('kq_club_heist:client:toggleDoors', -1, true)
end)



--- ENTERING / EXITING
RegisterServerEvent('kq_club_heist:server:exit')
AddEventHandler('kq_club_heist:server:exit', function()
    PLAYERS_INSIDE[source] = false
end)

AddEventHandler('playerDropped', function()
    PLAYERS_INSIDE[source] = false
end)

RegisterServerEvent('kq_club_heist:server:entered')
AddEventHandler('kq_club_heist:server:entered', function()
    PLAYERS_INSIDE[source] = true

    if HEIST_PREPARED then
        return
    end
    HEIST_PREPARED = true

    local playerPed = GetPlayerPed(source)
    if SECURITY_PED == nil then
        CreateSecurityPed()
    end
    TaskCombatPed(SECURITY_PED, playerPed, 0, 16)

    if not Config.useAdvancedPedLooting then
        SpawnAccessCard()
    end

    SpawnSafeKeys()
    PrepareLoot()
end)

--- SECURITY PED
function DeleteSecurityPed()
    DeleteEntity(SECURITY_PED)
    SECURITY_PED = nil
end

function CreateSecurityPed()
    if SECURITY_PED ~= nil then
        DeleteSecurityPed()
    end

    -- Select a random location for the security guard to spawn at
    local location = Settings.security.locations[math.random(1, #Settings.security.locations)]

    SECURITY_PED = CreatePed(0, Settings.security.ped, location.coords, location.heading, 1, 1)

    -- Wait until the ped spawns
    Citizen.Wait(1000)

    SetPedArmour(SECURITY_PED, 100)
    GiveWeaponToPed(SECURITY_PED, GetHashKey(Settings.security.weapon), 200, 0, 1)

    -- When using kq_ped_loot the script will make the security ped drop the security card instead of the card
    -- being spawned randomly in the club
    if Config.useAdvancedPedLooting then
        SetSecurityPedCardLoot()
    end
end

--- ACCESS CARD
function SetSecurityPedCardLoot()
    exports['kq_ped_loot']:SetEntityLootPool(SECURITY_PED, {
        chance = 100,
        item = {
            name = 'kq_club_card',
        },
        props = {
            'prop_cs_swipe_card',
        },
    })
end

function SpawnAccessCard()
    -- Get random coordinates for the access card
    local coords = Settings.security.accessCardSpawnPoints[math.random(1, #Settings.security.accessCardSpawnPoints)]

    local card = {
        name = 'Club access-card',
        renderDistance = 10.0,
        coords = coords,
        radius = 0.05,
        amount = 1,
        regrowTime = 84000, -- in seconds

        items = {
            {
                item = 'kq_club_card',
                chance = 1,
                amount = {
                    min = 1,
                    max = 1,
                },
            }
        },
        props = {
            {
                hash = 'prop_cs_swipe_card',
                textureVariation = 0,
                chance = 100,
                minimumDistanceBetween = 0.1,
                offset = vector3(0.0, 0.0, 0.0),
                rotation = vector3(90.0, 0.0, 20.0),
                forceZCoordinate = true,
                animation = {
                    duration = 1, -- in seconds
                    dict = 'mp_take_money_mg',
                    anim = 'put_cash_into_bag_loop',
                    flag = 17,
                },
                labelSingular = L('Club access-card'),
                labelPlurar = L('Club access-cards'),
                collectMessage = L('Grab club access-card'),
                icon = 'fas fa-hand',
            },
        },
    }

    exports['kq_lootareas']:CreateArea('kq_club_heist_access_card', card)
end


--- SAFE KEYS
function SpawnSafeKeys()
    local coords = Settings.safe.keySpawnPoints[math.random(1, #Settings.safe.keySpawnPoints)]

    local keys = {
        name = 'Club safe keys',
        renderDistance = 10.0,
        coords = coords,
        radius = 0.05,
        amount = 1,
        regrowTime = 84000, -- in seconds

        items = {
            {
                item = 'kq_club_keys',
                chance = 1,
                amount = {
                    min = 1,
                    max = 1,
                },
            }
        },
        props = {
            {
                hash = 'bkr_prop_jailer_keys_01a',
                textureVariation = 0,
                chance = 100,
                minimumDistanceBetween = 0.1,
                offset = vector3(0.0, 0.0, 0.0),
                forceZCoordinate = true,
                animation = {
                    duration = 1, -- in seconds
                    dict = 'mp_take_money_mg',
                    anim = 'put_cash_into_bag_loop',
                    flag = 17,
                },
                labelSingular = L('Safe keys'),
                labelPlurar = L('Safe keys'),
                collectMessage = L('Grab safe keys'),
                icon = 'fas fa-hand',
            },
        },
    }

    exports['kq_lootareas']:CreateArea('kq_club_heist_safe_keys', keys)
end


--- BASE FUNCTIONS
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
