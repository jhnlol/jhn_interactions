local Interactions = {}
local Main = {}
function Main.CreateInteraction(name, data) 
    if not data.pedName or not data.pedCoords or not data.displayName then
        print("Missing required parameters")
        return
    end
    local id = #Interactions + 1
    local pedId = lib.requestModel(data.pedName)
    local ped = CreatePed(0, pedId, data.pedCoords.x, data.pedCoords.y, data.pedCoords.z, data.pedCoords.w, true, true)
    SetEntityHeading(ped, data.pedCoords.w)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    exports.ox_target:addEntity(NetworkGetNetworkIdFromEntity(ped), {
        name = name,
        label = "Porozmawiaj",
        icon = "fa-solid fa-comment",
        onSelect = function()
            Main.openMenu(id)
        end
    })
    local options = data.options or {}

    table.insert(Interactions, {id = id, name = name, ped = ped, options = options, pedId = pedId, displayName = data.displayName})
end
function Main.openMenu(id) 
    local interaction = Interactions[id]
    local nuiOptions = {}
    for v, option in ipairs(interaction.options) do 
        table.insert(nuiOptions, {
            label = option.label,
            actionId = v, 
            interactionId = id
        })
    end
    SendNUIMessage({
        action = "show",
        options = nuiOptions,
        displayName = interaction.displayName,
    })
    SetNuiFocus(true, true)
end
Main.CreateInteraction("example", {
    pedName = "a_m_y_indian_01",
    pedCoords = vector4(-751.2094, 5543.2578, 33.4857 -0.5, 115.6422),
    displayName = "Rybak",
    options = {
        {
            label = "Gdzie jest rybak?",
            action = function()
                SetNewWaypoint(-1040.0, 4916.0, 200.0)
                ESX.ShowNotification("Zaznaczono rybaka na mapie")
            end
        },
        {
            label = "Jaka wedke najbardziej polecasz?",
            action = function()
                ESX.ShowNotification("Najlepsza wedka to ta z ~g~Cypress Flats~s~")
            end
        }
    }
})
exports("CreateInteraction", Main.CreateInteraction)
RegisterNUICallback("interact", function(data, cb) 
    local interaction = Interactions[data.interactionId]
    local option = interaction.options[data.actionId]
    if option and option.action then 
        option.action()
    end
    cb("ok")
    SetNuiFocus(false, false)
end)
RegisterNUICallback("close", function(data, cb) 
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "hide",
    })
end)