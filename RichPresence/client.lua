local WaitTime = 100 -- How often do you want to update the status (In MS)


Citizen.CreateThread(function()
	while true do
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
		local StreetHash = GetStreetNameAtCoord(x, y, z)
		Citizen.Wait(WaitTime)
		if StreetHash ~= nil then
			StreetName = GetStreetNameFromHashKey(StreetHash)
			if IsPedOnFoot(PlayerPedId()) and not IsEntityInWater(PlayerPedId()) then
				  if not IsEntityInArea(PlayerPedId(),2631.851,2572.982,45.096,-2449.445,711.613,264.987,false,false,0) then
           if IsPedSprinting(PlayerPedId()) then
					SetRichPresence("Sprinting down "..StreetName)
				elseif IsPedRunning(PlayerPedId()) then
					SetRichPresence("Running down "..StreetName)
				elseif IsPedWalking(PlayerPedId()) then
					SetRichPresence("Walking down "..StreetName)
				elseif IsPedStill(PlayerPedId()) then
					SetRichPresence("Standing on "..StreetName)
				end
				else
				if IsPedRunning(PlayerPedId()) or GetEntitySpeed(PlayerPedId()) > 2.0 then
					SetRichPresence("Running afraid near "..StreetName)
				elseif not IsPedRunning(PlayerPedId()) and GetEntitySpeed(PlayerPedId()) > 1.0 and GetEntitySpeed(PlayerPedId()) < 2.0 then
					SetRichPresence("Exploring alone around "..StreetName)
				else
					SetRichPresence("Resting near "..StreetName)
				end
				end
			elseif IsPedInAnyVehicle(PlayerPedId(), false) and not IsPedInAnyHeli(PlayerPedId()) and not IsPedInAnyPlane(PlayerPedId()) and not IsPedOnFoot(PlayerPedId()) and not IsPedInAnySub(PlayerPedId()) and not IsPedInAnyBoat(PlayerPedId()) then
				local KPH = math.ceil(GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false))*3.6)
				local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))
				if KPH > 50 and not IsPedOnAnyBike(PlayerPedId()) then
					SetRichPresence("Speeding down "..StreetName.." In a "..VehName.." Speed: "..KPH)
				elseif KPH <= 50 and KPH > 0  then
					SetRichPresence("Cruising down "..StreetName.." In a "..VehName.." Speed: "..KPH)
				elseif KPH == 0 then
					SetRichPresence("Parked on "..StreetName.." In a "..VehName)
				elseif KPH > 5 and IsPedOnAnyBike(PlayerPedId()) then
					SetRichPresence("Riding near "..StreetName.." In a "..VehName)
				end
			elseif IsPedInAnyHeli(PlayerPedId()) or IsPedInAnyPlane(PlayerPedId()) then
				local KT = math.ceil(GetEntitySpeed(GetVehiclePedIsUsing(PlayerPedId())) * 1.9438444924406046)
				local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))
				if IsEntityInAir(GetVehiclePedIsUsing(PlayerPedId())) and GetEntityHeightAboveGround(GetVehiclePedIsUsing(PlayerPedId())) > 25.0 and KT>90 then
					SetRichPresence("Flying over "..StreetName.." in a "..VehName)
				elseif IsEntityInAir(GetVehiclePedIsUsing(PlayerPedId())) and GetEntityHeightAboveGround(GetVehiclePedIsUsing(PlayerPedId())) <= 25.0 and KT < 90 and KT>40 and GetLandingGearState(GetVehiclePedIsIn(PlayerPedId(), false)) == 0 then
					SetRichPresence("Landing at "..StreetName.." in a "..VehName)
				elseif GetEntityHeightAboveGround(GetVehiclePedIsUsing(PlayerPedId())) <= 25.0 and KT >= 90 and KT < 120 and GetLandingGearState(GetVehiclePedIsIn(PlayerPedId())) == 0 then
					SetRichPresence("Taking off at "..StreetName.." in a "..VehName)
				else
					SetRichPresence("Landed at "..StreetName.." in a "..VehName)
				end
			elseif IsEntityInWater(PlayerPedId()) then
				SetRichPresence("Swimming around")
			elseif IsPedInAnyBoat(PlayerPedId()) and IsEntityInWater(GetVehiclePedIsUsing(PlayerPedId())) then
				local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))
				SetRichPresence("Sailing around in a "..VehName)
			elseif IsPedInAnySub(PlayerPedId()) and IsEntityInWater(GetVehiclePedIsUsing(PlayerPedId())) then
				SetRichPresence("In a yellow submarine")
			end
		end
	end
end)
