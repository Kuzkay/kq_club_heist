LASERS = {}
ALARMS = {}
SAFES = {}


function EnableIpl(ipl, activate)
    if activate then
        if not IsIplActive(ipl) then
            RequestIpl(ipl)
        end
    else
        if IsIplActive(ipl) then
            RemoveIpl(ipl)
        end
    end
end

function ToggleIplProp(interiorId, props, state)
    if state then
        if not IsInteriorEntitySetActive(interiorId, props) then
            ActivateInteriorEntitySet(interiorId, props)
        end
    else
        if IsInteriorEntitySetActive(interiorId, props) then
            DeactivateInteriorEntitySet(interiorId, props)
        end
    end
end

function RenderInterior()
    local ipl = 'kq_club_int_0'
    EnableIpl(ipl, true)

    local intId = GetInteriorAtCoords(666.0, 149.0, -70.0)

    local iplProps = {
        'Int01_ba_clubname_09',
        'Int01_ba_lightgrid_01',
        'Int01_ba_Style02',
        'DJ_03_Lights_03',
        'Int01_ba_dj03',
        'Int01_ba_equipment_setup',
        'Int01_ba_deliverytruck',
        'Int01_ba_lightgrid_01',
        'Int01_ba_Worklamps',
    }

    for k, prop in pairs(iplProps) do
        ToggleIplProp(intId, prop, true)
    end

    RefreshInterior(intId)
end

function LockDoor(key)
    local door = Settings.doors[key]
    DoorSystemSetDoorState(door.id, 1)
end

function UnlockDoor(key)
    local door = Settings.doors[key]
    DoorSystemSetDoorState(door.id, 0)
end

function PrepareDoors()
    for k, door in pairs(Settings.doors) do
        AddDoorToSystem(door.id, door.hash, door.coords)

        if door.locked and (not door.accessCardUnlockable or (door.accessCardUnlockable and not GlobalState.kq_club_heist_door_unlocked)) then
            LockDoor(k)
        else
            UnlockDoor(k)
        end
    end
end

---------------------------
--- PROPS
---------------------------

function SpawnProps()
    for k, prop in pairs(Settings.props) do
        DeleteNearestOfType(prop.coords, prop.model)
    end

    Citizen.Wait(1000)

    for k, prop in pairs(Settings.props) do
        DoRequestModel(prop.model)
        local object = CreateObjectNoOffset(prop.model, prop.coords, 0, 1, 0)
        SetEntityRotation(object, prop.rotation)
        FreezeEntityPosition(object, true, false)
    end
end

---------------------------
--- LASERS SETUP | Config > lasers
---------------------------

function SetupLasers()
    local system = 'kq_security'
    if Config.useSecuritySystems then
        system = 'kq_security'
    elseif Config.useLasers then
        system = 'kq_lasers'
    end

    for k, laserData in pairs(Config.lasers) do
        -- Lasers marked with 'security' only will only be made when using kq_security
        if system == 'kq_security' or not laserData.securityOnly then
            if Config.lasersExtra.forceRagdoll then
                laserData.ragdoll = true
            end

            if Config.lasersExtra.damage > 0 then
                laserData.damage = Config.lasersExtra.damage
            end

            laserData.alarms = { 'main', 'back' }

            if Config.lasersExtra.alertDispatch then
                laserData.triggers = {
                    {
                        event = system .. ':dispatch:client:trigger',
                        type = 'client',
                        parameters = {
                            title = Config.dispatch.title,
                            message = Config.dispatch.message,
                            jobs = Config.dispatch.jobs,
                        },
                    },
                }
            end

            if system == 'kq_lasers' then
                laserData.handler = function()
                    Notify(L('~r~The alarm has been triggered. The law enforcement has been alerted!'))
                end
            end

            local laser = exports[system]:CreateLaser(k, laserData)
            LASERS[k] = laser
        end
    end
end

---------------------------
--- LASERS SETUP | Config > alarms
---------------------------
function SetupAlarms()
    for k, alarmData in pairs(Config.alarms) do
        local alarm = exports['kq_security']:CreateAlarm(k, alarmData)
        ALARMS[k] = alarm
    end
end

---------------------------
--- LASERS SETUP | Config > controller
---------------------------
function SetupController()
    local data = Config.controller

    data.hacking = {
        hackable = true,

        hackItems = { 'kq_hacker_usb' },

        disableLasers = true,
        duration = data.lasersHackDuration * 1000,

        successHandler = function()
            Notify(L('~r~The lasers will be disabled for {TIME} seconds'):gsub('{TIME}', data.lasersHackDuration))
            -- The script will automatically turn off the club lasers
        end,
        failureHandler = function()
            TriggerEvent('kq_security:dispatch:client:trigger', PlayerPedId(), {
                title = Config.dispatch.title,
                message = Config.dispatch.hackingMessage,
                jobs = Config.dispatch.jobs,
            })

            for k, alarm in pairs(ALARMS) do
                alarm.Trigger()
            end
        end,
    }

    local laserKeys = {}
    for k, _ in pairs(Config.lasers) do
        table.insert(laserKeys, k)
    end

    data.lasers = laserKeys

    local controller = exports['kq_security']:CreateController('kq_club_heist_controller', data)
    Config.controller.controller = controller
end

--------------------------
--- OTHER
--------------------------

function CreateClubBlip()
    local blip = AddBlipForCoord(Settings.entrance.coords)

    SetBlipSprite(blip, 614)
    SetBlipColour(blip, 48)
    SetBlipScale(blip, 1.2)
    SetBlipShrink(blip, true)
    SetBlipRoute(blip, true)
    
    Citizen.SetTimeout(30 * 60 * 1000, function()
        RemoveBlip(blip)
    end)
end

function SmoothTeleport(entity, coords, h)
    Citizen.CreateThread(function()
        DoScreenFadeOut(1000)
        Citizen.Wait(1250)
        FreezeEntityPosition(entity, true)
        SetEntityCoordsNoOffset(entity, coords, true, false, false)
        if h ~= nil then
            SetEntityHeading(entity, h)
        end
        Citizen.Wait(1250)
        FreezeEntityPosition(entity, false)
        DoScreenFadeIn(1000)
    end)
end

--This function is responsible for drawing all the 3d texts
function Draw3DText(coords, textInput, scaleX)
    scaleX = scaleX * (Config.textScale or 1.0)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, coords, true)
    local scale = (1 / dist) * 20
    local fov = (1 / GetGameplayCamFov()) * 100
    scale = scale * fov

    SetTextScale(scaleX * scale, scaleX * scale)
    SetTextFont(Config.textFont or 4)
    SetTextProportional(1)
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(coords, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end
