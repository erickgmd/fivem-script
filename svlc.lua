local isLCRunning = false
local isRPMControlled = false

RegisterServerEvent("toggleRPMControl")
AddEventHandler("toggleRPMControl", function(isEnabled)
    isRPMControlled = isEnabled
end)

AddEventHandler("playerDropped", function()
    isRPMControlled = false -- Reseta o controle de RPM quando o jogador desconecta
end)

RegisterCommand("lc", function(source, args, rawCommand)
    if not isLCRunning then
        TriggerClientEvent("startLC", -1) -- Inicia o script LC no lado do cliente para todos os jogadores
        isLCRunning = true
    else
        TriggerClientEvent("stopLC", -1) -- Para o script LC no lado do cliente para todos os jogadores
        isLCRunning = false
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isRPMControlled then
            local players = GetPlayers()
            for _, player in ipairs(players) do
                local vehicle = GetVehiclePedIsIn(GetPlayerPed(player), false) -- Obtém o veículo do jogador
                if DoesEntityExist(vehicle) then
                    local rpm = GetVehicleCurrentRpm(vehicle) * 10000 -- Obtém o RPM atual do veículo
                    if rpm < 3000 then -- Verifica se o RPM é menor que 3000
                        SetVehicleCurrentRpm(vehicle, 0.3) -- Define o RPM para 3000
                    elseif rpm > 5000 then -- Verifica se o RPM é maior que 5000
                        SetVehicleCurrentRpm(vehicle, 0.5) -- Define o RPM para 5000
                    end
                end
            end
        end
    end
end)
