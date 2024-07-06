
function GetLootKey(key)
    return 'kq_club_heist_loot_' .. key
end

function RemoveLoot()
    for k, loot in pairs(Config.loot) do
        local areaKey = GetLootKey(k)
        exports['kq_lootareas']:DeleteArea(areaKey)
    end
end

function PrepareLoot()
    for k, loot in pairs(Config.loot) do
        SpawnLoot(loot, k)
    end
end

function SpawnLoot(loot, key)
    local areaKey = GetLootKey(key)
    exports['kq_lootareas']:DeleteArea(areaKey)

    if loot.chance < math.random(0, 100) then
        return
    end

    local lootArea = {
        name = 'Club heist ' .. loot.label,
        renderDistance = 25.0,
        coords = loot.coords,
        radius = loot.radius + 0.0,
        amount = loot.amount,
        regrowTime = 9999999999, -- never respawn loot automatically

        items = {
            {
                item = loot.item.name,
                chance = 100,
                amount = {
                    min = loot.item.min,
                    max = loot.item.max,
                },
            }
        },

        props = {
            {
                hash = loot.model,
                textureVariation = 0,
                chance = 100,
                minimumDistanceBetween = 0.2,
                offset = vector3(0.0, 0.0, 0.0),

                rotation = loot.rotation or nil,

                forceZCoordinate = true,
                animation = {
                    duration = 0.7, -- in seconds
                    dict = 'mp_take_money_mg',
                    anim = 'put_cash_into_bag_loop',
                    flag = 17,
                },
                labelSingular = loot.label,
                labelPlurar = loot.label,
                collectMessage = L('Steal the {NAME}'):gsub('{NAME}', loot.label),
                icon = 'fas fa-hand',

                requiredItems = loot.requiredItems,
            },
        },
    }

    exports['kq_lootareas']:CreateArea(areaKey, lootArea)
end

RemoveLoot()
