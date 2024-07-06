HEIST_PREPARED = false
HEIST_START_TIME = 0
PLAYERS_INSIDE = {}

GlobalState.kq_club_heist_started = false

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

local starter = {
    name = 'Club heist hint',
    renderDistance = 10.0,
    coords = Config.starter.location,
    radius = 0.05,
    amount = 1,
    regrowTime = Config.starter.respawnTime * 1000, -- in seconds

    event = 'kq_club_heist:client:triggerHeist',
    eventType = 'client',

    items = nil,
    props = {
        {
            hash = Config.starter.prop,
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
            labelSingular = L('Rival club information'),
            labelPlurar = L('Rival club information'),
            collectMessage = L('Read information about a rival club'),
            icon = 'fas fa-newspaper',
        },
    },
}

exports['kq_lootareas']:CreateArea('kq_club_heist_starter', starter)

--------------------------------------------------------

RegisterServerEvent('kq_club_heist:server:start')
AddEventHandler('kq_club_heist:server:start', function()
    TriggerStart()
end)

function TriggerStart()
    if not GlobalState.kq_club_heist_started then
        GlobalState.kq_club_heist_started = true
        HEIST_PREPARED = false
        HEIST_START_TIME = GetGameTimer()
        ActiveThread()
    end
end
