local talkingPlayers = {}

function UpdateTalkingPlayers()
    local localPlayer = PlayerId()
    local localPlayerTalking = NetworkIsPlayerTalking(localPlayer)

    talkingPlayers = {}

    for _, player in ipairs(GetActivePlayers()) do
        local isTalking = NetworkIsPlayerTalking(player)
        if isTalking then
            if player ~= localPlayer then
                table.insert(talkingPlayers, GetPlayerName(player))
            end
        end
    end

    if localPlayerTalking then
        table.insert(talkingPlayers, GetPlayerName(localPlayer))
    end
end

function DisplayTalkingPlayers()
    if #talkingPlayers > 0 then
        local currentlyTalkingText = "Talking:"
        SetTextScale(0.4, 0.5)
        SetTextColour(255, 193, 7, 255)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextCentre(false)
        SetTextDropshadow(2, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 255)
        SetTextEntry("STRING")
        AddTextComponentString(currentlyTalkingText)
        DrawText(0.01, 0.4)

        local text = table.concat(talkingPlayers, "\n")
        SetTextScale(0.4, 0.4)
        SetTextColour(255, 255, 255, 255)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextCentre(false)
        SetTextDropshadow(2, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 255)

        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(0.01, 0.43)
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(200)
        UpdateTalkingPlayers()
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        DisplayTalkingPlayers()
    end
end)
