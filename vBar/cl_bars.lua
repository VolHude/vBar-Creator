

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)     
		Citizen.Wait(0)
        MarkerBar()
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
    MarkerBar()
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
    MarkerBar()
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
    ESX.PlayerData.job2 = job2
    MarkerBar()
end)

function OpenPrendreMenu(BarSelected)

    local menuBars = RageUI.CreateMenu(BarSelected.JobName, "Bar", nil, nil, nil, nil, BarSelected.Color.a, BarSelected.Color.b, BarSelected.Color.c, BarSelected.Color.o)

    RageUI.Visible(menuBars, not RageUI.Visible(menuBars))

    while menuBars do
        Citizen.Wait(0)
        RageUI.IsVisible(menuBars, function()
            
            for i = 1, #BarSelected.Item do
                local v = BarSelected.Item[i] 

               RageUI.Button(v.Label, nil, {RightLabel = "~g~"..ESX.Math.GroupDigits(v.Price).."$"}, true , {
					onSelected = function()
                        TriggerServerEvent('vBar:bar', v.Name, v.Price)
                    end,
				})
            end
        end)
        

        if not RageUI.Visible(menuBars) then
            FreezeEntityPosition(PlayerPedId(), false)
            menuBars = RMenu:DeleteType("menuBars", true)
        end
    end
end









function MarkerBar()
    StartJob = true
    Citizen.CreateThread(function()
        while StartJob do
            local InZone = false
            local playerPos = GetEntityCoords(PlayerPedId())
            for i = 1, #Config.Bar do
                local v = Config.Bar[i]

                if ESX.PlayerData.job2.name == v.JobSetJob or ESX.PlayerData.job.name == v.JobSetJob then
                            local dst1 = GetDistanceBetweenCoords(playerPos, v.PosBar, true)
                            if dst1 < 5.0 then
                                InZone = true
                                DrawMarker(6,  v.PosBar.x, v.PosBar.y, v.PosBar.z -0.98, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.7, 0.7, 0.7, 255, 255, 255, 200, 0, 1, 2, 0, nil, nil, 0)
                                if dst1 < 2.0 then
                                     ESX.ShowHelpNotification("Appuyez sur [~r~E~s~] pour acceder au bar")
                                    if IsControlJustReleased(1, 38) then
                                     --   FreezeEntityPosition(PlayerPedId(), true)
                                        OpenPrendreMenu(v)
                                    end
                              end
                       end
                  end
             end
             
            if not InZone then
                Wait(500)
            else
                Wait(1)
            end
        end
    end)
end
