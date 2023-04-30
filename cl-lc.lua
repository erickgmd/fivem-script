local active = false -- variável para controlar se o script está ativo ou não

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlPressed(0, 32) and IsControlPressed(0, 17) and active then -- verifica se as teclas "espaço" e "w" estão pressionadas e o script está ativo
            SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(PlayerPedId(), false), 1.0) -- define a potência do motor para 100%
            local rpm = GetVehicleCurrentRpm(GetVehiclePedIsIn(PlayerPedId(), false)) -- obtém a rotação atual do motor
            if rpm < 3000 then
                SetVehicleCurrentRpm(GetVehiclePedIsIn(PlayerPedId(), false), 3000) -- limita a rotação mínima do motor para 3000 giros
            elseif rpm > 5000 then
                SetVehicleCurrentRpm(GetVehiclePedIsIn(PlayerPedId(), false), 5000) -- limita a rotação máxima do motor para 5000 giros
            end
        end
    end
end)

RegisterCommand('lc', function() -- registra o comando "/lc"
    active = not active -- alterna o valor da variável "active" entre true e false
    if active then
        TriggerEvent('chat:addMessage', { args = { '^1[Lua Car]', '^2Script ativado!' } }) -- exibe uma mensagem no chat informando que o script foi ativado
    else
        TriggerEvent('chat:addMessage', { args = { '^1[Lua Car]', '^1Script desativado!' } }) -- exibe uma mensagem no chat informando que o script foi desativado
    end
end)